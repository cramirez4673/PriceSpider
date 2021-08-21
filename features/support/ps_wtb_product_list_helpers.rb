
require 'watir'
require 'rspec'
require 'pry'
require 'rubygems'
require 'selenium-webdriver'
require 'rspec/expectations'

module ProductList
	include RSpec::Matchers
	include Selenium

  #//// METHODS/LOCATORS ////#
  def product_list_close_modal_icon
    @browser.span(class: 'ps-lightbox-close')
  end

  def product_list_product_name
		@browser.div(class: 'ps-product-details').h1(class: 'ps-product-name')
  end

  def product_list_buy_now_button_1
    @browser.div(ps_sku: '63262')
  end

  def product_list_buy_now_button_2
    @browser.div(ps_sku: '63214')
  end

  def product_list_buy_now_button_3
    @browser.div(ps_sku: '63304')
  end

  #//// VERIFIERS ////#
  def verify_product_list_product_name
    expected_product_name = "ZonePerfect Classic Bars"
    if expect(product_list_product_name.text).to eql (expected_product_name)
      puts "#{true}: Product Name Detail IS A Match"
    else
      expect { raise StandardError, 'Product Name Detail Is NOT Match: Step FAILED'}.should raise_error('Product Name Detail Is NOT Match')
    end
  end
end
