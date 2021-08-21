#This test is to verify the Web 2.0 dual widget phone number
require_relative '../ps_wtb_demo_url_embedded_dual_helpers'
require_relative '../ps_wtb_embedded_widget_helpers'
require_relative '../ps_wtb_send_keys_helpers'
require_relative '../ps_wtb_google_maps_pg_helpers'
require_relative '../ps_wtb_windows_helpers'
require_relative '../ps_wtb_wait_helpers'
require_relative '../ps_wtb_amazon_pg_helpers'
require_relative '../ps_wtb_demo_url_wtb_2_0_helpers'
require_relative '../ps_wtb_2_0_helpers'
require_relative '../ps_wtb_email_helpers'

RSpec.configure do |c|
  c.order = 'defined'
  c.include WTB20Widget
  c.include WTB20Helpers
  c.include EmbeddedDualWidget
  c.include EmbeddedHelpers
  c.include SendKeys
  c.include WindowsHelpers
  c.include GoogleMaps
  c.include Wait
  c.include Amazon
  c.include Wait
  c.include Email
end

RSpec.describe "077: Verification of Web 2.0 dual widget phone number", ps_077_wtb_2_0: true, ps_wtb_2_0: true do
begin
  before(:all) do
    puts "077_ps_wtb_2_0_dual_phone_test"
    launch_ps_demo_app_wtb_2_0_wtb
    $test_number = "077"
  end

  after(:each) do
    example_exceptions = []
    RSpec.world.example_groups.each do |example_group|
    example_group.examples.each do |example|
      example_exceptions << !example.exception.nil?
      end
    end
    has_exceptions = example_exceptions.any? {|exception| exception}
    if has_exceptions == true
      $error_screenshot_path = "screenshots/#{Time.now.strftime("%Y-%m-%d-%I%M%S")}-test-#{$test_number}.png"
      @browser.screenshot.save "#{$error_screenshot_path}"
      email_sending("#{$error_screenshot_path}")
    end
  end

  it "Verifies the stock status with phone number" do
    sleep(5)
    embedded_pg_stock_status.scroll.to :center
    embedded_pg_stock_status.flash
    @local_stock = embedded_pg_stock_status.text
    puts @local_stock
    if @local_stock == ("Updating")
      puts "Waiting for Text To Equal 'Call for availability/Call for stock/See Website/Out of Stock'"
      Watir::Wait.until {embedded_pg_stock_status.text == "See Website" or embedded_pg_stock_status.text == "Out of Stock" or embedded_pg_stock_status.text == "Call for Stock" or embedded_pg_stock_status.text == "Call for Availability"}
    else
      puts "No Wait While Updating Needed"
    end
    puts "Phone Number To Be Verified: #{web_2_0_pg_phone_number.text}"
    web_2_0_pg_phone_number.flash
    if @local_stock == $local_see_website_expected and web_2_0_pg_phone_number.present?
      puts "#{true}: Local Stock(See Website) Label And Phone Number ARE Displayed"
    elsif @local_stock == $local_out_of_stock_expected and web_2_0_pg_phone_number.present?
      puts "#{true}: Local Stock(Out of Stock) Label And Phone Number ARE Displayed"
    elsif @local_stock == $local_stock_expected and web_2_0_pg_phone_number.present?
      puts "#{true}: Local Stock(Call for Stock) Label And Phone Number ARE Displayed"
    elsif @local_stock == $local_availability_expected and web_2_0_pg_phone_number.present?
      puts "#{true}: Local Stock(Call for Availability) Label And Phone Number ARE Displayed"
    else
      expect { raise StandardError, "Local Stock Label: #{@local_stock} And Phone Number: #{web_2_0_pg_phone_number.text} NOT Displayed: Step FAILED"}.should raise_error("Local Stock Label: #{@local_stock} And Phone Number: #{web_2_0_pg_phone_number.text} NOT Displayed")
    end
  end
ensure
  after(:all) do
    close_browser
  end
  end
end
