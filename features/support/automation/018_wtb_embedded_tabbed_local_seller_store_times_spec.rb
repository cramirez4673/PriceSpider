#This test is to verify the embedded tabbed widget store times
require_relative '../ps_wtb_demo_url_embedded_tabbed_helpers'
require_relative '../ps_wtb_embedded_widget_helpers'
require_relative '../ps_wtb_send_keys_helpers'
require_relative '../ps_wtb_google_maps_pg_helpers'
require_relative '../ps_wtb_windows_helpers'
require_relative '../ps_wtb_wait_helpers'
require_relative '../ps_wtb_amazon_pg_helpers'

RSpec.configure do |c|
  c.include EmbeddedTabbedWidget
  c.include EmbeddedHelpers
  c.include SendKeys
  c.include WindowsHelpers
  c.include GoogleMaps
  c.include Wait
  c.include Amazon
  c.include Wait
end

RSpec.describe "018: Verification of embedded tabbed widget store times", ps_018_embedded_tabbed: true, ps_embedded_tabbed: true do
begin
  before(:all) do
    puts "018_wtb_embedded_tabbed_store_times_test"
    launch_ps_demo_app_embedded_tabbed
  end

  it "Clicks on the local label" do
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
      sleep(5)
      embedded_pg_local_label.flash
      embedded_pg_local_label.click
    else
      embedded_pg_local_label.wait_until(&:present?)
      embedded_pg_local_label.flash
      embedded_pg_local_label.click
    end
  end

  it "Verifies the store times" do
    sleep(3)
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
