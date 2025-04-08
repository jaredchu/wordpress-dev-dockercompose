#!/bin/bash

# Get current directory and cd to parent
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/.."

# Load environment variables
source ".env"

# Check if user wants to proceed
echo "WARNING: This will seed WordPress with fake content."
read -p "Do you want to proceed? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Operation cancelled."
    exit 1
fi

# Generate fake posts
echo "Generating fake posts..."
CONTENT=$(curl -s 'https://baconipsum.com/api/?type=meat-and-filler&paras=5&format=text')

echo "$CONTENT" | docker-compose exec -T --user www wordpress_service wp post generate \
    --count=10 \
    --post_type=post \
    --post_status=publish \
    --post_title="Sample Post" \
    --post_content

if [ $? -eq 0 ]; then
    echo "Fake content generated successfully!"
else
    echo "Error generating content. Please check your WordPress installation."
    exit 1
fi
