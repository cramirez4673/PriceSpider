#This test is to verify the Mega Menu widget redirect from online seller
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
  c.include Wait
  c.include MegaMenu
end

RSpec.describe "039: Verification of Mega Menu widget redirect from online seller", ps_039_mega: true, ps_mega: true do

  before(:all) do
    puts "039_wtb_mega_menu_redirect_from_online_seller_test"
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

  it "Clicks on the Amazon online link and verifies redirect" do
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
      sleep(5)
      mega_widget_category_drop_down.flash
      mega_widget_category_drop_down.hover
      mega_widget_category_detail_1.wait_until(&:present?)
      mega_widget_category_detail_1.flash
      mega_widget_category_detail_1.click
      sleep(3)
    else
      embedded_pg_online_retailer_tab.wait_until(&:present?)
      mega_widget_category_drop_down.flash
      mega_widget_category_drop_down.hover
      mega_widget_category_detail_1.wait_until(&:present?)
      mega_widget_category_detail_1.flash
      mega_widget_category_detail_1.click
      sleep(3)
    end
    if embedded_pg_online_retailer_amazon == true
      embedded_pg_online_retailer_amazon.click
      puts "Amazon Link Clicked Redirecting To Seller Site"
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
      puts @current_url = @browser.url
      @response = Typhoeus::Request.head(@current_url)
      puts "Response Code: #{@response.code}"
      case @response.code
      when (200)
        puts "#{true}: Page loaded As expected with a 200"
        sleep(5)
        if (@browser.url.include? "#{$amazon_pg_url_expected}" or @browser.url.include? "#{$amazon_pg_url_expected_2}") == true
          puts "#{true}: Redirected User To Amazon Site"
          if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
            close_first_window
            use_last_window
          else
            close_last_window
            use_first_window
          end
        else
          if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
            close_first_window
            use_last_window
          else
            puts "#{false}: User NOT Redirected To Amazon Site"
            close_last_window
            use_first_window
          end
        end
      when (300)
        sleep(3)
        puts "#{false}: Page loaded with a 300 Error page"
        @browser.screenshot.save ("features/support/automation_screenshots/#{$error_time}_error_screenshot.png")
        headers = Hash[*response.headers.split(/[\r\n]+/).map{ |h| h.split(' ', 2) }.flatten]
        puts "Redirected to: #{ headers['Location:'] }"
        if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
          close_first_window
          use_last_window
        else
          puts "#{false}: User NOT Redirected To Amazon Site"
          close_last_window
          use_first_window
        end
      when (404)
        sleep(3)
        puts "#{false}: Page loaded with a 404 Error page"
        @browser.screenshot.save ("features/support/automation_screenshots/#{$error_time}_error_screenshot.png")
        if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
          close_first_window
          use_last_window
        else
          puts "#{false}: User NOT Redirected To Amazon Site"
          close_last_window
          use_first_window
        end
      when (500)
        sleep(3)
        puts "#{false}: Page loaded with a 500 Error page"
        @browser.screenshot.save ("features/support/automation_screenshots/#{$error_time}_error_screenshot.png")
        if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
          close_first_window
          use_last_window
        else
          puts "#{false}: User NOT Redirected To Amazon Site"
          close_last_window
          use_first_window
        end
      end
    else
      puts "Couldn't Find Amazon Retailer"
    end
  end

  it "Puts the first three retailers" do
    sleep(5)
    mega_widget_online_retailer_info_row_1.wait_until(&:present?)
    if mega_widget_online_retailer_info_row_1.present? == true
      puts mega_widget_online_retailer_info_row_1.attribute_value("data-retailer")
      mega_widget_online_retailer_info_row_1.flash
    elsif mega_widget_online_retailer_info_row_2.present? == true
      puts mega_widget_online_retailer_info_row_2.attribute_value("data-retailer")
      mega_widget_online_retailer_info_row_2.flash
    elsif mega_widget_online_retailer_info_row_3.present? == true
      puts mega_widget_online_retailer_info_row_3.attribute_value("data-retailer")
      mega_widget_online_retailer_info_row_3.flash
    else
      puts "No Retailers Displayed"
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
      puts $online_store_1 = mega_widget_online_retailer_info_row_1.attribute_value("data-retailer")
      puts "Row 1 store name: #{$online_store_1}"
      if (mega_widget_online_retailer_info_row_1.attribute_value("data-retailer").include? "#{$online_store_1}") == true
        if (mega_widget_online_retailer_info_row_1.attribute_value("data-retailer").include? ".com")
          puts "Row 1 includes .com"
          puts $online_store_1 = mega_widget_online_retailer_info_row_1.attribute_value("data-retailer")
          $online_store_1 = $online_store_1[0..-1]
          $online_store_1 = $online_store_1.gsub!('.com', '')
          puts "Edited Row 1 Result: #{$online_store_1}"
        else
          puts "No .com appended"
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
        sleep(3)
        @browser.div(index: 0).wait_until_present
        puts "Seller Name To Validate Site Url With: #{$online_store_1.to_s.downcase()}"
        $online_store_1 = $online_store_1.to_s.downcase()
        $online_store_1_stripped = $online_store_1.strip
        puts "Need this seller for url verification: #{$online_store_1_stripped}"
        if ($online_store_1_stripped.include? "cvs") == true
          $online_store_1_stripped = "cvs"
          puts "Split Name Displayed for #{$online_store_1_stripped}"
        else
          puts "No Split Name Displayed for #{$online_store_1_stripped}"
        end
        puts "Current Browser URL: #{@browser.url}"
        if (@browser.url.include? "#{$online_store_1_stripped}") == true
          puts "#{true}: Redirected User To #{$online_store_1_stripped} Site"
          close_last_window
          use_first_window
        else
          close_last_window
          use_first_window
          expect { raise StandardError, "User NOT Redirected To  #{$online_store_1_stripped} Website: Step FAILED"}.should raise_error("User NOT Redirected To  #{$online_store_1_stripped} Website")
        end
      else
        puts "View link and Row 1 Description for  #{$online_store_1} do NOT match"
      end
    elsif ($rand_number) == 1
      puts "Random Option #{$rand_number} Selected"
      puts $online_store_1 = mega_widget_online_retailer_info_row_1.attribute_value("data-retailer")
      puts "Row 1 store name: #{$online_store_1}"
      if (mega_widget_online_retailer_info_row_1.attribute_value("data-retailer").include? "#{$online_store_1}") == true
        if (mega_widget_online_retailer_info_row_1.attribute_value("data-retailer").include? ".com")
          puts "Row 1 includes .com"
          puts $online_store_1 = mega_widget_online_retailer_info_row_1.attribute_value("data-retailer")
          $online_store_1 = $online_store_1[0..-1]
          $online_store_1 = $online_store_1.gsub!('.com', '')
          puts "Edited Row 1 Result: #{$online_store_1}"
        else
          puts "No .com appended"
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
        sleep(3)
        @browser.div(index: 0).wait_until_present
        puts "Seller Name To Validate Site Url With: #{$online_store_1.to_s.downcase()}"
        $online_store_1 = $online_store_1.to_s.downcase()
        $online_store_1_stripped = $online_store_1.strip
        puts "Need this seller for url verification: #{$online_store_1_stripped}"
        if ($online_store_1_stripped.include? "cvs") == true
          $online_store_1_stripped = "cvs"
          puts "Split Name Displayed for #{$online_store_1_stripped}"
        else
          puts "No Split Name Displayed for #{$online_store_1_stripped}"
        end
        puts "Current Browser URL: #{@browser.url}"
        if (@browser.url.include? "#{$online_store_1_stripped}") == true
          puts "#{true}: Redirected User To #{$online_store_1_stripped} Site"
          close_last_window
          use_first_window
        else
          close_last_window
          use_first_window
          expect { raise StandardError, "User NOT Redirected To  #{$online_store_1_stripped} Website: Step FAILED"}.should raise_error("User NOT Redirected To  #{$online_store_1_stripped} Website")
        end
      else
        puts "View link and Row 1 Description for  #{$online_store_1} do NOT match"
      end
    elsif ($rand_number) == 2
      puts "Random Option #{$rand_number} Selected"
      puts $online_store_2 = mega_widget_online_retailer_info_row_2.attribute_value("data-retailer")
      puts "Row 2 store name: #{$online_store_2}"
      if (mega_widget_online_retailer_info_row_2.attribute_value("data-retailer").include? "#{$online_store_2}") == true
        if (mega_widget_online_retailer_info_row_2.attribute_value("data-retailer").include? ".com")
          puts "Row 2 includes .com"
          puts $online_store_2 = mega_widget_online_retailer_info_row_2.attribute_value("data-retailer")
          $online_store_2 = $online_store_2[0..-1]
          $online_store_2 = $online_store_2.gsub!('.com', '')
          puts "Edited Row 2 Result: #{$online_store_2}"
        else
          puts "No .com appended"
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
        sleep(3)
        @browser.div(index: 0).wait_until_present
        puts "Seller Name To Validate Site Url With: #{$online_store_2.to_s.downcase()}"
        $online_store_2 = $online_store_2.to_s.downcase()
        $online_store_2_stripped = $online_store_2.strip
        puts "Need this seller for url verification: #{$online_store_2_stripped}"
        if ($online_store_2_stripped.include? "cvs") == true
          $online_store_2_stripped = "cvs"
          puts "Split Name Displayed for #{$online_store_2_stripped}"
        else
          puts "No Split Name Displayed for #{$online_store_2_stripped}"
        end
        puts "Current Browser URL: #{@browser.url}"
        if (@browser.url.include? "#{$online_store_2_stripped}") == true
          puts "#{true}: Redirected User To #{$online_store_2_stripped} Site"
          close_last_window
          use_first_window
        else
          close_last_window
          use_first_window
          expect { raise StandardError, "User NOT Redirected To  #{$online_store_2_stripped} Website: Step FAILED"}.should raise_error("User NOT Redirected To  #{$online_store_2_stripped} Website")
        end
      else
        puts "View link and Row 2 Description for  #{$online_store_2} do NOT match"
      end
    elsif ($rand_number) == 3
      puts "Random Option #{$rand_number} Selected"
      puts $online_store_3 = mega_widget_online_retailer_info_row_3.attribute_value("data-retailer")
      puts "Row 3 store name: #{$online_store_3}"
      if (mega_widget_online_retailer_info_row_3.attribute_value("data-retailer").include? "#{$online_store_3}") == true
        if (mega_widget_online_retailer_info_row_3.attribute_value("data-retailer").include? ".com")
          puts "Row 3 includes .com"
          puts $online_store_3 = mega_widget_online_retailer_info_row_3.attribute_value("data-retailer")
          $online_store_3 = $online_store_3[0..-1]
          $online_store_3 = $online_store_3.gsub!('.com', '')
          puts "Edited Row 3 Result: #{$online_store_3}"
        else
          puts "No .com appended"
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
        sleep(3)
        @browser.div(index: 0).wait_until_present
        puts "Seller Name To Validate Site Url With: #{$online_store_3.to_s.downcase()}"
        $online_store_3 = $online_store_3.to_s.downcase()
        $online_store_3_stripped = $online_store_3.strip
        puts "Need this seller for url verification: #{$online_store_3_stripped}"
        if ($online_store_3_stripped.include? "cvs") == true
          $online_store_3_stripped = "cvs"
          puts "Split Name Displayed for #{$online_store_3_stripped}"
        else
          puts "No Split Name Displayed for #{$online_store_3_stripped}"
        end
        puts "Current Browser URL: #{@browser.url}"
        if (@browser.url.include? "#{$online_store_3_stripped}") == true
          puts "#{true}: Redirected User To #{$online_store_3_stripped} Site"
          close_last_window
          use_first_window
        else
          close_last_window
          use_first_window
          expect { raise StandardError, "User NOT Redirected To  #{$online_store_3_stripped} Website: Step FAILED"}.should raise_error("User NOT Redirected To  #{$online_store_3_stripped} Website")
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
