#This test is to verify the Mega Menu widget redirect from online seller
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
  c.include Wait
  c.include MegaMenu
end

RSpec.describe "050: Verification of Mega Menu widget redirect from online seller", ps_050_mega: true, ps_mega_ne: true do

  before(:all) do
    puts "050_wtb_mega_ne_menu_redirect_from_online_seller_test"
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

  it "Puts the first three retailers" do
    sleep(5)
    mega_ne_widget_online_retailer_info_row_1.wait_until(&:present?)
    if mega_ne_widget_online_retailer_info_row_1 == true
      puts mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer")
      mega_ne_widget_online_retailer_info_row_1.flash
    if mega_ne_widget_online_retailer_info_row_2 == true
      puts mega_ne_widget_online_retailer_info_row_2.attribute_value("data-retailer")
      mega_ne_widget_online_retailer_info_row_2.flash
    if mega_ne_widget_online_retailer_info_row_3 == true
      puts mega_ne_widget_online_retailer_info_row_3.attribute_value("data-retailer")
      mega_ne_widget_online_retailer_info_row_3.flash
    else
      puts "No Row 3 Online Retailer Displayed"
    end
    else
      puts "No Row 2 Online Retailer Displayed"
    end
    else
      puts "No Row 1 Online Retailer Displayed"
    end
  end

  it "Verifies the user is redirected to a random online seller stores" do
    begin
      puts "Random Selection Starting"
    ensure
      $rand_number = rand(3)
      puts $rand_number
    end
    if ($rand_number) == 0
      puts "Random Option #{$rand_number} Selected"
      puts $online_store_1 = mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer")
      puts "Row 1 store name: #{$online_store_1}"
      if (mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer").include? "#{$online_store_1}") == true
        if (mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer").include? "(NL)")
          puts "Row 1 includes (NL)"
          puts $online_store_1 = mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer")
          $online_store_1 = $online_store_1[0..-1]
          $online_store_1 = $online_store_1.gsub!('(NL)', '')
          puts "Edited Row 1 Result: #{$online_store_1}"
        elsif (mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer").include? "NL")
          puts "Row 1 includes NL"
          puts $online_store_1 = mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer")
          $online_store_1 = $online_store_1[0..-1]
          $online_store_1 = $online_store_1.gsub!('NL', '')
          puts "Edited Row 1 Result: #{$online_store_1}"
        elsif (mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer").include? ".com (NL)")
          puts "Row 1 includes .com (NL)"
          puts $online_store_1 = mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer")
          $online_store_1 = $online_store_1[0..-1]
          $online_store_1 = $online_store_1.gsub!('.com (NL)', '')
          puts "Edited Row 1 Result: #{$online_store_1}"
        else
          puts "No (NL) or NL or .com (NL) appended"
        end
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
        puts "Seller Name To Validate Site Url With: #{$online_store_1.to_s.downcase()}"
        puts "Current Browser URL: #{@browser.url}"
        puts $validate_seller_1 = $online_store_1.to_s.downcase()
        $validate_seller_1 = $validate_seller_1.strip
        if (@browser.url.include? "#{$validate_seller_1}") == true
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
    elsif ($rand_number) == 1
      puts "Random Option #{$rand_number} Selected"
      puts $online_store_1 = mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer")
      puts "Row 1 store name: #{$online_store_1}"
      if (mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer").include? "#{$online_store_1}") == true
        if (mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer").include? "(NL)")
          puts "Row 1 includes (NL)"
          puts $online_store_1 = mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer")
          $online_store_1 = $online_store_1[0..-1]
          $online_store_1 = $online_store_1.gsub!('(NL)', '')
          puts "Edited Row 1 Result: #{$online_store_1}"
        elsif (mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer").include? "NL")
          puts "Row 1 includes NL"
          puts $online_store_1 = mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer")
          $online_store_1 = $online_store_1[0..-1]
          $online_store_1 = $online_store_1.gsub!('NL', '')
          puts "Edited Row 1 Result: #{$online_store_1}"
        elsif (mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer").include? ".com (NL)")
          puts "Row 1 includes .com (NL)"
          puts $online_store_1 = mega_ne_widget_online_retailer_info_row_1.attribute_value("data-retailer")
          $online_store_1 = $online_store_1[0..-1]
          $online_store_1 = $online_store_1.gsub!('.com (NL)', '')
          puts "Edited Row 1 Result: #{$online_store_1}"
        else
          puts "No (NL) or NL or .com (NL) appended"
        end
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
        puts "Seller Name To Validate Site Url With: #{$online_store_1.to_s.downcase()}"
        puts "Current Browser URL: #{@browser.url}"
        puts $validate_seller_1 = $online_store_1.to_s.downcase()
        $validate_seller_1 = $validate_seller_1.strip
        if (@browser.url.include? "#{$validate_seller_1}") == true
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
    elsif ($rand_number) == 2
      puts "Random Option #{$rand_number} Selected"
      puts $online_store_2 = mega_ne_widget_online_retailer_info_row_2.attribute_value("data-retailer")
      puts "Row 2 store name: #{$online_store_2}"
      if (mega_ne_widget_online_retailer_info_row_2.attribute_value("data-retailer").include? "#{$online_store_2}") == true
        if (mega_ne_widget_online_retailer_info_row_2.attribute_value("data-retailer").include? "(NL)")
          puts "Row 2 includes (NL)"
          puts $online_store_2 = mega_ne_widget_online_retailer_info_row_2.attribute_value("data-retailer")
          $online_store_2 = $online_store_2[0..-1]
          $online_store_2 = $online_store_2.gsub!('(NL)', '')
          puts "Edited Row 2 Result: #{$online_store_2}"
        elsif (mega_ne_widget_online_retailer_info_row_2.attribute_value("data-retailer").include? "NL")
          puts "Row 2 includes NL"
          puts $online_store_2 = mega_ne_widget_online_retailer_info_row_2.attribute_value("data-retailer")
          $online_store_2 = $online_store_2[0..-1]
          $online_store_2 = $online_store_2.gsub!('NL', '')
          puts "Edited Row 2 Result: #{$online_store_2}"
        elsif (mega_ne_widget_online_retailer_info_row_2.attribute_value("data-retailer").include? ".com (NL)")
          puts "Row 2 includes .com (NL)"
          puts $online_store_2 = mega_ne_widget_online_retailer_info_row_2.attribute_value("data-retailer")
          $online_store_2 = $online_store_2[0..-1]
          $online_store_2 = $online_store_2.gsub!('.com (NL)', '')
          puts "Edited Row 2 Result: #{$online_store_2}"
        else
          puts "No (NL) or NL or .com (NL) appended"
        end
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
        puts "Seller Name To Validate Site Url With: #{$online_store_2.to_s.downcase()}"
        puts "Current Browser URL: #{@browser.url}"
        puts $validate_seller_2 = $online_store_2.to_s.downcase()
        $validate_seller_2 = $validate_seller_2.strip
        if (@browser.url.include? "#{$validate_seller_2}") == true
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
    elsif ($rand_number) == 3
      puts "Random Option #{$rand_number} Selected"
      puts $online_store_3 = mega_ne_widget_online_retailer_info_row_3.attribute_value("data-retailer")
      puts "Row 3 store name: #{$online_store_3}"
      if (mega_ne_widget_online_retailer_info_row_3.attribute_value("data-retailer").include? "#{$online_store_3}") == true
        if (mega_ne_widget_online_retailer_info_row_3.attribute_value("data-retailer").include? "(NL)")
          puts "Row 3 includes (NL)"
          puts $online_store_3 = mega_ne_widget_online_retailer_info_row_3.attribute_value("data-retailer")
          $online_store_3 = $online_store_3[0..-1]
          $online_store_3 = $online_store_3.gsub!('(NL)', '')
          puts "Edited Row 3 Result: #{$online_store_3}"
        elsif (mega_ne_widget_online_retailer_info_row_3.attribute_value("data-retailer").include? "NL")
          puts "Row 3 includes NL"
          puts $online_store_3 = mega_ne_widget_online_retailer_info_row_3.attribute_value("data-retailer")
          $online_store_3 = $online_store_3[0..-1]
          $online_store_3 = $online_store_3.gsub!('NL', '')
          puts "Edited Row 3 Result: #{$online_store_3}"
        elsif (mega_ne_widget_online_retailer_info_row_3.attribute_value("data-retailer").include? ".com (NL)")
          puts "Row 3 includes .com (NL)"
          puts $online_store_3 = mega_ne_widget_online_retailer_info_row_3.attribute_value("data-retailer")
          $online_store_3 = $online_store_3[0..-1]
          $online_store_3 = $online_store_3.gsub!('.com (NL)', '')
          puts "Edited Row 3 Result: #{$online_store_3}"
        else
          puts "No (NL) or NL or .com (NL) appended"
        end
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
        puts "Seller Name To Validate Site Url With: #{$online_store_3.to_s.downcase()}"
        puts "Current Browser URL: #{@browser.url}"
        puts $validate_seller_3 = $online_store_3.to_s.downcase()
        $validate_seller_3 = $validate_seller_3.strip
        if (@browser.url.include? "#{$validate_seller_3}") == true
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
      else
        puts "No Random Selection Executed"
      end
    end
  after(:all) do
    close_browser
  end
end
