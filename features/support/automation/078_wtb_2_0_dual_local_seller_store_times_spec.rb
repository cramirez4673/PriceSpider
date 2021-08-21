#This test is to verify the Web 2.0 dual widget store times
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
  c.include Email
end

RSpec.describe "078: Verification of Web 2.0 dual widget store times", ps_078_wtb_2_0: true, ps_wtb_2_0: true do
begin
  before(:all) do
    puts "078_ps_wtb_2_0_dual_store_times_test"
    launch_ps_demo_app_wtb_2_0_wtb
    $test_number = "078"
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

  it "Verifies the store times" do
    sleep(5)
    wtb_2_0_wtb_local_retailer_tab.wait_until(&:present?)
    wtb_2_0_wtb_local_retailer_tab.flash
    wtb_2_0_wtb_local_retailer_tab.scroll.to :center
    Watir::Wait.until {web_2_0_pg_call_for_hours.present? or web_2_0_pg_store_open_status.present?}
    if web_2_0_pg_call_for_hours.present?
      web_2_0_pg_call_for_hours.scroll.to :center
      web_2_0_pg_call_for_hours.flash
      puts "Store Status IS: #{web_2_0_pg_call_for_hours.text}"
      puts "#{true}: Call For Store Hours Status IS Displayed"
    elsif web_2_0_pg_store_open_status.present?
      web_2_0_pg_store_open_status.scroll.to :center
      web_2_0_pg_store_open_status.flash
      puts "Store Status IS: #{web_2_0_pg_store_open_status.text}"
      puts "#{true}: Open Today Status IS Displayed"
    if web_2_0_pg_store_hours.present?
      web_2_0_pg_store_hours.scroll.to :center
      web_2_0_pg_store_hours.flash
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
