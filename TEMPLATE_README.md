# WooCommerce POS Gateway Template

This is a template repository for creating new WooCommerce POS gateway plugins.

## Using this Template

### Option 1: Automated Script (Recommended) ✨

The easiest way to create a new gateway is using the included automation script:

1. Clone this repository
2. Run the generator script:
   ```bash
   ./create-gateway.sh
   ```
3. Follow the prompts to enter your gateway details
4. The script will automatically:
   - Replace all placeholders with your values
   - Create the properly named plugin file
   - Set up your new gateway in a directory of your choice

### Option 2: GitHub Template (Manual Setup)

If you prefer to use GitHub's template feature:

1. Click the "Use this template" button at the top of this repository
2. Enter your new repository name
3. Clone your new repository
4. **Manually** replace all placeholders in the files:
   - `{{GATEWAY_NAME}}` - Your gateway name (e.g., "Cash Payment")
   - `{{GATEWAY_SLUG}}` - Your gateway slug (e.g., "cash-payment")
   - `{{GATEWAY_DESCRIPTION}}` - Your gateway description
   - `{{GATEWAY_DEFAULT_DESCRIPTION}}` - Default checkout description
   - `{{GITHUB_USERNAME}}` - Your GitHub username
   - `{{REPO_NAME}}` - Your repository name
   - `{{AUTHOR_NAME}}` - Your name
   - `{{GATEWAY_ID}}` - Gateway ID (slug with underscores)
   - `{{GATEWAY_CLASS_NAME}}` - PHP class name
   - `{{GATEWAY_FUNCTION_PREFIX}}` - Function prefix

5. Rename `wcpos-{{GATEWAY_SLUG}}.php` to match your gateway slug

**Note:** This method requires manual find-and-replace in your editor for all placeholders.

## Template Structure

- `wcpos-{{GATEWAY_SLUG}}.php` - Main plugin file
- `.github/workflows/release.yml` - Automated release workflow
- `README.md` - Plugin documentation
- `languages/` - Localization files directory
- `.gitignore` - Git ignore file

## Features

- Simple "hello world" gateway structure
- WooCommerce POS compatibility (gateway only enabled in POS)
- Automated GitHub releases when version changes
- Internationalization support
- Clean, minimal code structure

## Customization

After generating your gateway, customize the `process_payment()` method in the main plugin file to implement your payment logic.

## License

GNU General Public License v3.0

