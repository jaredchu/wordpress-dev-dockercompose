#!/bin/bash

# Check if user wants to proceed
echo "WARNING: This will install WordPress and configure it with the settings in .env"
read -p "Do you want to proceed? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Operation cancelled."
    exit 1
fi

# Get current directory and cd to parent
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/.."

# Load environment variables
source ".env"

# Default values
WP_URL=${WP_URL:-"http://localhost"}
WP_TITLE=${WP_TITLE:-"Test Site"}
WP_ADMIN_USER=${WP_ADMIN_USER:-"admin"}
WP_ADMIN_PASSWORD=${WP_ADMIN_PASSWORD:-"admin"}
WP_ADMIN_EMAIL=${WP_ADMIN_EMAIL:-"test@example.com"}

# Install WordPress core
echo "Installing WordPress..."
docker-compose exec --user www wordpress_service wp core install \
  --url="$WP_URL" \
  --title="$WP_TITLE" \
  --admin_user="$WP_ADMIN_USER" \
  --admin_password="$WP_ADMIN_PASSWORD" \
  --admin_email="$WP_ADMIN_EMAIL" || { echo "WordPress installation failed"; exit 1; }

echo "WordPress installed successfully!"
