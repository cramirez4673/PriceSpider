#This test is to verify the hybrid widget product search image closes
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

RSpec.describe "069: Verification of hybrid widget product search image closes", ps_069_hybrid: true, ps_hybrid: true do
begin
 before(:all) do
   puts "069_wtb_hybrid_product_search_image_close_test"
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
   embedded_pg_product_search_text_field.set ($hybrid_product_search_2)
   hybrid_pg_float_box.wait_until_present
   hybrid_pg_float_box.flash
   hybrid_pg_float_box_result_1.hover
   hybrid_pg_float_box_result_1.focus
   hybrid_pg_float_box_result_1.click
   sleep(5)
   embedded_pg_product_search_text_field.flash
   embedded_pg_product_search_text_field.set ($hybrid_product_search_1)
   hybrid_pg_float_box.wait_until_present
   hybrid_pg_float_box.flash
   hybrid_pg_float_box_result_1.hover
   hybrid_pg_float_box_result_1.focus
   hybrid_pg_float_box_result_1.click
 end

 it "Verifies the first local seller" do
   sleep(5)
   $local_seller_before = hybrid_widget_local_seller_1.attribute_value("alt")
 end

 it "Clicks the product image close button" do
   hybrid_product_image_close_button.flash
   hybrid_product_image_close_button.click
 end

 it "Verifies the first local seller again" do
   sleep(5)
   $local_seller_after = hybrid_widget_local_seller_2.attribute_value("alt")
 end

 it "Verifies the difference in sellers before and after product image closure" do
   puts $local_seller_before
   puts $local_seller_after
   if ($local_seller_before) == ($local_seller_after)
    puts "There Is NOT A Difference Before And After The Product Image Closure"
    expect { raise StandardError, 'There Is NOT A Difference Before And After The Product Image Closure: Step FAILED'}.should raise_error('There Is NOT A Difference Before And After The Product Image Closure')
   else
    puts "There IS A Difference Before And After The Product Image Closure"
   end
end
ensure
 after(:all) do
  close_browser
 end
end
end
