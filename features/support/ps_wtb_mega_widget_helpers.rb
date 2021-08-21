
require 'watir'
require 'rspec'
require 'pry'
require 'rubygems'
require 'selenium-webdriver'
require 'rspec/expectations'

$product_detail_box_expected = "Oral-B Genius Pro 8000 Rechargeable Electric Toothbrush"
$mega_ne_product_detail_box_expected = "Oral-B Ortho+Interspace Opzetborstels"
$category_detail_box_expected = "Crest"
$mega_ne_category_detail_box_expected = "Oral-B PRO"
$mega_ne_category_detail_box_expected_2 = "Oral-B GENIUS"
$mega_ne_local_stock_expected = "Bel om voorraad"

module MegaMenu
	include RSpec::Matchers
	include Selenium

	def mega_widget_local_tab
		@browser.label(class: 'ps-local-tab-label')
	end

	def mega_widget_local_retailer_logo
		@browser.small(class: 'ps-local-seller-button')
	end

	def mega_ne_widget_pg_product_selector
		@browser.span(class: 'ps-product-selector-title')
	end

	def mega_ne_widget_pg_phone_number_1
		@browser.div(class: 'ps-address', index: 0).div(index: 0).b(index: 0)
	end

	def mega_ne_widget_pg_phone_number_2
		@browser.div(class: 'ps-address', index: 1).div(index: 0).b(index: 0)
	end

	def mega_ne_widget_pg_phone_number_3
		@browser.div(class: 'ps-address', index: 2).div(index: 0).b(index: 0)
	end

	def mega_ne_widget_stock_status_1
		@browser.div(class: 'ps-distance', index: 0).span(class: 'ps-distance-stock', index: 0).span(index: 0)
	end

	def mega_ne_widget_stock_status_2
		@browser.div(class: 'ps-distance', index: 1).span(class: 'ps-distance-stock', index: 0).span(index: 0)
	end

	def mega_ne_widget_stock_status_3
		@browser.div(class: 'ps-distance', index: 2).span(class: 'ps-distance-stock', index: 0).span(index: 0)
	end

	def mega_widget_stock_distance_0
		@browser.div(:class => 'ps-distance').span(:class => 'ps-distance-stock', :index => 0).b(:index => 0)
	end

	def mega_widget_stock_distance_1
		# @browser.div(:class => 'ps-distance').span(:class => 'ps-distance-stock', :index => 0).b(:index => 0)
		@browser.element(xpath: "//span[@class='ps-distance-stock']//b", index: 0)
	end

	def mega_widget_stock_distance_2
		# @browser.div(:class => 'ps-distance').span(:class => 'ps-distance-stock', :index => 1).b(:index => 1)
		@browser.element(xpath: "//span[@class='ps-distance-stock']//b", index: 1)
	end

	def mega_widget_stock_distance_3
		# @browser.div(:class => 'ps-distance').span(:class => 'ps-distance-stock', :index => 2).b(:index => 2)
		@browser.element(xpath: "//span[@class='ps-distance-stock']//b", index: 2)
	end

	def mega_widget_category_drop_down
		@browser.div(class: ["ps-menu", "ps-menu-Category"])
	end

	def mega_widget_category_detail_1
		@browser.small(class: ["ps-sku-select-button", "event_buy_now_choose_product"], index: 0)
	end

	def mega_widget_category_detail_2
		@browser.small(class: ["ps-sku-select-button", "event_buy_now_choose_product"], index: 1)
	end

	def mega_widget_category_detail_3
		@browser.small(class: ["ps-sku-select-button", "event_buy_now_choose_product"], index: 2)
	end

	def mega_widget_product_detail
		@browser.span(xpath: "//*[@class='ps-product ps-sku-select-button event_buy_now_choose_product']")
	end

	def mega_widget_product_drop_down
		@browser.div(class: ["ps-menu", "ps-menu-Product", "Title"])
	end

	def mega_widget_store_open_status
		@browser.element(css: 'div.ps-map-pushpin-select:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(4) > div:nth-child(2) > span:nth-child(1) > label:nth-child(1)')
	end

	def mega_widget_call_for_hours
		@browser.element(css: 'div.ps-map-pushpin-select:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(5) > span:nth-child(1) > span:nth-child(2)')
	end

	def mega_widget_store_hours
		@browser.element(css: 'div.ps-map-pushpin-select:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(4) > div:nth-child(2) > span:nth-child(1) > span:nth-child(2)')
	end

	def mega_widget_get_directions_link
		@browser.link(class: 'ps-get-directions-button')
	end

	def mega_widget_local_retailer_view_online_link_1
		@browser.span(text: 'View Online')
	end

	def mega_ne_widget_local_retailer_view_online_link_1
		@browser.span(text: 'Online bekijken')
	end

	def mega_ne_widget_local_retailer_logo
		@browser.img(class: 'ps-logo ps-local-seller-button event_buy_now_eretailer_exit', index: 0)
	end

	def mega_ne_widget_local_retailer_img
		@browser.img(class: ["ps-logo", "ps-local-seller-button"], index: 0)
	end

	def mega_widget_local_retailer_img
		@browser.img(class: ["ps-logo", "ps-local-seller-button"], index: 0)
	end

	def mega_widget_local_retailer_img_2
		@browser.img(class: ["ps-logo", "ps-local-seller-button"], index: 1)
	end

	def mega_widget_local_retailer_img_3
		@browser.img(class: ["ps-logo", "ps-local-seller-button"], index: 2)
	end

	def mega_widget_local_retailer_img_attirbute
		@browser.element(xpath: "//*[contains(@class, 'ps-local-seller-button')][2]")
	end

	def mega_widget_local_retailer_img_attirbute_2
		@browser.element(class: 'ps-local-seller-button', index: 1)
	end

	def mega_widget_local_retailer_img_attirbute_3
		@browser.element(class: 'ps-local-seller-button', index: 2)
	end

  def mega_widget_buy_now_button
    @browser.div(class: ["ps-widget", "event_buy_now_choose_product", "event_buy_now", "ps-enabled"])
  end

  def mega_widget_search_box
    @browser.text_field(class: 'ps-map-location-textbox')
  end

  def mega_widget_show_map_link
    @browser.small(class: 'ps-show')
  end

	def mega_ne_widget_online_retailer_info_row_1
		@browser.div(class: 'ps-online-seller-details-wrapper', index: 0)
	end

	def mega_ne_widget_online_retailer_info_row_2
		@browser.div(class: 'ps-online-seller-details-wrapper', index: 1)
	end

	def mega_ne_widget_online_retailer_info_row_3
		@browser.div(class: 'ps-online-seller-details-wrapper', index: 2)
	end

	def mega_widget_online_retailer_info_row_1
		@browser.div(class: ["ps-online-seller-select", "event_buy_now_eretailer_exit"], index: 0)
	end

	def mega_widget_online_retailer_info_row_2
		@browser.div(class: ["ps-online-seller-select", "event_buy_now_eretailer_exit"], index: 1)
	end

	def mega_widget_online_retailer_info_row_3
		@browser.div(class: ["ps-online-seller-select", "event_buy_now_eretailer_exit"], index: 2)
	end

	def mega_widget_online_retailer_info_row_4
		@browser.div(class: ["ps-online-seller-select", "event_buy_now_eretailer_exit"], index: 3)
	end

	def mega_widget_buy_now_button_1
		@browser.button(class: ["ps-online-buy-button available", "ps-online-seller-button"], index: 0)
	end

	def mega_widget_buy_now_button_2
		@browser.button(class: ["ps-online-buy-button available", "ps-online-seller-button"], index: 1)
	end

	def mega_widget_buy_now_button_3
		@browser.button(class: ["ps-online-buy-button available", "ps-online-seller-button"], index: 2)
	end

	def mega_widget_buy_now_button_4
		@browser.button(class: ["ps-online-buy-button available", "ps-online-seller-button"], index: 3)
	end
end
