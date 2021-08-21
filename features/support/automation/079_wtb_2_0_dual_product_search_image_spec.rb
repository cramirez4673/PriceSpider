#This test is to verify the Web 2.0 dual widget product search
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

RSpec.describe "079: Verification of Web 2.0 dual widget product search for local seller", ps_079_wtb_2_0: true, ps_wtb_2_0: true do
begin
 before(:all) do
   puts "079_wtb_2_0_dual_product_search_local_seller_test"
   launch_ps_demo_app_wtb_2_0_wtb
   $test_number = "079"
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

 it "Verifies the Find Local section is displayed" do
   wtb_2_0_wtb_local_retailer_tab.wait_until(&:present?)
   wtb_2_0_wtb_local_retailer_tab.flash
   wtb_2_0_wtb_local_retailer_tab.scroll.to :center
   if expect(wtb_2_0_wtb_local_retailer_tab).to be_truthy
     puts "#{true}: The Find Local Label IS Displayed"
     wtb_2_0_wtb_local_retailer_tab.flash
   else
     expect { raise StandardError, 'The Find Local Label NOT Displayed: Step FAILED'}.should raise_error('The Find Online Label NOT Displayed')
   end
 end

 it "Bring image to center" do
   wtb_2_0_pg_product_image.scroll.to :center
   wtb_2_0_pg_product_image.flash
 end

 it "Verifies the product detail in the detail float box" do
   verify_product_image_is_displayed
 end
ensure
  after(:all) do
    close_browser
  end
end
end
