#This test is to verify the hybrid widget geo locator
require_relative '../ps_wtb_demo_url_hybrid_helpers'
require_relative '../ps_wtb_embedded_widget_helpers'
require_relative '../ps_wtb_send_keys_helpers'
require_relative '../ps_wtb_google_maps_pg_helpers'
require_relative '../ps_wtb_windows_helpers'
require_relative '../ps_wtb_wait_helpers'
require_relative '../ps_wtb_amazon_pg_helpers'

RSpec.configure do |c|
  c.include HybridWidget
  c.include EmbeddedHelpers
  c.include SendKeys
  c.include WindowsHelpers
  c.include GoogleMaps
  c.include Wait
  c.include Amazon
  c.include Wait
end

RSpec.describe "060: Verification of hybrid widget geo locator", ps_060_hybrid: true, ps_hybrid: true do
begin
  before(:all) do
    puts "060_ps_wtb_hybrid_geo_locator_test"
    launch_ps_demo_app_hybrid
  end

  it "Clicks on the local Tab" do
    embedded_pg_local_label.flash
    puts "Local Tab Clicked #{embedded_pg_local_label.click}"
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
    embedded_pg_search_box.wait_until(&:present?)
    embedded_pg_search_box.flash
    embedded_pg_search_box.set ($search_city_3)
    send_keys_enter
    sleep(10)
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
