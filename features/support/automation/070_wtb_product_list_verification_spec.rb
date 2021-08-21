#This test is to verify the hybrid widget product search image closes
require_relative '../ps_wtb_send_keys_helpers'
require_relative '../ps_wtb_windows_helpers'
require_relative '../ps_wtb_wait_helpers'
require_relative '../ps_wtb_demo_url_product_list_helpers'
require_relative  '../ps_wtb_product_list_helpers'

RSpec.configure do |c|
 c.include SendKeys
 c.include WindowsHelpers
 c.include Wait
 c.include ProductListWidget
 c.include ProductList
end

 #//// BUY NOW LINK ONE ////#
RSpec.describe "070: Verification of product list widget 1", ps_070_product_list: true, ps_product_list: true do
begin
 before(:all) do
   puts "070_wtb_product_list_verification_widget_1_test"
   launch_ps_demo_product_list
   $test_number = "070"
 end

 it "Clicks on the 1st Buy Now link" do
   product_list_buy_now_button_1.wait_until(&:present?)
   product_list_buy_now_button_1.flash
   puts "1st Buy Now Button Clicked #{product_list_buy_now_button_1.click}"
 end

 it "Verifies the product" do
   if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
     sleep(5)
   elsif ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
     sleep(5)
   else
     product_list_product_name.wait_until(&:present?)
     puts "Product Name: #{product_list_product_name.text}"
     verify_product_list_product_name
   end
  end

 it "Closes the widget" do
   product_list_close_modal_icon.flash
   puts "Close Modal Icon Clicked #{product_list_close_modal_icon.click}"
 end
  ensure
   after(:all) do
    close_browser
   end
  end
end

 #//// BUY NOW LINK TWO ////#
 RSpec.describe "070: Verification of product list widget 2", ps_070_product_list: true, ps_product_list: true do
 begin
  before(:all) do
    puts "070_wtb_product_list_verification_widget_2_test"
    launch_ps_demo_product_list
    $test_number = "070"
  end

 it "Clicks on the 2nd Buy Now link" do
   product_list_buy_now_button_2.wait_until(&:present?)
   product_list_buy_now_button_2.flash
   puts "2nd Buy Now Button Clicked #{product_list_buy_now_button_2.click}"
 end

 it "Verifies the product" do
   if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
     sleep(5)
   elsif ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
     sleep(5)
   else
     product_list_product_name.wait_until(&:present?)
     puts "Product Name: #{product_list_product_name.text}"
     verify_product_list_product_name
   end
  end

 it "Closes the widget" do
   product_list_close_modal_icon.flash
   puts "Close Modal Icon Clicked #{product_list_close_modal_icon.click}"
 end
  ensure
   after(:all) do
    close_browser
   end
  end
end

 #//// BUY NOW LINK THREE ////#
 RSpec.describe "070: Verification of product list widget 3", ps_070_product_list: true, ps_product_list: true do
 begin
  before(:all) do
    puts "070_wtb_product_list_verification_widget_3_test"
    launch_ps_demo_product_list
    $test_number = "070"
  end

 it "Clicks on the 3rd Buy Now link" do
   product_list_buy_now_button_3.wait_until(&:present?)
   product_list_buy_now_button_3.flash
   puts "3rd Buy Now Button Clicked #{product_list_buy_now_button_3.click}"
 end

 it "Verifies the product" do
   if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
     sleep(5)
   elsif ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
     sleep(5)
   else
     product_list_product_name.wait_until(&:present?)
     puts "Product Name: #{product_list_product_name.text}"
     verify_product_list_product_name
   end
  end

 it "Closes the widget" do
   product_list_close_modal_icon.flash
   puts "Close Modal Icon Clicked #{product_list_close_modal_icon.click}"
 end
  ensure
   after(:all) do
    close_browser
   end
  end
end
