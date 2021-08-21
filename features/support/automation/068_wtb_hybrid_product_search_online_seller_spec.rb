#This test is to verify the hybrid widget product search for online seller
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

RSpec.describe "068: Verification of hybrid widget product search for online seller", ps_068_hybrid: true, ps_hybrid: true do
begin
 before(:all) do
   puts "068_wtb_hybrid_product_search_online_seller_test"
   launch_ps_demo_app_hybrid
 end

 it "Verifies the Find Online section is displayed" do
   embedded_pg_wtb_header.wait_until(&:present?)
   if expect(embedded_pg_online_label).to be_truthy
     puts "#{true}: The Find online Label IS Displayed"
     embedded_pg_online_label.flash
     puts "Find Online Tab Clicked #{embedded_pg_online_label.click}"
   else
     expect { raise StandardError, 'The Find online Label NOT Displayed: Step FAILED'}.should raise_error('The Find online Label NOT Displayed')
   end
 end

 it "Verifies the specific product searched is displayed online and locally" do
   embedded_pg_product_search_text_field.flash
   embedded_pg_product_search_text_field.set ($product_search_1)
   hybrid_pg_float_box.wait_until_present
   hybrid_pg_float_box.flash
   hybrid_pg_float_box_result_1.flash
   hybrid_pg_float_box_result_1.click
   sleep(3)
 end

 it "Verifies the first seller Amazon is displayed" do
   if embedded_pg_online_retailer_amazon.present?
     embedded_pg_online_retailer_amazon.flash
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
       sleep(5)
       puts "#{true}: Page loaded As expected with a 200"
       if (@browser.url.include? "#{$amazon_pg_url_expected}") == true || (@browser.url.include? "#{$amazon_pg_url_expected_2}") == true
         puts "#{true}: Redirected User To Amazon Site"
         if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
           close_first_window
           use_last_window
         else
           close_last_window
           use_first_window
        end
       else
         puts "#{false}: User NOT Redirected To Amazon Site"
       end
     when (300)
       sleep(3)
       puts "#{false}: Page loaded with a 300 Error page"
       @browser.screenshot.save ("features/support/automation_screenshots/#{$error_time}_error_screenshot.png")
       headers = Hash[*response.headers.split(/[\r\n]+/).map{ |h| h.split(' ', 2) }.flatten]
       puts "Redirected to: #{ headers['Location:'] }"
       close_last_window
       use_first_window
     when (404)
       sleep(3)
       puts "#{false}: Page loaded with a 404 Error page"
       @browser.screenshot.save ("features/support/automation_screenshots/#{$error_time}_error_screenshot.png")
       close_last_window
       use_first_window
     when (500)
       sleep(3)
       puts "#{false}: Page loaded with a 500 Error page"
       @browser.screenshot.save ("features/support/automation_screenshots/#{$error_time}_error_screenshot.png")
       close_last_window
       use_first_window
     end
   else
     puts "First Online Seller NOT Displayed"
   end
  end

  it "Verifies the user is redirected to a random online seller stores" do
  begin
    embedded_pg_online_retalier_info_row_1.wait_until(&:present?)
    puts embedded_pg_online_retalier_info_row_1.attribute_value("data-retailer")
    puts embedded_pg_online_retalier_info_row_2.attribute_value("data-retailer")
    puts embedded_pg_online_retalier_info_row_3.attribute_value("data-retailer")
    sleep(3)
  ensure
  case $rand_number = rand(3)
  when 0
    puts "Random Link #{$rand_number} Selected"
    puts $online_store_1 = embedded_pg_online_retalier_info_row_1.attribute_value("data-retailer")
    puts "Row 1 store name: #{$online_store_1}"
    puts embedded_pg_view_button_1.attribute_value("data-retailer")
    if (embedded_pg_view_button_1.attribute_value("data-retailer").include? "#{$online_store_1}") == true
      embedded_pg_view_button_1.flash
      embedded_pg_view_button_1.click
      use_last_window
      if ENV['app_type'] == 'local'
        sleep(1)
        puts "One Second Sleep Needed For Local Run"
      elsif ENV['app_type'] == 'browserstack'
        puts "No Sleep Needed For Browserstack Run"
      end
      browser_ready_state?
      sleep(5)
      puts $downcasetext_1 = $online_store_1.to_s.downcase()
      puts $online_store_a = $downcasetext_1.gsub!(/[\s!@%\/&"']/,'')
      if (@browser.url.include? "#{$online_store_a}") == true
        puts "#{true}: Redirected User To #{$online_store_a} Site"
        close_last_window
        use_first_window
      else
        close_last_window
        use_first_window
        expect { raise StandardError, "User NOT Redirected To  #{$online_store_1} Website: Step FAILED"}.should raise_error("User NOT Redirected To  #{$online_store_1} Website")
      end
    else
      puts "View link and Row 1 Description for #{$online_store_1} do NOT match"
    end
  when 1
    puts "Random Link #{$rand_number} Selected"
    puts $online_store_1 = embedded_pg_online_retalier_info_row_1.attribute_value("data-retailer")
    puts "Row 1 store name: #{$online_store_1}"
    puts embedded_pg_view_button_1.attribute_value("data-retailer")
    if (embedded_pg_view_button_1.attribute_value("data-retailer").include? "#{$online_store_1}") == true
      embedded_pg_view_button_1.flash
      embedded_pg_view_button_1.click
      use_last_window
      if ENV['app_type'] == 'local'
        sleep(1)
        puts "One Second Sleep Needed For Local Run"
      elsif ENV['app_type'] == 'browserstack'
        puts "No Sleep Needed For Browserstack Run"
      end
      browser_ready_state?
      sleep(5)
      puts $downcasetext_1 = $online_store_1.to_s.downcase()
      puts $online_store_a = $downcasetext_1.gsub!(/[\s!@%\/&"']/,'')
      if (@browser.url.include? "#{$online_store_a}") == true
        puts "#{true}: Redirected User To #{$online_store_a} Site"
        close_last_window
        use_first_window
      else
        close_last_window
        use_first_window
        expect { raise StandardError, "User NOT Redirected To  #{$online_store_1} Website: Step FAILED"}.should raise_error("User NOT Redirected To  #{$online_store_1} Website")
      end
    else
      puts "View link and Row 1 Description for #{$online_store_1} do NOT match"
    end
  when 2
    puts "Random Link #{$rand_number} Selected"
    puts $online_store_2 = embedded_pg_online_retalier_info_row_2.attribute_value("data-retailer")
    puts "Row 2 store name: #{$online_store_2}"
    if (embedded_pg_view_button_2.attribute_value("data-retailer").include? "#{$online_store_2}") == true
      embedded_pg_view_button_2.flash
      embedded_pg_view_button_2.click
      use_last_window
      if ENV['app_type'] == 'local'
        sleep(1)
        puts "One Second Sleep Needed For Local Run"
      elsif ENV['app_type'] == 'browserstack'
        puts "No Sleep Needed For Browserstack Run"
      end
      browser_ready_state?
      sleep(5)
      puts $downcasetext_2 = $online_store_2.to_s.downcase()
      puts $online_store_b = $downcasetext_2.gsub!(/[\s!@%\/&"']/,'')
      if (@browser.url.include? "#{$online_store_b}") == true
        puts "#{true}: Redirected User To #{$online_store_b} Site"
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
    puts "Random Link #{$rand_number} Selected"
    puts $online_store_3 = embedded_pg_online_retalier_info_row_3.attribute_value("data-retailer")
    puts "Row 3 store name: #{$online_store_3}"
    if (embedded_pg_view_button_3.attribute_value("data-retailer").include? "#{$online_store_3}") == true
      embedded_pg_view_button_3.flash
      embedded_pg_view_button_3.click
      use_last_window
      if ENV['app_type'] == 'local'
        sleep(1)
        puts "One Second Sleep Needed For Local Run"
      elsif ENV['app_type'] == 'browserstack'
        puts "No Sleep Needed For Browserstack Run"
      end
      browser_ready_state?
      sleep(5)
      puts $downcasetext_3 = $online_store_3.to_s.downcase()
      puts $online_store_c = $downcasetext_3.gsub!(/[\s!@%\/&"']/,'')
      if (@browser.url.include? "#{$online_store_c}") == true
        puts "#{true}: Redirected User To #{$online_store_c} Site"
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
ensure
  after(:all) do
    close_browser
  end
end
end
