#This test is to verify the Mega Menu widget geo locator
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

RSpec.describe "038: Verification of Mega Menu widget geo locator", ps_038_mega: true, ps_mega: true do
begin
  before(:all) do
    puts "038_wtb_mega_menu_geo_locator_test"
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

  it "Clicks on the Show Map link" do
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
      sleep(5)
      mega_widget_show_map_link.flash
      mega_widget_show_map_link.click
    else
      sleep(3)
      mega_widget_show_map_link.wait_until(&:present?)
      mega_widget_show_map_link.flash
      mega_widget_show_map_link.click
    end
  end

  it "Verifies the Auto Geo location works" do
    sleep(3)
    embedded_pg_geo_location_button.flash
    embedded_pg_geo_location_button.click
    sleep(10)
    embedded_pg_geo_result_1.flash
    puts @geo_auto_location = embedded_pg_geo_result_1.text
    if expect(@geo_auto_location.include? "Las Vegas, NV 89129").should be_truthy
      puts "#{true}: Geo Auto Locator IS Working As Expected"
    else
      expect { raise StandardError, 'The Geo Auto Locator NOT Working As Expected: Step FAILED'}.should raise_error('The Geo Auto Locator NOT Working As Expected')
    end
  end

  it "Verifies the WTB is Geo located to the selected location" do
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
      sleep(5)
      mega_widget_search_box.flash
      mega_widget_search_box.set ($search_city_3)
      send_keys_enter
      sleep(10)
      embedded_pg_geo_result_1.flash
    else
      mega_widget_search_box.wait_until(&:present?)
      mega_widget_search_box.flash
      mega_widget_search_box.set ($search_city_3)
      send_keys_enter
      sleep(10)
      embedded_pg_geo_result_1.flash
    end
    puts @geo_location_custom = embedded_pg_geo_result_1.text
    if expect(@geo_location_custom.upcase.include? "PAHRUMP, NV").should be_truthy
      puts "#{true}: Geo Custom Locator IS Working As Expected"
    else
      expect { raise StandardError, 'The Geo Custom Locator NOT Working As Expected: Step FAILED'}.should raise_error('The Geo Custom Locator NOT Working As Expected')
    end
  end
ensure
  after(:all) do
    close_browser
  end
end
end
