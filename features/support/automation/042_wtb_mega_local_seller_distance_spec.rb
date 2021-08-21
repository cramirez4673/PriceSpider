#This test is to verify the Mega Menu widget distance
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

RSpec.describe "042: Verification of Mega Menu widget distance", ps_042_mega: true, ps_mega: true do
begin
  before(:all) do
    puts "042_wtb_mega_menu_local_seller_distance_test"
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

  it "Sets text in the city search field" do
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
      sleep(5)
      mega_widget_search_box.flash
      mega_widget_search_box.set ($search_city_3)
      sleep(5)
      send_keys_enter
    else
      mega_widget_search_box.wait_until(&:present?)
      mega_widget_search_box.flash
      mega_widget_search_box.set ($search_city_3)
      sleep(5)
      send_keys_enter
      end
    end

  it "Clicks on the push pin 1" do
    embedded_pg_push_pin_1.wait_until(&:present?)
    embedded_pg_push_pin_1.flash
    embedded_pg_push_pin_1.fire_event :click
    sleep(2)
    embedded_pg_push_pin_1.fire_event :click
  end

  it "Verifies the infobox is displayed" do
    embedded_pg_infobox.wait_until(&:present?)
    if expect(embedded_pg_infobox).to exist
      puts "#{true}: Infobox IS Displayed"
      embedded_pg_infobox.flash
    else
      expect { raise StandardError, "Infobox NOT Displayed: Step FAILED"}.should raise_error("Infobox NOT Displayed")
    end
  end

  it "Gets the text within the infobox" do
    puts embedded_pg_infobox.text
  end

  it "Verifies the Distance is displayed" do
    embedded_pg_stock_distance.flash
    @local_distance = embedded_pg_stock_distance.text
    puts @local_distance
    if expect(@local_distance).to include ($local_distance_expected)
      puts "#{true}: Distance IS Displayed"
    else
      expect { raise StandardError, "Distance NOT Displayed: Step FAILED"}.should raise_error("Distance NOT Displayed")
    end
  end
  ensure
    after(:all) do
      close_browser
    end
  end
  end
