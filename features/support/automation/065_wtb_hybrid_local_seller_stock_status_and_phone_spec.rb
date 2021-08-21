#This test is to verify the hybrid widget phone number
require_relative '../ps_wtb_demo_url_hybrid_helpers'
require_relative '../ps_wtb_embedded_widget_helpers'
require_relative '../ps_wtb_send_keys_helpers'
require_relative '../ps_wtb_google_maps_pg_helpers'
require_relative '../ps_wtb_windows_helpers'
require_relative '../ps_wtb_wait_helpers'
require_relative '../ps_wtb_amazon_pg_helpers'
require_relative '../ps_wtb_hybrid_widget_helpers'

RSpec.configure do |c|
  c.include HybridWidget
  c.include EmbeddedHelpers
  c.include SendKeys
  c.include WindowsHelpers
  c.include GoogleMaps
  c.include Wait
  c.include Amazon
  c.include Wait
  c.include HybridMenu
end

RSpec.describe "065: Verification of hybrid widget phone number", ps_065_hybrid: true, ps_hybrid: true do
begin
  before(:all) do
    puts "065_ps_wtb_hybrid_phone_test"
    launch_ps_demo_app_hybrid
  end

  it "Clicks on the local Tab" do
    embedded_pg_local_label.flash
    puts "Local Tab Clicked #{embedded_pg_local_label.click}"
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
    puts "Phone Number To Be Verified: #{hybrid_pg_phone_number.text}"
    hybrid_pg_phone_number.flash
    if @local_stock == $local_see_website_expected and hybrid_pg_phone_number.present?
      puts "#{true}: Local Stock(See Website) Label And Phone Number ARE Displayed"
    elsif @local_stock == $local_out_of_stock_expected and hybrid_pg_phone_number.present?
      puts "#{true}: Local Stock(Out of Stock) Label And Phone Number ARE Displayed"
    elsif @local_stock == $local_stock_expected and hybrid_pg_phone_number.present?
      puts "#{true}: Local Stock(Call for Stock) Label And Phone Number ARE Displayed"
    elsif @local_stock == $local_availability_expected and hybrid_pg_phone_number.present?
      puts "#{true}: Local Stock(Call for Availability) Label And Phone Number ARE Displayed"
    else
      expect { raise StandardError, "Local Stock Label: #{@local_stock} And Phone Number: #{hybrid_pg_phone_number.text} NOT Displayed: Step FAILED"}.should raise_error("Local Stock Label: #{@local_stock} And Phone Number: #{hybrid_pg_phone_number.text} NOT Displayed")
    end
  end
ensure
  after(:all) do
    close_browser
  end
  end
end
