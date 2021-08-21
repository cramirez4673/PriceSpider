#This test is to verify the Mega NE Menu widget category search for online local
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

RSpec.describe "058: Verification of Mega NE Menu widget category search for local seller", ps_058_mega: true, ps_mega_ne: true do
begin
 before(:all) do
   puts "058_wtb_mega_ne_menu_category_search_local_seller_test"
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
   mega_widget_category_detail_3.flash
   puts ps_menu_list_1 = mega_widget_category_detail_3.text
   sleep(2)
   ps_menu_list_2 = ps_menu_list_1[0..70]
   ps_menu_list_3 = ps_menu_list_2.rstrip
   puts "Category Item 2 Clicked #{mega_widget_category_detail_3.click}"
   sleep(2)
   if expect(ps_menu_list_3).to eql ($mega_ne_category_detail_box_expected_2)
     puts "#{true}: Category Detail IS A Match"
     # puts "Product Selector Tab Clicked #{mega_ne_widget_pg_product_selector.hover}"
   else
     # puts "Product Selector Tab Clicked #{mega_ne_widget_pg_product_selector.hover}"
     expect { raise StandardError, 'Category Detail NOT A Match: Step FAILED'}.should raise_error('Category Detail NOT A Match')
   end
 end

 it "Verifies the user can see the distance to a random local seller stores" do
  begin
    sleep(5)
    mega_widget_local_retailer_img.wait_until(&:present?)
    mega_widget_local_retailer_img.flash
  ensure
    $rand_number = rand(3)
    puts $rand_number
  end
  if ($rand_number) == 0
    puts "Random Option #{$rand_number} Selected"
    if (mega_widget_local_retailer_img.present?) == true
      mega_widget_stock_distance_1.flash
      puts "Distance To Local Store: #{mega_widget_stock_distance_1.text}"
      $local_store_1 = mega_widget_stock_distance_1.text
    else
      expect { raise StandardError, "Distance To Local Store: #{$local_store_1} NOT Displayed: Step Failed"}.should raise_error("Distance To Local Store 1 NOT Displayed")
    end
  elsif ($rand_number) == 1
    puts "Random Option #{$rand_number} Selected"
    if (mega_widget_local_retailer_img.present?) == true
      mega_widget_stock_distance_1.flash
      puts "Distance To Local Store: #{mega_widget_stock_distance_1.text}"
      $local_store_1 = mega_widget_stock_distance_1.text
    else
      expect { raise StandardError, "Distance To Local Store: #{$local_store_1} NOT Displayed: Step Failed"}.should raise_error("Distance To Local Store 1 NOT Displayed")
    end
  elsif ($rand_number) == 2
    puts "Random Option #{$rand_number} Selected"
    if (mega_widget_local_retailer_img_2.present?) == true
      if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
        puts "Distance To Local Store: #{mega_widget_stock_distance_2.text}"
        $local_store_2 = mega_widget_stock_distance_2.text
      else
        mega_widget_stock_distance_2.flash
        puts "Distance To Local Store: #{mega_widget_stock_distance_2.text}"
        $local_store_2 = mega_widget_stock_distance_2.text
      end
    else
      expect { raise StandardError, "Distance To Local Store: #{$local_store_2} NOT Displayed: Step Failed"}.should raise_error("Distance To Local Store 2 NOT Displayed")
    end
  elsif ($rand_number) == 3
    puts "Random Option #{$rand_number} Selected"
    if (mega_widget_local_retailer_img_3.present?) == true
      mega_widget_stock_distance_3.flash
      puts "Distance To Local Store: #{mega_widget_stock_distance_3.text}"
      $local_store_3 = mega_widget_stock_distance_3.text
    else
      expect { raise StandardError, "Distance To Local Store: #{$local_store_3} NOT Displayed: Step Failed"}.should raise_error("Distance To Local Store 3 NOT Displayed")
    end
  else
    puts "No Random Selection Executed"
  end
  end
  ensure
    after(:all) do
     close_browser
    end
  end
end
