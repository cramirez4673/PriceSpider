#This test is to verify the lightbox widget geo locator
require_relative '../ps_wtb_demo_url_lightbox_dual_helpers'
require_relative '../ps_wtb_embedded_widget_helpers'
require_relative '../ps_wtb_send_keys_helpers'
require_relative '../ps_wtb_google_maps_pg_helpers'
require_relative '../ps_wtb_windows_helpers'
require_relative '../ps_wtb_wait_helpers'
require_relative '../ps_wtb_amazon_pg_helpers'
require_relative '../ps_wtb_lightbox_widget_helpers'

RSpec.configure do |c|
  c.include LightboxDualWidget
  c.include EmbeddedHelpers
  c.include SendKeys
  c.include WindowsHelpers
  c.include GoogleMaps
  c.include Wait
  c.include Amazon
  c.include Wait
  c.include Lightbox
end

RSpec.describe "020: Verification of the lightbox widget geo locator", ps_020_lightbox_dual: true, ps_lightbox_dual: true do
begin
  before(:all) do
    puts "020_wtb_lightbox_dual_geo_locator_test"
    launch_ps_demo_app_lightbox_dual
  end

  it "Clicks on the Where To Buy link" do
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
      sleep(5)
      lightbox_widget_where_to_buy_link.flash
      lightbox_widget_where_to_buy_link.click
    else
      lightbox_widget_where_to_buy_link.wait_until(&:present?)
      lightbox_widget_where_to_buy_link.flash
      lightbox_widget_where_to_buy_link.click
    end
  end

  it "Verifies the Auto Geo location works" do
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
      sleep(5)
      embedded_pg_geo_location_button.wait_until_present
      embedded_pg_geo_location_button.flash
      embedded_pg_geo_location_button.click
      sleep(10)
      embedded_pg_geo_result_1.flash
    else
      embedded_pg_local_label.wait_until(&:present?)
      embedded_pg_geo_location_button.wait_until_present
      embedded_pg_geo_location_button.flash
      embedded_pg_geo_location_button.click
      sleep(10)
      embedded_pg_geo_result_1.flash
      puts @geo_auto_location = embedded_pg_geo_result_1.text
      puts @geo_auto_location_2 = @geo_auto_location[-21,8]
      if expect(@geo_auto_location_2.include? "#{@geo_auto_location_2}").to be_truthy
        puts "#{true}: Geo Auto Locator IS Working As Expected"
      else
        expect { raise StandardError, 'The Geo Auto Locator NOT Working As Expected: Step FAILED'}.should raise_error('The Geo Auto Locator NOT Working As Expected')
      end
    end
  end

  it "Verifies the WTB is Geo located to the selected location" do
    embedded_pg_search_box.wait_until(&:present?)
    embedded_pg_search_box.flash
    embedded_pg_search_box.set ($search_city_3)
    send_keys_enter
    sleep(10)
    puts @geo_location_custom = embedded_pg_geo_result_1.text
    if expect(@geo_location_custom.upcase.include? "PAHRUMP, NV").to be_truthy
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
