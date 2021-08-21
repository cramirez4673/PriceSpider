#This test is to verify the Mega Menu widget store times
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

RSpec.describe "044: Verification of Mega Menu widget store times", ps_044_mega: true, ps_mega: true do
begin
  before(:all) do
    puts "044_wtb_mega_menu_local_seller_store_times_test"
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

  it "Verifies the store times" do
    sleep(5)
    if mega_widget_call_for_hours.present?
      puts "Store Status IS: #{mega_widget_call_for_hours.text}"
      puts "#{true}: Call For Store Hours Status IS Displayed"
    elsif mega_widget_store_open_status.present?
      puts "Store Status IS: #{mega_widget_store_open_status.text}"
      puts "#{true}: Open Today Status IS Displayed"
    if mega_widget_store_hours.present?
      puts "#{true}: Store Hours ARE Displayed"
      puts "Store Hours ARE: #{mega_widget_store_hours.text}"
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
