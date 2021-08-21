#Test is to verify the embedded dual widget product search for online seller
require_relative '../ps_wtb_demo_url_embedded_dual_helpers'
require_relative '../ps_wtb_embedded_widget_helpers'
require_relative '../ps_wtb_send_keys_helpers'
require_relative '../ps_wtb_google_maps_pg_helpers'
require_relative '../ps_wtb_windows_helpers'
require_relative '../ps_wtb_wait_helpers'
require_relative '../ps_wtb_amazon_pg_helpers'

RSpec.configure do |c|
  c.include EmbeddedDualWidget
  c.include EmbeddedHelpers
  c.include SendKeys
  c.include WindowsHelpers
  c.include GoogleMaps
  c.include Wait
  c.include Amazon
  c.include Wait
end

RSpec.describe "010: Verification of embedded dual widget product search online seller", ps_010_embedded_dual: true, ps_embedded_dual: true do
begin
  before(:all) do
    puts "010_wtb_embedded_dual_product_search_online_seller_test"
    launch_ps_demo_app_embedded_dual
  end

  it "Verifies the Find Online section is displayed" do
    embedded_pg_wtb_header.wait_until(&:present?)
    if expect(embedded_pg_online_label).to be_truthy
      puts "#{true}: The Find Online Label IS Displayed"
      embedded_pg_online_label.flash
    else
      expect { raise StandardError, 'The Find Online Label NOT Displayed: Step FAILED'}.to raise_error('The Find Online Label NOT Displayed')
    end
  end
#SEARCH FIELD RESULT TEST
  it "Verifies the specific product searched is displayed online and locally" do
    embedded_pg_product_search_text_field.flash
    embedded_pg_product_search_text_field.set ($product_search_1)
    embedded_pg_float_box.wait_until(&:present?)
    embedded_pg_float_box.flash
    embedded_pg_float_box_result_1.flash
    embedded_pg_float_box_result_1.click
  end

  it "Verifies the product detail in the detail float box" do
    sleep(3)
    puts "Product Detail Box Text: #{embedded_pg_details_float_box.text}"
    if (embedded_pg_details_float_box.text) == ($product_search_detail_box_expected) or (embedded_pg_details_float_box.text) == ($product_search_detail_box_expected_safari)
      puts "#{true}: Product Detail IS A Match"
    else
      expect { raise StandardError, 'Product Detail NOT A Match: Step FAILED'}.to raise_error('Product Detail NOT A Match')
    end
  end
#PRODUCT SEARCH RESULT ONLINE VERIFICATION
  it "Verifies the product reslut online" do
    if embedded_pg_online_retailer_amazon.present?
      embedded_pg_online_retailer_amazon.flash
      embedded_pg_online_retailer_amazon.click
      if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
        sleep(5)
        use_first_window
      else
        sleep(5)
        use_last_window
      end
      $retailer_url = @browser.url
      puts "Retailers URL: #{$retailer_url}"
      puts "Retailer Page H1 Text: #{retailer_amazon_h1_text.text}"
#PRODUCT VERIFICATION
      if expect(retailer_amazon_h1_text.text.to_s.downcase()).to include($product_search_expected_brand_name) or expect(retailer_amazon_h1_text.text.to_s.downcase()).to include($product_search_expected_product_id)
        puts "#{true}: Retailer Site Amazon INCLUDES Expected Product"
      else
        expect { raise StandardError, 'Retailer Site Amazon Does NOT Include Expected Product: Step FAILED'}.to raise_error('Retailer Site Amazon Does NOT Include Expected Product')
      end
    elsif embedded_pg_online_retailer_walmart.present?
      embedded_pg_online_retailer_walmart.flash
      embedded_pg_online_retailer_walmart.click
      sleep(5)
      use_last_window
      $retailer_url = @browser.url
      puts "Retailers URL: #{$retailer_url}"
      puts "Retailer Page H1 Text: #{retailer_walmart_h1_text.text}"
#PRODUCT VERIFICATION
      if expect(retailer_walmart_h1_text.text.to_s.downcase()).to include($product_search_expected_brand_name) or expect(retailer_walmart_h1_text.text.to_s.downcase()).to include($product_search_expected_product_id)
        puts "#{true}: Retailer Site Walmart INCLUDES Expected Product"
      else
        expect { raise StandardError, 'Retailer Site Walmart Does NOT Include Expected Product: Step FAILED'}.to raise_error('Retailer Site Walmart Does NOT Include Expected Product')
      end
    elsif embedded_pg_online_retailer_tool_fetch.present?
      embedded_pg_online_retailer_tool_fetch.flash
      embedded_pg_online_retailer_tool_fetch.click
      sleep(5)
      use_last_window
      $retailer_url = @browser.url
      puts "Retailers URL: #{$retailer_url}"
      puts "Retailer Page H1 Text: #{retailer_tool_fetch_h1_text.text}"
#PRODUCT VERIFICATION
      if expect(retailer_tool_fetch_h1_text.text.to_s.downcase()).to include($product_search_expected_brand_name) or expect(retailer_tool_fetch_h1_text.text.to_s.downcase()).to include($product_search_expected_product_id)
        puts "#{true}: Retailer Site Tool Fetch INCLUDES Expected Product"
      else
        expect { raise StandardError, 'Retailer Site Tool Fetch Does NOT Include Expected Product: Step FAILED'}.to raise_error('Retailer Site Tool Fetch Does NOT Include Expected Product')
      end
    else
      puts "No Expected Retailer Displayed"
    end
  end
ensure
  after(:all) do
    close_browser
  end
end
end
