require 'watir'
require 'rspec'
require 'pry'
require 'rubygems'
require 'selenium-webdriver'
require 'rspec/expectations'

$search_city_1 = "Henderson, NV"
$search_city_2 = "Las Vegas, NV"
$search_city_3 = "Pahrump, NV"
$search_city_4 = "Amsterdam, Netherlands"
$result_city_1 = "Amsterdam, Noord-Holland"
$local_distance_expected = "mi"
$local_stock_expected = "Call for stock"
$local_out_of_stock_expected = "Out of Stock"
$local_see_website_expected = "See Website"
$local_availability_expected = "Call for Availability"
$product_search_1 = "Louisville Step Stand, Silver AY8001"
$product_search_detail_box_expected = "1 ft Louisville AY8001 Aluminum Step Stool , Type IA, 300 lb Load Capacity\nAY8001"
$product_search_detail_box_expected_safari = "\n                    \n                            \n                    \n" +
"                        \n                                \n                    \n                    1 ft Louisville AY8001 Aluminum Step Stool , Type IA, 300 lb Load Capacity AY8001 \n" +
"                    \n                "
$product_search_expected_brand_name = "louisville"
$product_search_expected_product_id = "ay8001"

module EmbeddedHelpers
	include RSpec::Matchers
	include Selenium

	def retailer_amazon_h1_text
		@browser.div(:id => 'titleSection').h1(:index => 0)
	end

	def retailer_walmart_h1_text
		@browser.h1(class: ["prod-ProductTitle", "no-margin", "font-normal heading-a"])
	end

	def retailer_tool_fetch_h1_text
		@browser.div(:class => 'product-name').h1(:index => 0)
	end

	def embedded_pg_buy_button_1
		@browser.button(:class => ["ps-online-buy-button", "available", "ps-online-seller-button"], :index => 0)
	end

	def embedded_pg_details_float_box
		@browser.div(class: ["ps-product-details", "ps-float-box"])
	end

	def embedded_pg_float_box
		@browser.div(class: ["ps-product-finder-item", "ps-float-box"])
	end

	def embedded_pg_float_box_result_1
		@browser.div(:class => 'ps-product-finder-item ps-float-box', :index => 0)
	end

	def embedded_pg_product_search_text_field
		@browser.text_field(class: ["ps-product-finder-textbox", "ps-float-box"])
	end

	def embedded_pg_store_hours
		@browser.element(css: 'div.ps-map-pushpin-select:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(5) > span:nth-child(1) > span:nth-child(2)')
	end

	def embedded_pg_store_open_status
		@browser.element(css: 'div.ps-map-pushpin-select:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(5) > span:nth-child(1) > label:nth-child(1)')
	end

	def embeded_pg_call_for_hours
		@browser.element(css: 'div.ps-map-pushpin-select:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(5) > label:nth-child(1)')
	end

	def embedded_pg_phone_number
		@browser.div(:class => 'ps-address').div(:index => 0).b(:index => 0)
	end

	def embedded_pg_stock_distance
		@browser.div(:class => 'ps-distance').span(:class => 'ps-distance-stock').b(:index => 0)
	end

	def embedded_pg_stock_status
		@browser.div(:class => 'ps-distance').span(:class => 'ps-distance-stock').span(:index => 0)
	end

	def embedded_pg_get_directions_link
		@browser.div(:class => 'ps-get-directions-holder').link(:class => ['ps-get-directions-button ps-accessibility'], :index => 0)
	end

	def embedded_pg_local_logo_1_attribute
		@browser.img(:class => ["ps-logo","ps-local-seller-button"], :index => 0).attribute_value("alt")
	end

	def embedded_pg_local_logo_1_image
		@browser.img(:class => ["ps-logo", "ps-local-seller-button"], :index => 0)
	end

	def embedded_pg_local_logo_1_text
		@browser.div(:class => 'ps-seller', :index => 0)
	end

	def embedded_pg_local_view_online_link_1_attribute
		@browser.link(:class => ["ps-local-seller-button", "ps-accessibility"], :index => 0).attribute_value("aria-label")
	end

	def embedded_pg_online_seller_1_attribute
		@browser.link(:class => 'ps-online-seller-details-wrapper', :index => 0).attribute_value("data-retailer")
	end

	def embedded_pg_local_view_online_link_1
		@browser.link(:class => 'ps-local-seller-button ps-accessibility', :index => 0)
	end

	def embedded_pg_online_retailer_amazon
		@browser.div(:class => 'ps-online-seller-details-wrapper', :data_seller => '2')
	end

	def embedded_pg_online_retailer_walmart
		@browser.div(class: 'ps-online-seller-select', data_seller: '167')
	end

	def embedded_pg_online_retailer_tool_fetch
		@browser.div(class: 'ps-online-seller-select', data_seller: '8509')
	end

	def embedded_pg_online_retailer_tab
		@browser.div(class: 'ps-online-tab')
	end

	def embedded_pg_online_retalier_info_row_1
		@browser.div(:class => 'ps-online-seller-details-wrapper', :index => 1)
	end

	def embedded_pg_online_retalier_info_row_2
		@browser.div(:class => 'ps-online-seller-details-wrapper', :index => 2)
	end

	def embedded_pg_online_retalier_info_row_3
		@browser.div(:class => 'ps-online-seller-details-wrapper', :index => 3)
	end

	def embedded_pg_view_button_1
		@browser.div(:class => 'ps-online-seller-details-wrapper', :index => 1)
	end

	def embedded_pg_view_button_2
		@browser.div(:class => 'ps-online-seller-details-wrapper', :index => 2)
	end

	def embedded_pg_view_button_3
		@browser.div(:class => 'ps-online-seller-details-wrapper', :index => 3)
	end

	def embedded_pg_geo_result_1
		@browser.div(class: 'ps-address')
	end

	def embedded_pg_geo_location_button
		@browser.span(class: 'ps-map-geolocation-button')
	end

	def embedded_pg_wtb_header
		@browser.div(class: ["ps-wtb-header", "ps-float-box"], text: 'Where to Buy')
	end

	def embedded_pg_online_label
		@browser.label(class: 'ps-online-tab-label')
	end

	def embedded_pg_local_label
		@browser.span(:text => 'FIND NEARBY')
	end

  def embedded_pg_search_box
    @browser.text_field(:id => '__ps-map-location-textbox_0')
  end

  def embedded_pg_push_pin_1
    @browser.img(:class => 'ps-pushpin-row', :index => 0)
  end

  def embedded_pg_infobox
    @browser.div(class: 'ps-infobox')
  end

	def embedded_pg_directions_link
		@browser.link(class: 'ps-get-directions-button')
	end
end
