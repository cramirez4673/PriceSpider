#This test is to verify the Mega Menu widget category search for online local
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

RSpec.describe "047: Verification of Megas Menu widget category search for local seller", ps_047_mega: true, ps_mega: true do

 before(:all) do
   puts "047_wtb_mega_menu_category_search_local_seller_test"
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
   ps_menu_list_3 = ps_menu_list_2.rstrip
   mega_widget_category_detail_1.click
   sleep(2)
   if expect(ps_menu_list_3).to eql ($category_detail_box_expected)
     puts "#{true}: Category Detail IS A Match"
   else
     expect { raise StandardError, 'Category Detail NOT A Match: Step FAILED'}.should raise_error('Category Detail NOT A Match')
   end
 end

 it "Verifies the user is redirected to a random local seller stores" do
  begin
    sleep(5)
    mega_widget_local_retailer_img.wait_until(&:present?)
    mega_widget_local_retailer_img.flash
  ensure
  case $rand_number = rand(3)
  when 0
    puts "Random Option #{$rand_number} Selected"
    if (mega_widget_local_retailer_img.present?) == true
      # sleep(5000000)
      mega_widget_stock_distance_1.flash
      puts "Distance To Local Store: #{mega_widget_stock_distance_1.text}"
      $local_store_1 = mega_widget_stock_distance_1.text
    else
      expect { raise StandardError, "Distance To Local Store: #{$local_store_1} NOT Displayed: Step Failed"}.should raise_error("Distance To Local Store 1 NOT Displayed")
    end
  when 1
    puts "Random Option #{$rand_number} Selected"
    if (mega_widget_local_retailer_img.present?) == true
      # sleep(5000000)
      mega_widget_stock_distance_1.flash
      puts "Distance To Local Store: #{mega_widget_stock_distance_1.text}"
      $local_store_1 = mega_widget_stock_distance_1.text
    else
      expect { raise StandardError, "Distance To Local Store: #{$local_store_1} NOT Displayed: Step Failed"}.should raise_error("Distance To Local Store 1 NOT Displayed")
    end
  when 2
    puts "Random Option #{$rand_number} Selected"
    if (mega_widget_local_retailer_img.present?) == true
      # sleep(5000000)
      mega_widget_stock_distance_2.flash
      puts "Distance To Local Store: #{mega_widget_stock_distance_2.text}"
      $local_store_2 = mega_widget_stock_distance_2.text
    else
      expect { raise StandardError, "Distance To Local Store: #{$local_store_2} NOT Displayed: Step Failed"}.should raise_error("Distance To Local Store 2 NOT Displayed")
    end
  when 3
    puts "Random Option #{$rand_number} Selected"
    if (mega_widget_local_retailer_img.present?) == true
      # sleep(5000000)
      mega_widget_stock_distance_3.flash
      puts "Distance To Local Store: #{mega_widget_stock_distance_3.text}"
      $local_store_3 = mega_widget_stock_distance_3.text
    else
      expect { raise StandardError, "Distance To Local Store: #{$local_store_3} NOT Displayed: Step Failed"}.should raise_error("Distance To Local Store 3 NOT Displayed")
    end
  end
  end
end
  after(:all) do
    close_browser
  end
end
