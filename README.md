## WooCommerce POS {{GATEWAY_NAME}} Gateway

{{GATEWAY_DESCRIPTION}}

### Instructions

1. Check [releases](https://github.com/{{GITHUB_USERNAME}}/{{REPO_NAME}}/releases) for the latest version of the plugin.
2. Download the **woocommerce-pos-{{GATEWAY_SLUG}}-gateway.zip** file.
3. Install & activate the plugin via `WP Admin > Plugins > Add New > Upload Plugin`.
4. Go to `WP Admin > WooCommerce POS > Settings > Checkout > enable` the WooCommerce POS {{GATEWAY_NAME}} Gateway.

### Development

To customize this gateway, edit the `wcpos-{{GATEWAY_SLUG}}.php` file and implement your payment processing logic in the `process_payment()` method.

### License

This plugin is licensed under the GNU General Public License v3.0.

