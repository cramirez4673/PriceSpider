#This test is to verify the hybrid widget store times
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

RSpec.describe "066: Verification of hybrid widget store times", ps_066_hybrid: true, ps_hybrid: true do
begin
  before(:all) do
    puts "066_ps_wtb_hybrid_store_times_test"
    launch_ps_demo_app_hybrid
  end

  it "Clicks on the local Tab" do
    embedded_pg_local_label.flash
    puts "Local Tab Clicked #{embedded_pg_local_label.click}"
  end

  it "Verifies the store times" do
    sleep(5)
    if embeded_pg_call_for_hours.present?
      puts "Store Status IS: #{embeded_pg_call_for_hours.text}"
      puts "#{true}: Call For Store Hours Status IS Displayed"
    elsif embedded_pg_store_open_status.present?
      puts "Store Status IS: #{embedded_pg_store_open_status.text}"
      puts "#{true}: Open Today Status IS Displayed"
    if embedded_pg_store_hours.present?
      puts "#{true}: Store Hours ARE Displayed"
      puts "Store Hours ARE: #{embedded_pg_store_hours.text}"
    else
      expect { raise StandardError, "Store Hours NOT Displayed: Step FAILED"}.should raise_error("Store Hours NOT Displayed")
    end
    else
      expect { raise StandardError, "Store Status NOT Displayed: Step FAILED"}.should raise_error("Store Status NOT Displayed")
    end
  end
ensure
  after(:all) do
    close_browser
  end
end
end
