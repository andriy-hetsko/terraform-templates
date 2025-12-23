#!/bin/bash
set -euo pipefail

DEVICE=/dev/nvme1n1
MOUNT=/postgres_data
PG_VER=17
PG_HBA="/etc/postgresql/${PG_VER}/main/pg_hba.conf"
PG_CONF="/etc/postgresql/${PG_VER}/main/postgresql.conf"

# -------------------------
# Wait for disk
# -------------------------
while [ ! -b "$DEVICE" ]; do
  sleep 2
done

# -------------------------
# Filesystem
# -------------------------
if ! blkid "$DEVICE" >/dev/null 2>&1; then
  mkfs.xfs -f "$DEVICE"
fi

mkdir -p "$MOUNT"

if ! mountpoint -q "$MOUNT"; then
  mount "$DEVICE" "$MOUNT"
fi

UUID=$(blkid -s UUID -o value "$DEVICE")
grep -q "$UUID" /etc/fstab || \
  echo "UUID=$UUID $MOUNT xfs defaults,noatime,nofail 0 2" >> /etc/fstab

mount -a

# -------------------------
# Install PostgreSQL repo
# -------------------------
apt update -y
apt install -y curl gnupg lsb-release

echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" \
  > /etc/apt/sources.list.d/pgdg.list

curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg

apt update -y
apt install -y postgresql-${PG_VER}

# -------------------------
# Stop default cluster
# -------------------------
systemctl stop postgresql

# -------------------------
# Prepare data directory
# -------------------------
chown -R postgres:postgres "$MOUNT"
chmod 700 "$MOUNT"

# -------------------------
# Recreate cluster properly
# -------------------------
if pg_lsclusters | grep -q "^${PG_VER}\s\+main"; then
  pg_dropcluster --stop ${PG_VER} main
fi

pg_createcluster ${PG_VER} main --datadir="$MOUNT"

# -------------------------
# PostgreSQL config
# -------------------------
sed -i "s|^#\?listen_addresses.*|listen_addresses = '*'|" "$PG_CONF"
sed -i "s|^#\?data_directory.*|data_directory = '${MOUNT}'|" "$PG_CONF"

echo "password_encryption = 'scram-sha-256'" >> "$PG_CONF"

cat > "$PG_HBA" <<'EOF'
# Local socket
local   all             postgres                                peer
local   all             all                                     peer

# VPC access
host    all             all             10.0.0.0/16              scram-sha-256
EOF


# -------------------------
# Start & enable
# -------------------------
systemctl enable postgresql
systemctl start postgresql
