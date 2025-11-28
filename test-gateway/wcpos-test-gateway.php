<?php
/**
 * Plugin Name: WooCommerce POS Test Gateway Gateway
 * Plugin URI: https://github.com/kilbot/test-gateway
 * Description: Test description
 * Version: 0.0.1
 * Author: kilbot
 * License: GNU General Public License v3.0
 * License URI: http://www.gnu.org/licenses/gpl-3.0.html
 * Text Domain: woocommerce-pos-test-gateway-gateway
 */

add_action( 'plugins_loaded', 'woocommerce_pos_test_gateway_gateway_init', 0 );

function woocommerce_pos_test_gateway_gateway_init() {
	if ( ! class_exists( 'WC_Payment_Gateway' ) ) {
		return;
	}

	/**
	 * Localisation
	 */
	load_plugin_textdomain( 'woocommerce-pos-test-gateway-gateway', false, dirname( plugin_basename( __FILE__ ) ) . '/languages' );

	/**
	 * Gateway class
	 */
	class WCPOS_Test_Gateway extends WC_Payment_Gateway {
		/**
		 * Constructor for the gateway.
		 */
		public function __construct() {
			$this->id                 = 'wcpos_test_gateway';
			$this->icon               = '';
			$this->has_fields         = false;
			$this->method_title       = 'Test Gateway Gateway';
			$this->method_description = 'Test description';

			// Load the settings.
			$this->init_form_fields();
			$this->init_settings();

			// Define user set variables
			$this->title       = $this->get_option( 'title' );
			$this->description = $this->get_option( 'description' );

			// only allow in the POS
			$this->enabled = false;

			// Actions
			add_action( 'woocommerce_update_options_payment_gateways_' . $this->id, array( $this, 'process_admin_options' ) );
		}

		public function init_form_fields() {
			$this->form_fields = array(
				'title'       => array(
					'title'       => __( 'Title', 'woocommerce-pos-test-gateway-gateway' ),
					'type'        => 'text',
					'description' => __( 'This controls the title which the user sees during checkout.', 'woocommerce-pos-test-gateway-gateway' ),
					'default'     => __( 'Test Gateway', 'woocommerce-pos-test-gateway-gateway' ),
					'desc_tip'    => true,
				),
				'description' => array(
					'title'       => __( 'Description', 'woocommerce-pos-test-gateway-gateway' ),
					'type'        => 'textarea',
					'description' => __( 'This controls the description which the user sees during checkout.', 'woocommerce-pos-test-gateway-gateway' ),
					'default'     => __( 'Default description', 'woocommerce-pos-test-gateway-gateway' ),
				),
			);
		}

		public function payment_fields() {
			echo wpautop( wptexturize( $this->description ) );
			// Add any custom payment fields here
		}

		public function process_payment( $order_id ) {
			$order = wc_get_order( $order_id );

			// Mark as on-hold (we're awaiting the payment)
			$order->update_status( 'on-hold', __( 'Awaiting payment', 'woocommerce-pos-test-gateway-gateway' ) );

			// Reduce stock levels
			wc_reduce_stock_levels( $order_id );

			// Remove cart
			WC()->cart->empty_cart();

			// Return thankyou redirect
			return array(
				'result'   => 'success',
				'redirect' => $this->get_return_url( $order ),
			);
		}
	}

	/**
	 * Add the Gateway to WooCommerce
	 */
	add_filter(
		'woocommerce_payment_gateways',
		function ( $methods ) {
			$methods[] = 'WCPOS_Test_Gateway';
			return $methods;
		}
	);
}

