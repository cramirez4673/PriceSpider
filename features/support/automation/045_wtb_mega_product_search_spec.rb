#This test is to verify the Mega Menu widget product search
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
 c.include MegaMenu
end

RSpec.describe "045: Verification of Megas Menu widget product search", ps_045_mega: true, ps_mega: true do
begin
 before(:all) do
   puts "045_wtb_mega_menu_product_search_test"
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

 it "Verifies the specific product searched is displayed online and locally" do
   sleep(5)
   mega_widget_product_drop_down.flash
   mega_widget_product_drop_down.hover
 end

 it "Verifies the product detail in the detail float box" do
   sleep(3)
   if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
     ps_menu_list_1 = mega_widget_product_detail.text
     ps_menu_list_2 = ps_menu_list_1[0..54]
     ps_menu_list_3 = ps_menu_list_2.rstrip
     puts "Product Search Result: #{ps_menu_list_3}"
     sleep(3)
   else
     ps_menu_list_1 = mega_widget_product_detail.text
     ps_menu_list_2 = ps_menu_list_1[0..70]
     ps_menu_list_3 = ps_menu_list_2.rstrip
     puts "Product Search Result: #{ps_menu_list_3}"
     sleep(3)
   end
   if expect(ps_menu_list_3).to eql ($product_detail_box_expected)
     puts "#{true}: Product Detail IS A Match"
   else
     expect { raise StandardError, 'Product Detail NOT A Match: Step FAILED'}.should raise_error('Product Detail NOT A Match')
   end
 end
ensure
  after(:all) do
    close_browser
  end
end
end
