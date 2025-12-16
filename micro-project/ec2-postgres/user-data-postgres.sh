#!/bin/bash
set -e

DEVICE=/dev/nvme1n1
MOUNT=/postgres_data
PG_HBA="/etc/postgresql/17/main/pg_hba.conf"
PG_CONF="/etc/postgresql/17/main/postgresql.conf"

# Wait for disk
while [ ! -b "$DEVICE" ]; do
  sleep 2
done

# Create filesystem if not exists
if ! blkid "$DEVICE"; then
  mkfs.xfs -f "$DEVICE"
fi

mkdir -p "$MOUNT"
chown -R postgres:postgres /postgres_data


# Mount (idempotent)
if ! mountpoint -q "$MOUNT"; then
  mount "$DEVICE" "$MOUNT"
fi

UUID=$(blkid -s UUID -o value "$DEVICE")
grep -q "$UUID" /etc/fstab || \
  echo "UUID=$UUID $MOUNT xfs defaults,noatime,nofail 0 2" >> /etc/fstab

systemctl daemon-reload
mount -a

# Install Postgres
apt update -y
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc |  gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/postgresql.gpg
apt update -y

apt install postgresql-17 -y
sudo -u postgres /usr/lib/postgresql/17/bin/initdb -D /postgres_data
systemctl start postgresql
systemctl stop postgresql


# Recreate cluster if needed
if ! pg_lsclusters | grep -q "17.*main"; then
  pg_createcluster 17 main --datadir="$MOUNT"
fi

#Configure PostgreSQL
sed -i "s|^#\?data_directory.*|data_directory = '${MOUNT}'|" "$PG_CONF"
sed -i "s|^#\?listen_addresses.*|listen_addresses = '*'|" "$PG_CONF"
echo "password_encryption = 'scram-sha-256'" >> "$PG_CONF"

# Minimal secure rules:
cat > "$PG_HBA" <<'EOF'
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# Local socket access
local   all             postgres                                peer
local   all             all                                     peer

# Allow from VPC CIDR only (CHANGE TO YOUR VPC CIDR)
host    all             all             10.0.0.0/16              scram-sha-256
EOF

systemctl enable postgresql
systemctl start postgresql