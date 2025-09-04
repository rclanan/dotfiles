#!/bin/bash

# PostgreSQL Setup Script
# Installs and configures PostgreSQL for development

set -e

echo "=== PostgreSQL Development Setup ==="

# Install PostgreSQL
echo "Installing PostgreSQL..."
sudo pacman -S --noconfirm --needed postgresql

# Initialize PostgreSQL database
echo "Initializing PostgreSQL database..."
sudo -u postgres initdb -D /var/lib/postgres/data

# Enable and start PostgreSQL service
echo "Starting PostgreSQL service..."
sudo systemctl enable postgresql.service
sudo systemctl start postgresql.service

# Create PostgreSQL user
echo "Setting up PostgreSQL user..."
echo "Creating a PostgreSQL user with your username..."
if ! sudo -u postgres psql -tAc "SELECT 1 FROM pg_roles WHERE rolname='$USER'" | grep -q 1; then
    echo "Creating PostgreSQL user: $USER"
    sudo -u postgres createuser --createdb --createrole --superuser "$USER"
    echo "Please set a password for your PostgreSQL user:"
    sudo -u postgres psql -c "ALTER USER $USER PASSWORD null;" # Will prompt for password
else
    echo "PostgreSQL user $USER already exists"
fi

echo ""
echo "=== PostgreSQL Setup Complete! ==="
echo ""
echo "PostgreSQL Version: $(postgres --version)"
echo ""
echo "Test your setup:"
echo "  psql -U $USER -d postgres"
echo ""
echo "Useful commands:"
echo "  sudo systemctl status postgresql.service"
echo "  sudo systemctl restart postgresql.service"
echo "  sudo -u postgres psql  # Admin access"
