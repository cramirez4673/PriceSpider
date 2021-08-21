#This test is to verify the embedded tabbed widget phone number
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

RSpec.describe "054: Verification of embedded tabbed widget phone number", ps_054_mega: true, ps_mega_ne: true do
begin
  before(:all) do
    puts "054_wtb_mega_ne_menu_local_seller_phone_test"
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

  it "Sets the city to search" do
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
      sleep(5)
      mega_widget_search_box.flash
      mega_widget_search_box.set ($search_city_4)
      send_keys_enter
      sleep(5)
      embedded_pg_geo_result_1.flash
    else
      mega_widget_search_box.wait_until(&:present?)
      mega_widget_search_box.flash
      mega_widget_search_box.set ($search_city_4)
      send_keys_enter
      sleep(5)
      embedded_pg_geo_result_1.flash
    end
  end

  it "Verifies the stock status with phone number" do
    sleep(5)
    mega_ne_widget_stock_status_3.flash
    @local_stock = mega_ne_widget_stock_status_3.text
    puts @local_stock
    puts "Phone Number To Be Verified: #{mega_ne_widget_pg_phone_number_3.text}"
    mega_ne_widget_pg_phone_number_3.flash
    if expect(@local_stock).to eql ($mega_ne_local_stock_expected) and expect(mega_ne_widget_pg_phone_number_3).to exist
      puts "#{true}: Local Stock Label And Phone Number ARE Displayed"
      mega_ne_widget_pg_phone_number_3.flash
      mega_ne_widget_stock_status_3.flash
    else
      expect { raise StandardError, "Local Stock Label And Phone Number NOT Displayed: Step FAILED"}.should raise_error("Local Stock Label And Phone Number NOT Displayed")
    end
  end
ensure
  after(:all) do
    close_browser
  end
  end
end
