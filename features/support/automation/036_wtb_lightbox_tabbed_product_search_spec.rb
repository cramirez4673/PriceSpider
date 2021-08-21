#This test is to verify the lightbox widget product search
require_relative '../ps_wtb_demo_url_lightbox_tabbed_helpers'
require_relative '../ps_wtb_embedded_widget_helpers'
require_relative '../ps_wtb_send_keys_helpers'
require_relative '../ps_wtb_google_maps_pg_helpers'
require_relative '../ps_wtb_windows_helpers'
require_relative '../ps_wtb_wait_helpers'
require_relative '../ps_wtb_amazon_pg_helpers'
require_relative '../ps_wtb_lightbox_widget_helpers'

RSpec.configure do |c|
 c.include LightboxTabbedWidget
 c.include EmbeddedHelpers
 c.include SendKeys
 c.include WindowsHelpers
 c.include GoogleMaps
 c.include Wait
 c.include Amazon
 c.include Lightbox
end

RSpec.describe "036: Verification of lightbox widget product search", ps_036_lightbox_tabbed: true, ps_lightbox_tabbed: true do
begin
 before(:all) do
   puts "036_wtb_lightbox_tabbed_product_search_test"
   launch_ps_demo_app_lightbox_tabbed
 end

 it "Clicks on the Where To Buy link" do
   if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
     sleep(5)
     lightbox_widget_where_to_buy_link.flash
     lightbox_widget_where_to_buy_link.click
   else
     lightbox_widget_where_to_buy_link.wait_until(&:present?)
     lightbox_widget_where_to_buy_link.flash
     lightbox_widget_where_to_buy_link.click
   end
 end

 it "Verifies the Find Online section is displayed" do
   sleep(2)
   if expect(embedded_pg_online_label).to be_truthy
     puts "#{true}: The Find Online Label IS Displayed"
     embedded_pg_online_label.flash
   else
     expect { raise StandardError, 'The Find Online Label NOT Displayed: Step FAILED'}.should raise_error('The Find Online Label NOT Displayed')
   end
 end

 it "Puts the product detail" do
   puts "Product Detail Box Text: #{lightbox_widget_details_float_box.text}"
 end

 it "Clicks on the product drop down" do
   if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
     puts "No Selection Action Is Needed For Safari Browser"
     if lightbox_widget_details_float_box.text == $lightbox_product_search_detail_box_expected || lightbox_widget_details_float_box.text == $lightbox_product_search_detail_box_expected_safari
       puts "#{true}: Product Detail IS A Match"
     else
       expect { raise StandardError, 'Product Detail NOT A Match: Step FAILED'}.should raise_error('Product Detail NOT A Match')
     end
   else
     if lightbox_widget_online_product_drop_down.present?
       lightbox_widget_online_product_drop_down.flash
       lightbox_widget_online_product_drop_down.click
       sleep(3)
       lightbox_widget_online_product_drop_down.select ($lightbox_widget_product_selection)
       sleep(5)
       puts "Product Detail Box Text: #{lightbox_widget_details_float_box.text}"
       if expect(lightbox_widget_details_float_box.text).to eql ($lightbox_product_search_detail_box_expected)
         puts "#{true}: Product Detail IS A Match"
       else
         expect { raise StandardError, 'Product Detail NOT A Match: Step FAILED'}.should raise_error('Product Detail NOT A Match')
       end
     else
       puts "No Product Drop Down Displayed"
     end
   end
 end
ensure
  after(:all) do
    close_browser
  end
end
end
