#This test is to verify the embedded tabbed widget phone number
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

RSpec.describe "043: Verification of embedded tabbed widget phone number", ps_043_mega: true, ps_mega: true do
begin
  before(:all) do
    puts "043_wtb_mega_menu_local_seller_phone_test"
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

  it "Verifies the stock status with phone number" do
    sleep(5)
    embedded_pg_stock_status.flash
    @local_stock = embedded_pg_stock_status.text
    puts @local_stock
    if @local_stock == ("Updating")
      puts "Waiting for Text To Equal 'Call for availability/Call for stock/See Website/Out of Stock'"
      Watir::Wait.until {embedded_pg_stock_status.text == "See Website" or embedded_pg_stock_status.text == "Out of Stock" or embedded_pg_stock_status.text == "Call for Stock" or embedded_pg_stock_status.text == "Call for Availability"}
    else
      puts "No Wait While Updating Needed"
    end
    puts "Phone Number To Be Verified: #{embedded_pg_phone_number.text}"
    embedded_pg_phone_number.flash
    if @local_stock == $local_see_website_expected and embedded_pg_phone_number.present?
      puts "#{true}: Local Stock(See Website) Label And Phone Number ARE Displayed"
    elsif @local_stock == $local_out_of_stock_expected and embedded_pg_phone_number.present?
      puts "#{true}: Local Stock(Out of Stock) Label And Phone Number ARE Displayed"
    elsif @local_stock == $local_stock_expected and embedded_pg_phone_number.present?
      puts "#{true}: Local Stock(Call for Stock) Label And Phone Number ARE Displayed"
    elsif @local_stock == $local_availability_expected and embedded_pg_phone_number.present?
      puts "#{true}: Local Stock(Call for Availability) Label And Phone Number ARE Displayed"
    else
      expect { raise StandardError, "Local Stock Label: #{@local_stock} And Phone Number: #{embedded_pg_phone_number.text} NOT Displayed: Step FAILED"}.should raise_error("Local Stock Label: #{@local_stock} And Phone Number: #{embedded_pg_phone_number.text} NOT Displayed")
    end
  end
ensure
  after(:all) do
    close_browser
  end
  end
end
