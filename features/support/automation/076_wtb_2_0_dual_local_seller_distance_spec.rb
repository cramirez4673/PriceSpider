#This test is to verify the Web 2.0 dual widget distance
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

RSpec.describe "076: Verification of Web 2.0 dual widget distance", ps_076_wtb_2_0: true, ps_wtb_2_0: true do
begin
  before(:all) do
    puts "076_ps_wtb_2_0_dual_distance_test"
    launch_ps_demo_app_wtb_2_0_wtb
    $test_number = "076"
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

  it "Clicks on the Local tab" do
    wtb_2_0_wtb_local_retailer_tab.wait_until(&:present?)
    wtb_2_0_wtb_local_retailer_tab.scroll.to :center
    wtb_2_0_wtb_local_retailer_tab.flash
    sleep(3)
  end

  it "Sets text in the city search field" do
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
      sleep(5)
      embedded_pg_search_box.flash
      embedded_pg_search_box.set ($search_city_3)
      sleep(5)
      send_keys_enter
    else
      embedded_pg_search_box.wait_until(&:present?)
      embedded_pg_search_box.scroll.to :center
      embedded_pg_search_box.flash
      embedded_pg_search_box.set ($search_city_3)
      sleep(5)
      send_keys_enter
      end
    end

  it "Clicks on the push pin 1" do
    embedded_pg_push_pin_1.wait_until(&:present?)
    embedded_pg_push_pin_1.scroll.to :center
    embedded_pg_push_pin_1.flash
    embedded_pg_push_pin_1.fire_event :click
    sleep(2)
    embedded_pg_push_pin_1.fire_event :click
    sleep(15)
    embedded_pg_push_pin_1.flash
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
