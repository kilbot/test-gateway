#!/bin/bash

# WooCommerce POS Gateway Generator Script
# This script creates a new WooCommerce POS gateway plugin from the template

echo "==================================="
echo "WooCommerce POS Gateway Generator"
echo "==================================="
echo ""

# Prompt for plugin details
read -p "Enter gateway name (e.g., 'Cash Payment'): " GATEWAY_NAME
read -p "Enter gateway slug (e.g., 'cash-payment'): " GATEWAY_SLUG
read -p "Enter gateway description: " GATEWAY_DESCRIPTION
read -p "Enter default checkout description: " GATEWAY_DEFAULT_DESCRIPTION
read -p "Enter your GitHub username: " GITHUB_USERNAME
read -p "Enter repository name (e.g., 'cash-payment-gateway'): " REPO_NAME
read -p "Enter author name: " AUTHOR_NAME
read -p "Enter target directory path (or press Enter for current directory): " TARGET_DIR

# Set default target directory if not provided
if [ -z "$TARGET_DIR" ]; then
    TARGET_DIR="."
fi

# Create target directory
TARGET_PATH="$TARGET_DIR/$REPO_NAME"
mkdir -p "$TARGET_PATH"

# Convert names to different formats
GATEWAY_ID=$(echo "$GATEWAY_SLUG" | tr '-' '_')
GATEWAY_CLASS_NAME=$(echo "$GATEWAY_NAME" | sed 's/ /_/g' | sed 's/_\([a-z]\)/\U\1/g' | sed 's/^[a-z]/\U&/')
GATEWAY_FUNCTION_PREFIX=$(echo "$GATEWAY_SLUG" | tr '-' '_')

# Copy template files
cp -r .github "$TARGET_PATH/"
cp -r languages "$TARGET_PATH/" 2>/dev/null || mkdir -p "$TARGET_PATH/languages"
cp .gitignore "$TARGET_PATH/"

# Process and copy main plugin file
sed -e "s/{{GATEWAY_NAME}}/$GATEWAY_NAME/g" \
    -e "s/{{GATEWAY_SLUG}}/$GATEWAY_SLUG/g" \
    -e "s/{{GATEWAY_DESCRIPTION}}/$GATEWAY_DESCRIPTION/g" \
    -e "s/{{GATEWAY_DEFAULT_DESCRIPTION}}/$GATEWAY_DEFAULT_DESCRIPTION/g" \
    -e "s/{{GITHUB_USERNAME}}/$GITHUB_USERNAME/g" \
    -e "s/{{REPO_NAME}}/$REPO_NAME/g" \
    -e "s/{{AUTHOR_NAME}}/$AUTHOR_NAME/g" \
    -e "s/{{GATEWAY_ID}}/$GATEWAY_ID/g" \
    -e "s/{{GATEWAY_CLASS_NAME}}/$GATEWAY_CLASS_NAME/g" \
    -e "s/{{GATEWAY_FUNCTION_PREFIX}}/$GATEWAY_FUNCTION_PREFIX/g" \
    "wcpos-{{GATEWAY_SLUG}}.php" > "$TARGET_PATH/wcpos-$GATEWAY_SLUG.php"

# Process README
sed -e "s/{{GATEWAY_NAME}}/$GATEWAY_NAME/g" \
    -e "s/{{GATEWAY_SLUG}}/$GATEWAY_SLUG/g" \
    -e "s/{{GATEWAY_DESCRIPTION}}/$GATEWAY_DESCRIPTION/g" \
    -e "s/{{GITHUB_USERNAME}}/$GITHUB_USERNAME/g" \
    -e "s/{{REPO_NAME}}/$REPO_NAME/g" \
    README.md > "$TARGET_PATH/README.md"

# Process GitHub workflow
sed -e "s/{{GATEWAY_SLUG}}/$GATEWAY_SLUG/g" \
    .github/workflows/release.yml > "$TARGET_PATH/.github/workflows/release.yml"

echo ""
echo "✅ Gateway plugin created successfully!"
echo "📁 Location: $TARGET_PATH"
echo ""
echo "Next steps:"
echo "1. cd $TARGET_PATH"
echo "2. git init"
echo "3. git add ."
echo "4. git commit -m 'Initial commit'"
echo "5. Create a new repository on GitHub: https://github.com/new"
echo "6. git remote add origin https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"
echo "7. git push -u origin main"
echo ""
echo "To create a release:"
echo "- Update the Version number in wcpos-$GATEWAY_SLUG.php"
echo "- Commit and push to main branch"
echo "- GitHub Actions will automatically create a release with the plugin ZIP"

