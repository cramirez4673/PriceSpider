
require 'watir'
require 'rspec'
require 'pry'
require 'rubygems'
require 'selenium-webdriver'
require 'rspec/expectations'

$hybrid_product_search_1 = "1 ft Louisville FY8001"
$hybrid_product_search_2 = "10ft Dewalt ladder"

module HybridMenu
	include RSpec::Matchers
	include Selenium

	def hybrid_pg_phone_number
		@browser.div(:class => 'ps-address').div(:index => 0).span(:index => 0)
	end

	def hybrid_pg_float_box
		@browser.ul(class: ["ps-product-finder-result"])
	end

	def hybrid_pg_float_box_result_1
		@browser.ul(class: ["ps-product-finder-result"]).span(index: 0)
	end

	def hybrid_widget_local_seller_1
		@browser.img(class: 'ps-logo ps-local-seller-button', index: 0)
	end

	def hybrid_widget_local_seller_2
		@browser.img(class: 'ps-logo ps-local-seller-button', index: 0)
	end

	def hybrid_product_image_close_button
		@browser.div(title: 'Click to deselect the product')
	end

	def hybrid_widget_online_seller_row_1
		@browser.div(class: 'ps-online-seller-details-wrapper', index: 0)
	end

  def hybrid_widget_updating_spinner
    @browser.div(class: 'ps-distance').span(class: 'ps-distance-stock').span(text: "Updating")
  end

  def hybrid_widget_call_for_stock_label
    @browser.div(class: 'ps-distance').span(class: 'ps-distance-stock').span(text: "Call for stock")
  end
end
