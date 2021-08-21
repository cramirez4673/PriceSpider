#This test is to verify the Megae Menu widget
require_relative '../ps_wtb_demo_url_mega_helpers'
require_relative '../ps_wtb_embedded_widget_helpers'
require_relative '../ps_wtb_send_keys_helpers'
require_relative '../ps_wtb_google_maps_pg_helpers'
require_relative '../ps_wtb_windows_helpers'
require_relative '../ps_wtb_wait_helpers'
require_relative '../ps_wtb_amazon_pg_helpers'
require_relative '../ps_wtb_mega_widget_helpers'

RSpec.configure do |c|
  c.include MegaWidget
  c.include EmbeddedHelpers
  c.include SendKeys
  c.include WindowsHelpers
  c.include GoogleMaps
  c.include Wait
  c.include Amazon
  c.include Wait
  c.include MegaMenu
end

RSpec.describe "037: Verification of Mega Menu widget", ps_037_mega: true, ps_mega: true do
begin
  before(:all) do
    puts "037_wtb_mega_menu_verify_online_and_local_stores_test"
    launch_ps_demo_app_mega
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

  it "Verifies the Find Online section and store is displayed" do
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
      sleep(5)
    else
      sleep(3)
      embedded_pg_online_label.wait_until(&:present?)
    end
    if expect(embedded_pg_online_label).to be_truthy
      puts "#{true}: The Find Online Label IS Displayed"
      embedded_pg_online_label.flash
      puts $online_store_1 = mega_widget_online_retailer_info_row_1.attribute_value("data-retailer")
      puts mega_widget_online_retailer_info_row_1.attribute_value("data-retailer")
      if (mega_widget_online_retailer_info_row_1.attribute_value("data-retailer").include? "#{$online_store_1}") == true
        mega_widget_online_retailer_info_row_1.flash
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
      if expect(mega_widget_local_retailer_img).to exist
        mega_widget_local_retailer_img.flash
        puts "#{true}: Local Seller Store Displayed"
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
