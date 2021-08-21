#This test is to verify the embedded dual widget product search
require_relative '../ps_wtb_demo_url_embedded_dual_helpers'
require_relative '../ps_wtb_embedded_widget_helpers'
require_relative '../ps_wtb_send_keys_helpers'
require_relative '../ps_wtb_google_maps_pg_helpers'
require_relative '../ps_wtb_windows_helpers'
require_relative '../ps_wtb_wait_helpers'
require_relative '../ps_wtb_amazon_pg_helpers'

RSpec.configure do |c|
 c.include EmbeddedDualWidget
 c.include EmbeddedHelpers
 c.include SendKeys
 c.include WindowsHelpers
 c.include GoogleMaps
 c.include Wait
 c.include Amazon
end

RSpec.describe "009: Verification of embedded dual widget product search for local seller", ps_009_embedded_dual: true, ps_embedded_dual: true do
begin
 before(:all) do
   puts "009_wtb_embedded_dual_product_search_local_seller_test"
   launch_ps_demo_app_embedded_dual
 end

 it "Verifies the Find Local section is displayed" do
   embedded_pg_wtb_header.wait_until(&:present?)
   if expect(embedded_pg_local_label).to be_truthy
     puts "#{true}: The Find Local Label IS Displayed"
     embedded_pg_local_label.flash
   else
     expect { raise StandardError, 'The Find Local Label NOT Displayed: Step FAILED'}.should raise_error('The Find Online Label NOT Displayed')
   end
 end

 it "Verifies the specific product searched is displayed online and locally" do
   embedded_pg_product_search_text_field.flash
   embedded_pg_product_search_text_field.set ($product_search_1)
   embedded_pg_float_box.wait_until_present
   embedded_pg_float_box.flash
   embedded_pg_float_box_result_1.flash
   embedded_pg_float_box_result_1.click
   sleep(3)
 end

 it "Verifies the product detail in the detail float box" do
   puts "This is the 1st seller displayed: #{embedded_pg_local_logo_1_attribute}"
   if expect(embedded_pg_local_logo_1_image.present?).to be_truthy
     embedded_pg_local_logo_1_image.flash
     puts "#{true}: Local Seller Option IS Displayed"
   else
     expect { raise StandardError, 'Local Seller Option NOT Displayed: Step FAILED'}.should raise_error('Local Seller Option NOT Displayed')
   end
 end
ensure
  after(:all) do
    close_browser
  end
end
end
