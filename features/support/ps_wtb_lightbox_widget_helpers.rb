require 'watir'
require 'rspec'
require 'pry'
require 'rubygems'
require 'selenium-webdriver'
require 'rspec/expectations'
require 'webdriver-user-agent'
require 'pp'
require 'typhoeus'

$lightbox_widget_product_selection = "3 ft"
$lightbox_widget_product_selection_safari = "5 ft"
$lightbox_product_search_detail_box_expected = "3 ft DeWalt DXL2010-03 Aluminum Step Ladder, Type IA, 300 lb Load Capacity"
$lightbox_product_search_detail_box_expected_safari = "5 ft DeWalt DXL2010-05 Aluminum Step Ladder, Type IA, 300 lb Load Capacity"


module Lightbox
	include RSpec::Matchers
	include Selenium

	def lightbox_widget_size_selection_dropdown
		@browser.select(id: '__ps-sku-selector-2_0')
	end

	def lightbox_widget_product_selection_dropdown
		@browser.select(id: '__ps-sku-selector-1_0')
	end

	def lightbox_widget_specific_size_select_list_safari_option_4
		@browser.element(xpath: "//*[@id='__ps-sku-selector-2_0']/option[1]")
	end

	def lightbox_widget_specific_size_select_list_safari_option_12
		@browser.element(xpath: "//*[@id='__ps-sku-selector-2_0']/option[2]")
	end

	def lightbox_widget_specific_size_select_list(index)
		specificOption = (index)
		optionsArray = @browser.select_list(:id, '__ps-sku-selector-2_0').options.map(&:value)
		@browser.select_list(:id, '__ps-sku-selector-2_0').select(optionsArray[specificOption])
	end

	def lightbox_widget_random_size_select_list
		randomNumber = rand(0..1)
		optionsArray = @browser.select_list(:id, '__ps-sku-selector-2_0').options.map(&:value)
		@browser.select_list(:id, '__ps-sku-selector-2_0').select(optionsArray[randomNumber])
	end

	def lightbox_widget_specific_product_select_list_safari_option_4
		@browser.element(xpath: "//*[@id='__ps-sku-selector-1_0']/option[4]")
	end

	def lightbox_widget_specific_product_select_list_safari_option_12
		@browser.element(xpath: "//*[@id='__ps-sku-selector-1_0']/option[12]")
	end

	def lightbox_widget_specific_product_select_list(index)
		specificOption = (index)
		optionsArray = @browser.select_list(:id, '__ps-sku-selector-1_0').options.map(&:value)
		@browser.select_list(:id, '__ps-sku-selector-1_0').select(optionsArray[specificOption])
	end

	def lightbox_widget_random_product_select_list
		randomNumber = rand(11..12)
		optionsArray = @browser.select_list(:id, '__ps-sku-selector-1_0').options.map(&:value)
		@browser.select_list(:id, '__ps-sku-selector-1_0').select(optionsArray[randomNumber])
	end

  def lightbox_widget_where_to_buy_link
    @browser.div(class: ["ps-widget", "ps-enabled"])
  end

	def lightbox_widget_online_retailer_amazon
		@browser.div(class: 'ps-online-seller-details-wrapper')
	end

	def lightbox_widget_online_product_drop_down
		@browser.element(xpath: "//*[@id='__ps-sku-selector-1_0']")
	end

	def lightbox_widget_details_float_box
		@browser.h1(class: 'ps-product-name')
	end

	def lightbox_widget_store_hours
		@browser.element(css: 'div.ps-map-pushpin-select:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(5) > span:nth-child(1) > span:nth-child(2)')
	end

	def lightbox_widget_store_open_status
		@browser.element(css: 'div.ps-map-pushpin-select:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(5) > span:nth-child(1) > label:nth-child(1)')
	end

	def lightbox_widget_call_for_hours
		@browser.element(css: 'div.ps-map-pushpin-select:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(5) > label:nth-child(1)')
	end

	#//// VERIFIERS ////#
	def verify_lightbox_product_search_safari_option_4
		kellog_lightbox_product_search_detail_box_expected_4 = "Kellogg's® Special K® Banana Cereal"
		if expect($expected_product_name_4).to eql (kellog_lightbox_product_search_detail_box_expected_4)
			puts "#{true}: Product Detail IS A Match For Option 4"
		else
			expect { raise StandardError, 'Product Detail NOT A Match For Option 4: Step FAILED'}.should raise_error('Product Detail NOT A Match')
		end
	end

	def verify_lightbox_product_search_option_4
		kellog_lightbox_product_search_detail_box_expected_4 = "KELLOGG'S® SPECIAL K® BANANA CEREAL"
		if expect($expected_product_name_4).to eql (kellog_lightbox_product_search_detail_box_expected_4)
			puts "#{true}: Product Detail IS A Match For Option 4"
		else
			expect { raise StandardError, 'Product Detail NOT A Match For Option 4: Step FAILED'}.should raise_error('Product Detail NOT A Match')
		end
	end

	def verify_lightbox_product_search_safari_option_12
		kellog_lightbox_product_search_detail_box_expected_12 = "Kellogg's® Special K® Cherry Nut Protein Meal Bars"
		if expect($expected_product_name_12).to eql (kellog_lightbox_product_search_detail_box_expected_12)
			puts "#{true}: Product Detail IS A Match For Option 12"
		else
			expect { raise StandardError, 'Product Detail NOT A Match For Option 12: Step FAILED'}.should raise_error('Product Detail NOT A Match')
		end
	end

	def verify_lightbox_product_search_option_12
		kellog_lightbox_product_search_detail_box_expected_12 = "KELLOGG'S® SPECIAL K® CHERRY NUT PROTEIN MEAL BARS"
		if expect($expected_product_name_12).to eql (kellog_lightbox_product_search_detail_box_expected_12)
			puts "#{true}: Product Detail IS A Match For Option 12"
		else
			expect { raise StandardError, 'Product Detail NOT A Match For Option 12: Step FAILED'}.should raise_error('Product Detail NOT A Match')
		end
	end
end
