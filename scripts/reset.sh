#!/bin/bash

# Check if user wants to proceed
echo "WARNING: This will delete all WordPress files and database data."
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

# Stop all containers
echo "Stopping all containers..."
docker-compose down

# Remove WordPress files
echo "Removing WordPress files..."
rm -rf wordpress && mkdir wordpress
touch wordpress/.gitkeep

# Remove MySQL data volume
echo "Removing MySQL data volume..."
docker volume rm ${PROJECT_NAME}_mysql_data

# Start containers
echo "Starting containers..."
docker-compose up -d

# Wait for MySQL to be ready
echo "Waiting for MySQL to be ready..."
sleep 10

echo "Reset completed successfully!"
