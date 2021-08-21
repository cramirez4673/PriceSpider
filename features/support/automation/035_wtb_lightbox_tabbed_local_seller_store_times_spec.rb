#This test is to verify the lightbox widget store times
require_relative '../ps_wtb_demo_url_lightbox_tabbed_helpers'
require_relative '../ps_wtb_embedded_widget_helpers'
require_relative '../ps_wtb_send_keys_helpers'
require_relative '../ps_wtb_google_maps_pg_helpers'
require_relative '../ps_wtb_windows_helpers'
require_relative '../ps_wtb_wait_helpers'
require_relative '../ps_wtb_amazon_pg_helpers'
require_relative '../ps_wtb_lightbox_widget_helpers'

RSpec.configure do |c|
  c.include LightboxTabbedWidget
  c.include EmbeddedHelpers
  c.include SendKeys
  c.include WindowsHelpers
  c.include GoogleMaps
  c.include Wait
  c.include Amazon
  c.include Wait
  c.include Lightbox
end

RSpec.describe "035: Verification of lightbox widget store times", ps_035_lightbox_tabbed: true, ps_lightbox_tabbed: true do
begin
  before(:all) do
    puts "035_wtb_lightbox_tabbed_local_seller_store_times_test"
    launch_ps_demo_app_lightbox_tabbed
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

  it "Clicks on the local label" do
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
      sleep(5)
      puts "Local Label Clicked #{embedded_pg_local_label.fire_event :click}"
    else
      puts "Local Label Displayed: #{embedded_pg_local_label.wait_until_present}"
      embedded_pg_local_label.flash
      puts "Local Label Clicked #{embedded_pg_local_label.fire_event :click}"
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
