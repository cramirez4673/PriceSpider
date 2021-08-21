#This test is to verify the Mega NE Menu widget category search for online seller
require_relative '../ps_wtb_demo_url_mega_ne_helpers'
require_relative '../ps_wtb_embedded_widget_helpers'
require_relative '../ps_wtb_send_keys_helpers'
require_relative '../ps_wtb_google_maps_pg_helpers'
require_relative '../ps_wtb_windows_helpers'
require_relative '../ps_wtb_wait_helpers'
require_relative '../ps_wtb_amazon_pg_helpers'
require_relative '../ps_wtb_mega_widget_helpers'

RSpec.configure do |c|
 c.include MegaNeWidget
 c.include EmbeddedHelpers
 c.include SendKeys
 c.include WindowsHelpers
 c.include GoogleMaps
 c.include Wait
 c.include Amazon
 c.include MegaMenu
end

RSpec.describe "057: Verification of Mega NE Menu widget category search for online seller", ps_057_mega: true, ps_mega_ne: true do

 before(:all) do
   puts "057_wtb_mega_ne_menu_category_search_online_seller_test"
   launch_ps_demo_app_mega_ne
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

 it "Sets the city to search" do
   if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
     sleep(5)
     mega_widget_search_box.flash
     mega_widget_search_box.set ($search_city_4)
     send_keys_enter
     sleep(5)
     embedded_pg_geo_result_1.flash
   else
     mega_widget_search_box.wait_until(&:present?)
     mega_widget_search_box.flash
     mega_widget_search_box.set ($search_city_4)
     send_keys_enter
     sleep(5)
     embedded_pg_geo_result_1.flash
   end
 end

 it "Verifies the specific category searched is displayed online and locally" do
   sleep(5)
   mega_widget_category_drop_down.flash
   mega_widget_category_drop_down.hover
 end

 it "Verifies the category detail in the detail float box" do
   sleep(3)
   mega_widget_category_detail_1.flash
   puts ps_menu_list_1 = mega_widget_category_detail_1.text
   sleep(2)
   ps_menu_list_2 = ps_menu_list_1[0..70]
   ps_menu_list_3 = ps_menu_list_2.strip
   sleep(2)
   if expect(ps_menu_list_3).to eql ($mega_ne_category_detail_box_expected)
     puts "#{true}: Category Detail IS A Match"
     puts "Product Selector Tab Clicked #{mega_ne_widget_pg_product_selector.hover}"
   else
     puts "Product Selector Tab Clicked #{mega_ne_widget_pg_product_selector.hover}"
     expect { raise StandardError, 'Category Detail NOT A Match: Step FAILED'}.should raise_error('Category Detail NOT A Match')
   end
 end

  it "Verifies the user is redirected to a random online seller stores" do
  begin
    sleep(3)
     mega_ne_widget_online_retailer_info_row_1.wait_until(&:present?)
     if mega_ne_widget_online_retailer_info_row_1 == true
       puts mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer")
       mega_ne_widget_online_retailer_info_row_1.flash
       puts $online_store_1 = mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer")
       $online_store_1 = $online_store_1.gsub!(/[\s()!@%\/&"]/,'')
       puts "Row 1 store name: #{$online_store_1[0..-3]}"
     if mega_ne_widget_online_retailer_info_row_2 == true
       puts mega_ne_widget_online_retailer_info_row_2.attribute_value("data-retailer")
       mega_ne_widget_online_retailer_info_row_2.flash
       puts $online_store_2 = mega_ne_widget_online_retailer_info_row_2.attribute_value("data-retailer")
       $online_store_2 = $online_store_2.gsub!(/[\s()!@%\/&"]/,'')
       puts "Row 2 store name: #{$online_store_2[0..-3]}"
     if mega_ne_widget_online_retailer_info_row_3 == true
       puts mega_ne_widget_online_retailer_info_row_3.attribute_value("data-retailer")
       mega_ne_widget_online_retailer_info_row_3.flash
       puts $online_store_3 = mega_ne_widget_online_retailer_info_row_3.attribute_value("data-retailer")
       $online_store_3 = $online_store_3.gsub!(/[\s()!@%\/&"]/,'')
       puts "Row 3 store name: #{$online_store_3[0..-3]}"
     else
       puts "No Row 3 Online Retailer Displayed"
     end
     else
       puts "No Row 2 Online Retailer Displayed"
     end
     else
       puts "No Row 1 Online Retailer Displayed"
     end
     sleep(3)
  ensure
    case $rand_number = rand(3)
    when 0
     puts "Random Option #{$rand_number} Selected"
     puts $online_store_1 = mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer")
     $online_store_1 = $online_store_1.gsub!(/[\s()!@%\/&"]/,'')
     puts "Row 1 store name: #{$online_store_1[0..-3]}"
     if (mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer").include? "#{$online_store_1[0..-3]}") == true
       mega_widget_buy_now_button_1.flash
       mega_widget_buy_now_button_1.click
       if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
         use_first_window
       else
         use_last_window
       end
       if ENV['app_type'] == 'local'
         sleep(1)
         puts "One Second Sleep Needed For Local Run"
       elsif ENV['app_type'] == 'browserstack'
         puts "No Sleep Needed For Browserstack Run"
       end
       browser_ready_state?
       sleep(5)
       @browser.div(index: 0).wait_until_present
       if (@browser.url.include? "#{$online_store_1[0..-3].to_s.downcase()}") == true
         puts "#{true}: Redirected User To #{$online_store_1} Site"
         close_last_window
         use_first_window
       else
         close_last_window
         use_first_window
         expect { raise StandardError, "User NOT Redirected To  #{$online_store_1} Website: Step FAILED"}.should raise_error("User NOT Redirected To  #{$online_store_1} Website")
       end
     else
       puts "View link and Row 1 Description for  #{$online_store_1} do NOT match"
     end
    when 1
     puts "Random Option #{$rand_number} Selected"
     puts $online_store_1 = mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer")
     $online_store_1 = $online_store_1.gsub!(/[\s()!@%\/&"]/,'')
     puts "Row 1 store name: #{$online_store_1[0..-3]}"
     if (mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer").include? "#{$online_store_1[0..-3]}") == true
       mega_widget_buy_now_button_1.flash
       mega_widget_buy_now_button_1.click
       if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
         use_first_window
       else
         use_last_window
       end
       if ENV['app_type'] == 'local'
         sleep(1)
         puts "One Second Sleep Needed For Local Run"
       elsif ENV['app_type'] == 'browserstack'
         puts "No Sleep Needed For Browserstack Run"
       end
       browser_ready_state?
       sleep(5)
       @browser.div(index: 0).wait_until_present
       if (@browser.url.include? "#{$online_store_1[0..-3].to_s.downcase()}") == true
         puts "#{true}: Redirected User To #{$online_store_1} Site"
         close_last_window
         use_first_window
       else
         close_last_window
         use_first_window
         expect { raise StandardError, "User NOT Redirected To  #{$online_store_1} Website: Step FAILED"}.should raise_error("User NOT Redirected To  #{$online_store_1} Website")
       end
     else
       puts "View link and Row 1 Description for  #{$online_store_1} do NOT match"
     end
    when 2
     puts "Random Option #{$rand_number} Selected"
     puts $online_store_2 = mega_ne_widget_online_retailer_info_row_2.attribute_value("data-retailer")
     $online_store_2 = $online_store_2.gsub!(/[\s()!@%\/&"]/,'')
     puts "Row 2 store name: #{$online_store_2[0..-3]}"
     if (mega_ne_widget_online_retailer_info_row_2.attribute_value("data-retailer").include? "#{$online_store_2[0..-3]}") == true
       mega_widget_buy_now_button_2.flash
       mega_widget_buy_now_button_2.click
       if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
         use_first_window
       else
         use_last_window
       end
       if ENV['app_type'] == 'local'
         sleep(1)
         puts "One Second Sleep Needed For Local Run"
       elsif ENV['app_type'] == 'browserstack'
         puts "No Sleep Needed For Browserstack Run"
       end
       browser_ready_state?
       sleep(5)
       if (@browser.url.include? "#{$online_store_2[0..-3].to_s.downcase()}") == true
         puts "#{true}: Redirected User To #{$online_store_2} Site"
         close_last_window
         use_first_window
       else
         close_last_window
         use_first_window
         expect { raise StandardError, "User NOT Redirected To  #{$online_store_2} Website: Step FAILED"}.should raise_error("User NOT Redirected To  #{$online_store_2} Website")
       end
     else
       puts "View link and Row 2 Description for  #{$online_store_2} do NOT match"
     end
    when 3
     puts "Random Option #{$rand_number} Selected"
     puts $online_store_3 = mega_ne_widget_online_retailer_info_row_3.attribute_value("data-retailer")
     $online_store_3 = $online_store_3.gsub!(/[\s()!@%\/&"]/,'')
     puts "Row 3 store name: #{$online_store_3[0..-3]}"
     if (mega_ne_widget_online_retailer_info_row_3.attribute_value("data-retailer").include? "#{$online_store_3[0..-3]}") == true
       mega_widget_buy_now_button_3.flash
       mega_widget_buy_now_button_3.click
       if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
         use_first_window
       else
         use_last_window
       end
       if ENV['app_type'] == 'local'
         sleep(1)
         puts "One Second Sleep Needed For Local Run"
       elsif ENV['app_type'] == 'browserstack'
         puts "No Sleep Needed For Browserstack Run"
       end
       browser_ready_state?
       sleep(5)
       if (@browser.url.include? "#{$online_store_3[0..-3].to_s.downcase()}") == true
         puts "#{true}: Redirected User To #{$online_store_3} Site"
         close_last_window
         use_first_window
       else
         close_last_window
         use_first_window
         expect { raise StandardError, "User NOT Redirected To  #{$online_store_3} Website: Step FAILED"}.should raise_error("User NOT Redirected To  #{$online_store_3} Website")
       end
       else
         puts "View link and Row 3 Description for  #{$online_store_3} do NOT match"
       end
     end
   end
   end
   after(:all) do
     close_browser
   end
  end
