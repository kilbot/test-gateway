#!/bin/bash

echo "==================================="
echo "Demo: Creating a Cash Payment Gateway"
echo "==================================="
echo ""

# Example values
GATEWAY_NAME="Cash Payment"
GATEWAY_SLUG="cash-payment"
GATEWAY_DESCRIPTION="Accept cash payments in WooCommerce POS"
GATEWAY_DEFAULT_DESCRIPTION="Pay with cash at the point of sale"
GITHUB_USERNAME="kilbot"
REPO_NAME="cash-payment-gateway"
AUTHOR_NAME="kilbot"

# Create demo directory
mkdir -p demo-output/$REPO_NAME

# Convert names
GATEWAY_ID=$(echo "$GATEWAY_SLUG" | tr '-' '_')
GATEWAY_CLASS_NAME="Cash_Payment"
GATEWAY_FUNCTION_PREFIX="cash_payment"

# Copy and process files
cp -r .github demo-output/$REPO_NAME/
cp -r languages demo-output/$REPO_NAME/
cp .gitignore demo-output/$REPO_NAME/

# Process main plugin file
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
    "wcpos-{{GATEWAY_SLUG}}.php" > "demo-output/$REPO_NAME/wcpos-$GATEWAY_SLUG.php"

# Process other files
sed -e "s/{{GATEWAY_NAME}}/$GATEWAY_NAME/g" \
    -e "s/{{GATEWAY_SLUG}}/$GATEWAY_SLUG/g" \
    -e "s/{{GATEWAY_DESCRIPTION}}/$GATEWAY_DESCRIPTION/g" \
    -e "s/{{GITHUB_USERNAME}}/$GITHUB_USERNAME/g" \
    -e "s/{{REPO_NAME}}/$REPO_NAME/g" \
    README.md > "demo-output/$REPO_NAME/README.md"

sed -e "s/{{GATEWAY_SLUG}}/$GATEWAY_SLUG/g" \
    .github/workflows/release.yml > "demo-output/$REPO_NAME/.github/workflows/release.yml"

echo "✅ Demo gateway created in: demo-output/$REPO_NAME/"
echo ""
echo "Files created:"
echo "- wcpos-cash-payment.php (main plugin file)"
echo "- README.md"
echo "- .github/workflows/release.yml"
echo "- .gitignore"

