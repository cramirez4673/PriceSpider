#This test is to verify the Mega NE Menu widget
require_relative '../ps_wtb_demo_url_mega_ne_helpers'
require_relative '../ps_wtb_embedded_widget_helpers'
require_relative '../ps_wtb_send_keys_helpers'
require_relative '../ps_wtb_google_maps_pg_helpers'
require_relative '../ps_wtb_windows_helpers'
require_relative '../ps_wtb_wait_helpers'
require_relative '../ps_wtb_amazon_pg_helpers'
require_relative '../ps_wtb_mega_widget_helpers'

RSpec.configure do |c|
  c.include MegaNeWidget
  c.include EmbeddedHelpers
  c.include SendKeys
  c.include WindowsHelpers
  c.include GoogleMaps
  c.include Wait
  c.include Amazon
  c.include Wait
  c.include MegaMenu
end

RSpec.describe "048: Verification of Mega NE Menu widget", ps_048_mega: true, ps_mega_ne: true do
begin
  before(:all) do
    puts "048_wtb_mega_ne_menu_verify_online_and_local_stores_test"
    launch_ps_demo_app_mega_ne
  end

  it "Clicks on the Buy Now button" do
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
      sleep(5)
      mega_widget_buy_now_button.flash
      mega_widget_buy_now_button.click
    else
      mega_widget_buy_now_button.wait_until(&:present?)
      mega_widget_buy_now_button.flash
      mega_widget_buy_now_button.click
    end
  end

  it "Sets the country in text field" do
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
      sleep(5)
      mega_widget_search_box.flash
      mega_widget_search_box.set ($search_city_4)
      send_keys_enter
      sleep(5)
    else
      mega_widget_search_box.wait_until(&:present?)
      mega_widget_search_box.flash
      mega_widget_search_box.set ($search_city_4)
      send_keys_enter
      sleep(5)
    end
  end

  it "Verifies the Find Online section and store is displayed" do
     sleep(5)
     embedded_pg_online_label.wait_until(&:present?)
    if expect(embedded_pg_online_label).to be_truthy
      puts "#{true}: The Find Online Label IS Displayed"
      embedded_pg_online_label.flash
      puts $online_store_1 = mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer")
      puts mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer")
      if (mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer").include? "#{$online_store_1}") == true
        mega_ne_widget_online_retailer_info_row_1.flash
        puts "Online Store #{$online_store_1} Displayed for Online Section"
      else
        expect { raise StandardError, 'No Stores Displayed for Find Online Section: Step FAILED'}.should raise_error('No Stores Displayed for Find Online Section')
      end
    else
      expect { raise StandardError, 'The Find Online Label NOT Displayed: Step FAILED'}.should raise_error('The Find Online Label NOT Displayed')
    end
  end

  it "Verifies the Find Nearby section and store is displayed" do
    if expect(embedded_pg_local_label).to be_truthy
      puts "#{true}: The Find Local Label IS Displayed"
      if expect(mega_ne_widget_local_retailer_logo.present?).to be_truthy
        mega_ne_widget_local_retailer_logo.flash
        store_logo_1 = mega_ne_widget_local_retailer_logo.attribute_value("data-action-retailer")
        puts "#{true}: Local Seller #{store_logo_1} Store Displayed"
      else
        expect { raise StandardError, 'No Stores Displayed for Find Nearby Section: Step FAILED'}.should raise_error('No Stores Displayed for Find Nearby Section')
      end
    else
      expect { raise StandardError, 'The Find Local Label NOT Displayed: Step FAILED'}.should raise_error('The Find Local Label NOT Displayed')
    end
  end
ensure
  after(:all) do
    close_browser
  end
end
end
