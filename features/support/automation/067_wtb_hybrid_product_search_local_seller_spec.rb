#This test is to verify the hybrid widget product search for local seller
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
 c.include HybridMenu
end

RSpec.describe "067: Verification of hybrid widget product search for local seller", ps_067_hybrid: true, ps_hybrid: true do
begin
 before(:all) do
   puts "067_wtb_hybrid_product_search_local_seller_test"
   launch_ps_demo_app_hybrid
 end

 it "Verifies the Find Local section is displayed" do
   embedded_pg_wtb_header.wait_until(&:present?)
   if expect(embedded_pg_local_label).to be_truthy
     puts "#{true}: The Find Local Label IS Displayed"
     embedded_pg_local_label.flash
     puts "Find Nearby Tab Clicked #{embedded_pg_local_label.click}"
   else
     expect { raise StandardError, 'The Find Local Label NOT Displayed: Step FAILED'}.should raise_error('The Find Online Label NOT Displayed')
   end
 end

 it "Verifies the specific product searched is displayed online and locally" do
   embedded_pg_product_search_text_field.flash
   embedded_pg_product_search_text_field.set ($hybrid_product_search_1)
   hybrid_pg_float_box.wait_until_present
   hybrid_pg_float_box.flash
   hybrid_pg_float_box_result_1.hover
   hybrid_pg_float_box_result_1.focus
   hybrid_pg_float_box_result_1.click
   sleep(3)
 end

 it "Verifies the product detail in the detail float box" do
   puts "This is the 1st seller displayed: #{embedded_pg_local_logo_1_attribute}"
   if hybrid_widget_updating_spinner.present? == true
     puts "This Is the Updating Spinner Text: #{hybrid_widget_updating_spinner.text}"
     puts "Updating Spinner IS Displayed"
     hybrid_widget_updating_spinner.wait_while_present
   else
     puts "Updating Spinner NOT Displayed"
   end

   if expect(embedded_pg_local_logo_1_image.present?).to be_truthy
     embedded_pg_local_logo_1_image.flash
     puts "#{true}: Local Seller Option IS Displayed"
     if hybrid_widget_call_for_stock_label.present? == true
       hybrid_widget_call_for_stock_label.flash
       puts "This is the Stock Label Text: #{hybrid_widget_call_for_stock_label.text}"
       puts "Call For Stock Label IS Displayed"
     else
      expect { raise StandardError, 'Call For Stock Label NOT Displayed: Step FAILED'}.should raise_error('Call For Stock Label NOT Displayed')
     end
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
