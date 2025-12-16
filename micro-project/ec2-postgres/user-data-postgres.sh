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

# Mount
mount "$DEVICE" "$MOUNT"

UUID=$(blkid -s UUID -o value "$DEVICE")
grep -q "$UUID" /etc/fstab || \
  echo "UUID=$UUID $MOUNT xfs defaults,noatime,nofail 0 2" >> /etc/fstab

# Install Postgres
sudo apt update
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg
sudo apt update

sudo apt install postgresql-17
sudo systemctl start postgresql
sudo systemctl stop postgresql


#Init NEW cluster in /postgres_data
if [ ! -f "$MOUNT/PG_VERSION" ]; then
  chown -R postgres:postgres "$MOUNT"
  chmod 700 "$MOUNT"
  sudo -u postgres ${PG_BIN}/initdb -D "$MOUNT"
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
