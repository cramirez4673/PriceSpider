require 'watir'
require 'rspec'
require 'pry'
require 'rubygems'
require 'selenium-webdriver'
require 'rspec/expectations'

$expected_retailer_seller = "Amazon"

module WTB20Helpers
	include RSpec::Matchers
	include Selenium

	#### Methods/Locators ####

	def wtb_2_0_widget_local_retailer_img_3
		@browser.img(class: ["ps-logo", "ps-local-seller-button"], index: 2)
	end

	def wtb_2_0_widget_local_retailer_img_3_attribute
		@browser.img(class: ["ps-logo", "ps-local-seller-button"], index: 0).attribute_value("alt")
	end

	def wtb_2_0_widget_local_retailer_img_2
		@browser.img(class: ["ps-logo", "ps-local-seller-button"], index: 1)
	end

	def wtb_2_0_widget_local_retailer_img_2_attribute
		@browser.img(class: ["ps-logo", "ps-local-seller-button"], index: 0).attribute_value("alt")
	end

	def wtb_2_0_widget_local_retailer_img_1
		@browser.img(class: ["ps-logo", "ps-local-seller-button"], index: 0)
	end

	def wtb_2_0_widget_local_retailer_img_1_attribute
		@browser.img(class: ["ps-logo", "ps-local-seller-button"], index: 0).attribute_value("alt")
	end

	def wtb_2_0_widget_buy_now_button_3
		@browser.button(class: ["ps-online-buy-button available", "ps-online-seller-button"], index: 2)
	end

	def wtb_2_0_widget_buy_now_button_2
		@browser.button(class: ["ps-online-buy-button available", "ps-online-seller-button"], index: 1)
	end

	def wtb_2_0_widget_buy_now_button_1
		@browser.button(class: ["ps-online-buy-button available", "ps-online-seller-button"], index: 0)
	end

	def wtb_2_0_pg_online_retailer_row_3
		@browser.div(class: 'ps-online-seller-details-wrapper', index: 2)
	end

	def wtb_2_0_pg_online_retailer_row_2
		@browser.div(class: 'ps-online-seller-details-wrapper', index: 1)
	end

	def wtb_2_0_pg_online_retailer_row_1
		@browser.div(class: 'ps-online-seller-details-wrapper', index: 0)
	end

	def wtb_2_0_pg_online_retailer_amazon
		@browser.div(class: 'ps-online-seller-details-wrapper', data_seller: '2')
	end

	def wtb_2_0_specific_flavor_select_list(index)
		sleep(2)
		specificOption = (index)
		optionsArray = @browser.select_list(:id, '__ps-sku-selector-1_0').options.map(&:value)
		@browser.select_list(:id, '__ps-sku-selector-1_0').select(optionsArray[specificOption])
	end

	def wtb_2_0_specific_product_select_list(index)
		specificOption = (index)
		optionsArray = @browser.select_list(:id, '__ps-sku-selector-0_0').options.map(&:value)
		@browser.select_list(:id, '__ps-sku-selector-0_0').select(optionsArray[specificOption])
	end

	def wtb_2_0_pg_specific_product_image_choco
		@browser.div(data_item: 'productImage').img(src: "//wwwassets.pricespider.com/product_static/450/10749/10749451.png")
	end

	def wtb_2_0_pg_specific_product_image_vanilla
		@browser.div(data_item: 'productImage').img(src: "//wwwassets.pricespider.com/product_static/450/10761/10761855.png")
	end

	def wtb_2_0_pg_product_image
		@browser.div(data_item: 'productImage')
	end

	def web_2_0_pg_store_hours
		@browser.element(css: "#price-spider-widget > div > div > div > div.ps-wtb-content > div.ps-local-tab > div.ps-local.ps-local-sellers-container > div > div.ps-local-sellers > div:nth-child(1) > div > div:nth-child(2) > div:nth-child(5) > span > span")
	end

	def web_2_0_pg_store_open_status
		@browser.element(css: "#price-spider-widget > div > div > div > div.ps-wtb-content > div.ps-local-tab > div.ps-local.ps-local-sellers-container > div > div.ps-local-sellers > div:nth-child(1) > div > div:nth-child(2) > div:nth-child(5) > span > label")
	end

	def web_2_0_pg_call_for_hours
		@browser.element(css: "#price-spider-widget > div > div > div > div.ps-wtb-content > div.ps-local-tab > div.ps-local.ps-local-sellers-container > div > div.ps-local-sellers > div:nth-child(1) > div > div:nth-child(2) > div:nth-child(5) > span > label")
	end

	def web_2_0_pg_phone_number
		@browser.div(:class => 'ps-address').div(:index => 0).span(:index => 0)
	end

  def wtb_2_0_wtb_online_retailer_seller(online_store_1)
    if online_store_1 == "167"
      return "Walmart"
    elsif online_store_1 == "2"
      return "Amazon"
    elsif online_store_1 == "7058"
      return "CVS"
    elsif online_store_1 == "7059"
      return "Walgreens"
    elsif online_store_1 == "3910005"
      return "Abbot"
    elsif online_store_1 == "4304682"
      return "Jet"
    else
      puts "Can't Find An Online Retailer That Matches"
    end
  end

  def wtb_2_0_wtb_retalier_info_row_1
		@browser.div(class: 'ps-online-seller-select', index: 0)
	end

  def wtb_2_0_wtb_header
    @browser.h1(text: 'Shop online or find a store near you')
  end

	def wtb_2_0_wtb_local_retailer_tab
		@browser.label(class: 'ps-local-tab-label')
	end

	def wtb_2_0_wtb_online_retailer_tab
		@browser.label(class: 'ps-online-tab-label')
	end

	#### Verifies #####

	def verify_specific_product_image_vanilla_is_displayed
		sleep(3)
		if expect(wtb_2_0_pg_specific_product_image_vanilla.present?).to be_truthy
      wtb_2_0_pg_specific_product_image_vanilla.flash
      puts "#{true}: Specific Product Image IS Displayed"
    else
      expect { raise StandardError, 'Specific Product Image NOT Displayed: Step FAILED'}.should raise_error('Specific Product Image NOT Displayed')
    end
	end

	def verify_specific_product_image_choco_is_displayed
		sleep(3)
		if expect(wtb_2_0_pg_specific_product_image_choco.present?).to be_truthy
      wtb_2_0_pg_specific_product_image_choco.flash
      puts "#{true}: Specific Product Image IS Displayed"
    else
      expect { raise StandardError, 'Specific Product Image NOT Displayed: Step FAILED'}.should raise_error('Specific Product Image NOT Displayed')
    end
	end

	def verify_product_image_is_displayed
		if expect(wtb_2_0_pg_product_image.present?).to be_truthy
      wtb_2_0_pg_product_image.flash
      puts "#{true}: Product Image IS Displayed"
    else
      expect { raise StandardError, 'Product Image NOT Displayed: Step FAILED'}.should raise_error('Product Image NOT Displayed')
    end
	end
end
