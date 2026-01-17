#!/bin/bash
#########################################################
# Install MongoDB 5.0 on Amazon Linux 2
##########################################################

echo "=== Starting MongoDB 5 installation at $(date) ==="

# Add MongoDB 5.0 repository for Amazon Linux 2
cat <<EOF > /etc/yum.repos.d/mongodb-org-5.0.repo
[mongodb-org-5.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2/mongodb-org/5.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-5.0.asc
EOF

# Install MongoDB
echo "Installing MongoDB 5.0..."
yum install -y mongodb-org

# Configure MongoDB to listen on all interfaces
echo "Configuring MongoDB..."
sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/g' /etc/mongod.conf

# Start and enable MongoDB
echo "Starting MongoDB service..."
systemctl enable mongod
systemctl start mongod

# Verify MongoDB installation
echo "MongoDB version:"
mongod --version

echo "=== MongoDB installation completed at $(date) ==="
echo " "
echo " "