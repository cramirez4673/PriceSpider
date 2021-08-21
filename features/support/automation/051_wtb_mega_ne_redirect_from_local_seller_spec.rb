#This test is to verify the Mega NE Menu widget redirect local
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

RSpec.describe "051: Verification of Mega NE Menu widget redirect from local seller", ps_051_mega: true, ps_mega_ne: true do
begin
  before(:all) do
    puts "051_wtb_mega_ne_menu_redirect_from_local_seller_test"
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

  it "Sets the local city" do
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
      sleep(5)
      mega_widget_search_box.flash
      mega_widget_search_box.set ($search_city_4)
      send_keys_enter
      sleep(10)
    else
      mega_widget_search_box.wait_until(&:present?)
      mega_widget_search_box.flash
      mega_widget_search_box.set ($search_city_4)
      send_keys_enter
      sleep(10)
    end
  end

  it "Verifies the user is redirected to the local seller stores via logo" do
  #LOGO
  sleep(5)
    Watir::Wait.until {mega_widget_local_retailer_logo}
    puts @local_store_0  = mega_widget_local_retailer_logo.inner_html
    $local_store_1 = @local_store_0.to_s
    $local_store_1 = $local_store_1.gsub!(/[\s()!@%\/&"]/,'')
    puts "Row 1 store name: #{$local_store_1[0..-3]}"
    mega_widget_local_retailer_img.flash
    mega_widget_local_tab.flash
    puts "Local Seller Tab Clicked #{mega_widget_local_tab.click}"
    sleep(2)
    puts "Local Seller Logo Clicked #{mega_widget_local_retailer_img.click}"
    puts "#{$local_store_1[0..-3]} Image Clicked Redirecting To Seller Local Site"
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
      puts "Page loaded As expected with a 200 to: #{$local_store_1} Local site"
      sleep(5)
      if (@browser.url.include? "#{$local_store_1[0..-3].to_s.downcase()}") == true
        puts "#{true}: Redirected User To #{$local_store_1[0..-3].to_s.downcase()} Local Site"
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
          close_last_window
          use_first_window
        end
         expect { raise StandardError, "User NOT Redirected To  #{$local_store_1[0..-3].to_s.downcase()} Local Site: Step FAILED"}.should raise_error("User NOT Redirected To  #{$local_store_1.to_s.downcase()} Local Site")
      end
    when (300)
      puts "#{false}: Page loaded with a 300 Error page"
      expect { raise StandardError, "User NOT Redirected To  #{$local_store_1[0..-3].to_s.downcase()} Local Site: Step FAILED"}.should raise_error("User NOT Redirected To  #{$local_store_1.to_s.downcase()} Local Site")
      headers = Hash[*response.headers.split(/[\r\n]+/).map{ |h| h.split(' ', 2) }.flatten]
      puts "Redirected to: #{ headers['Location:'] }"
      @browser.screenshot.save ("features/support/automation_screenshots/#{$error_time}_error_screenshot.png")
      close_last_window
      use_first_window
    when (404)
      puts "#{false}: Page loaded with a 404 Error page"
      expect { raise StandardError, "User NOT Redirected To  #{$local_store_1[0..-3].to_s.downcase()} Local Site: Step FAILED"}.should raise_error("User NOT Redirected To  #{$local_store_1.to_s.downcase()} Local Site")
      @browser.screenshot.save ("features/support/automation_screenshots/#{$error_time}_error_screenshot.png")
      close_last_window
      use_first_window
    when (500)
      puts "#{false}: Page loaded with a 500 Error page"
      expect { raise StandardError, "User NOT Redirected To  #{$local_store_1[0..-3].to_s.downcase()} Local Site: Step FAILED"}.should raise_error("User NOT Redirected To  #{$local_store_1.to_s.downcase()} Local Site")
      @browser.screenshot.save ("features/support/automation_screenshots/#{$error_time}_error_screenshot.png")
      close_last_window
      use_first_window
    end
  end

  it "Verifies the user is redirected to the local seller stores via link" do
  #LINK
  if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
    sleep(5)
    mega_widget_local_tab.flash
    puts "Local Seller Tab Clicked #{mega_widget_local_tab.click}"
    mega_ne_widget_local_retailer_view_online_link_1.flash
    puts @local_store_3  = mega_widget_local_retailer_logo.inner_html
    $local_store_3 = @local_store_3.to_s
    $local_store_3 = $local_store_3.gsub!(/[\s()!@%\/&"]/,'')
    puts "Row 3 store name: #{$local_store_3[0..-3]}"
    mega_ne_widget_local_retailer_view_online_link_1.click
    sleep(1)
    mega_ne_widget_local_retailer_view_online_link_1.click
    puts "#{$local_store_3[0..-3]} Link Clicked Redirecting To Seller Local Site"
    use_last_window
  else
    sleep(5)
    mega_widget_local_tab.flash
    puts "Local Seller Tab Clicked #{mega_widget_local_tab.click}"
    mega_ne_widget_local_retailer_view_online_link_1.flash
    puts "Online View Link For Local Seller Clicked #{mega_ne_widget_local_retailer_view_online_link_1.click}"
    puts @local_store_3  = mega_widget_local_retailer_logo.inner_html
    $local_store_3 = @local_store_3.to_s
    $local_store_3 = $local_store_3.gsub!(/[\s()!@%\/&"]/,'')
    puts "Row 3 store name: #{$local_store_3[0..-3]}"
    puts "#{$local_store_3[0..-3]} Link Clicked Redirecting To Seller Local Site"
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
    sleep(3)
    case @response.code
    when (200)
      puts "Page loaded As expected with a 200 to: #{$local_store_3[0..-3]} Local site"
      sleep(5)
      if (@browser.url.include? "#{$local_store_3[0..-3].to_s.downcase()}") == true
        puts "#{true}: Redirected User To #{$local_store_3[0..-3].to_s.downcase()} Local Site"
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
          close_last_window
          use_first_window
        end
         expect { raise StandardError, "User NOT Redirected To  #{$local_store_3[0..-3].to_s.downcase()} Local Site: Step FAILED"}.should raise_error("User NOT Redirected To  #{$local_store_3.to_s.downcase()} Local Site")
      end
    when (300)
      puts "#{false}: Page loaded with a 300 Error page"
      expect { raise StandardError, "User NOT Redirected To  #{$local_store_3[0..-3].to_s.downcase()} Local Site: Step FAILED"}.should raise_error("User NOT Redirected To  #{$local_store_3.to_s.downcase()} Local Site")
      headers = Hash[*response.headers.split(/[\r\n]+/).map{ |h| h.split(' ', 2) }.flatten]
      puts "Redirected to: #{ headers['Location:'] }"
      @browser.screenshot.save ("features/support/automation_screenshots/#{$error_time}_error_screenshot.png")
      close_last_window
      use_first_window
    when (404)
      puts "#{false}: Page loaded with a 404 Error page"
      expect { raise StandardError, "User NOT Redirected To  #{$local_store_3[0..-3].to_s.downcase()} Local Site: Step FAILED"}.should raise_error("User NOT Redirected To  #{$local_store_3.to_s.downcase()} Local Site")
      @browser.screenshot.save ("features/support/automation_screenshots/#{$error_time}_error_screenshot.png")
      close_last_window
      use_first_window
    when (405)
      puts "Page loaded As expected with a 200 to: #{$local_store_3[0..-3]} Local site"
      sleep(5)
      if (@browser.url.include? "#{$local_store_3[0..-3].to_s.downcase()}") == true
        puts "#{true}: Redirected User To #{$local_store_3[0..-3].to_s.downcase()} Local Site"
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
          close_last_window
          use_first_window
        end
         expect { raise StandardError, "User NOT Redirected To  #{$local_store_3[0..-3].to_s.downcase()} Local Site: Step FAILED"}.should raise_error("User NOT Redirected To  #{$local_store_3.to_s.downcase()} Local Site")
      end
    when (500)
      puts "#{false}: Page loaded with a 500 Error page"
      expect { raise StandardError, "User NOT Redirected To  #{$local_store_3[0..-3].to_s.downcase()} Local Site: Step FAILED"}.should raise_error("User NOT Redirected To  #{$local_store_3.to_s.downcase()} Local Site")
      @browser.screenshot.save ("features/support/automation_screenshots/#{$error_time}_error_screenshot.png")
      close_last_window
      use_first_window
    end
  end
ensure
  after(:all) do
    close_browser
  end
end
end
