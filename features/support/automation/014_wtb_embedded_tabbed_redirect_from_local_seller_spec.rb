#This test is to verify the embedded tabbed widget redirect local
require_relative '../ps_wtb_demo_url_embedded_tabbed_helpers'
require_relative '../ps_wtb_embedded_widget_helpers'
require_relative '../ps_wtb_send_keys_helpers'
require_relative '../ps_wtb_google_maps_pg_helpers'
require_relative '../ps_wtb_windows_helpers'
require_relative '../ps_wtb_wait_helpers'
require_relative '../ps_wtb_amazon_pg_helpers'

RSpec.configure do |c|
  c.include EmbeddedTabbedWidget
  c.include EmbeddedHelpers
  c.include SendKeys
  c.include WindowsHelpers
  c.include GoogleMaps
  c.include Wait
  c.include Amazon
  c.include Wait
end

RSpec.describe "014: Verification of embedded tabbed widget redirect local", ps_014_embedded_tabbed: true, ps_embedded_tabbed: true do
begin
  before(:all) do
    puts "014_wtb_embedded_tabbed_redirect_from_local_seller_test"
    launch_ps_demo_app_embedded_tabbed
  end

  it "Clicks on the local label" do
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
      sleep(5)
      embedded_pg_local_label.flash
      embedded_pg_local_label.click
    else
      embedded_pg_local_label.wait_until(&:present?)
      embedded_pg_local_label.flash
      embedded_pg_local_label.click
    end
  end

  it "Verifies the user is redirected to the local seller stores via logo" do
  #LOGO
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
      sleep(5)
      embedded_pg_local_logo_1_image.flash
      puts @local_store_0  = embedded_pg_local_logo_1_attribute[9...20]
      $local_store_1 = @local_store_0.gsub!(/[\s!@%\/&"']/,'')
      puts $local_store_1
      puts "#{$local_store_1} Image Clicked Redirecting To Seller Local Site"
      embedded_pg_local_logo_1_image.click
      sleep(1)
      embedded_pg_local_logo_1_image.click
      use_first_window
    else
      sleep(5)
      embedded_pg_local_logo_1_image.flash
      embedded_pg_local_logo_1_image.click
      puts @local_store_0  = embedded_pg_local_logo_1_attribute[9...20]
      $local_store_1 = @local_store_0.gsub!(/[\s!@%\/&"']/,'')
      puts $local_store_1
      puts "#{$local_store_1} Image Clicked Redirecting To Seller Local Site"
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
      if (@browser.url.include? "#{$local_store_1.to_s.downcase()}") == true
        puts "#{true}: Redirected User To #{$local_store_1.to_s.downcase()} Local Site"
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
         expect { raise StandardError, "User NOT Redirected To  #{$local_store_1.to_s.downcase()} Local Site: Step FAILED"}.should raise_error("User NOT Redirected To  #{$local_store_1.to_s.downcase()} Local Site")
      end
    when (300)
      puts "#{false}: Page loaded with a 300 Error page"
      expect { raise StandardError, "User NOT Redirected To  #{$local_store_1.to_s.downcase()} Local Site: Step FAILED"}.should raise_error("User NOT Redirected To  #{$local_store_1.to_s.downcase()} Local Site")
      headers = Hash[*response.headers.split(/[\r\n]+/).map{ |h| h.split(' ', 2) }.flatten]
      puts "Redirected to: #{ headers['Location:'] }"
      @browser.screenshot.save ("features/support/automation_screenshots/#{$error_time}_error_screenshot.png")
      close_last_window
      use_first_window
    when (404)
      puts "#{false}: Page loaded with a 404 Error page"
      expect { raise StandardError, "User NOT Redirected To  #{$local_store_1.to_s.downcase()} Local Site: Step FAILED"}.should raise_error("User NOT Redirected To  #{$local_store_1.to_s.downcase()} Local Site")
      @browser.screenshot.save ("features/support/automation_screenshots/#{$error_time}_error_screenshot.png")
      close_last_window
      use_first_window
    when (500)
      puts "#{false}: Page loaded with a 500 Error page"
      expect { raise StandardError, "User NOT Redirected To  #{$local_store_1.to_s.downcase()} Local Site: Step FAILED"}.should raise_error("User NOT Redirected To  #{$local_store_1.to_s.downcase()} Local Site")
      @browser.screenshot.save ("features/support/automation_screenshots/#{$error_time}_error_screenshot.png")
      close_last_window
      use_first_window
    end
  end

  it "Verifies the user is redirected to the local seller stores via link" do
  #LINK
  if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
    sleep(5)
    embedded_pg_local_view_online_link_1.flash
    puts @local_store_3  = embedded_pg_local_logo_1_attribute[9...20]
    $local_store_3 = @local_store_3.gsub!(/[\s!@%\/&"']/,'')
    puts $local_store_3
    embedded_pg_local_view_online_link_1.click
    sleep(1)
    embedded_pg_local_view_online_link_1.click
    puts "#{$local_store_3} Link Clicked Redirecting To Seller Local Site"
    use_last_window
  else
    sleep(5)
    embedded_pg_local_view_online_link_1.flash
    embedded_pg_local_view_online_link_1.fire_event :click
    puts @local_store_3  = embedded_pg_local_logo_1_attribute[9...20]
    $local_store_3 = @local_store_3.gsub!(/[\s!@%\/&"']/,'')
    puts $local_store_3
    puts "#{$local_store_3} Link Clicked Redirecting To Seller Local Site"
    use_last_window
  end
    if ENV['app_type'] == 'local'
      sleep(1)
      puts "One Second Sleep Needed For Local Run"
    elsif ENV['app_type'] == 'browserstack'
      puts "No Sleep Needed For Browserstack Run"
    end
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
      sleep(1)
    else
      puts "Not Safari No additional Wait Needed"
    end
    browser_ready_state?
    puts @current_url = @browser.url
    @response = Typhoeus::Request.head(@current_url)
    puts "Response Code: #{@response.code}"
    case @response.code
    when (0)
      puts "Page loaded As expected with a 200 to: #{$local_store_3} Local site"
      sleep(5)
      if (@browser.url.include? "#{$local_store_3.to_s.downcase()}") == true
        puts "#{true}: Redirected User To #{$local_store_3.to_s.downcase()} Local Site"
        if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
          puts "Not closing last window"
        else
          close_last_window
          use_first_window
        end
      else
        if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
          puts "Not closing last window"
        else
          close_last_window
          use_first_window
        end
         expect { raise StandardError, "User NOT Redirected To  #{$local_store_3.to_s.downcase()} Local Site: Step FAILED"}.should raise_error("User NOT Redirected To  #{$local_store_3.to_s.downcase()} Local Site")
      end
    when (200)
      puts "Page loaded As expected with a 200 to: #{$local_store_3} Local site"
      sleep(5)
      if (@browser.url.include? "#{$local_store_3.to_s.downcase()}") == true
        puts "#{true}: Redirected User To #{$local_store_3.to_s.downcase()} Local Site"
        if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
          puts "Not closing last window"
        else
          close_last_window
          use_first_window
        end
      else
        if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
          puts "Not closing last window"
        else
          close_last_window
          use_first_window
        end
         expect { raise StandardError, "User NOT Redirected To  #{$local_store_3.to_s.downcase()} Local Site: Step FAILED"}.should raise_error("User NOT Redirected To  #{$local_store_3.to_s.downcase()} Local Site")
      end
    when (300)
      puts "#{false}: Page loaded with a 300 Error page"
      expect { raise StandardError, "User NOT Redirected To  #{$local_store_3.to_s.downcase()} Local Site: Step FAILED"}.should raise_error("User NOT Redirected To  #{$local_store_3.to_s.downcase()} Local Site")
      headers = Hash[*response.headers.split(/[\r\n]+/).map{ |h| h.split(' ', 2) }.flatten]
      puts "Redirected to: #{ headers['Location:'] }"
      @browser.screenshot.save ("features/support/automation_screenshots/#{$error_time}_error_screenshot.png")
      close_last_window
      use_first_window
    when (404)
      puts "#{false}: Page loaded with a 404 Error page"
      expect { raise StandardError, "User NOT Redirected To  #{$local_store_3.to_s.downcase()} Local Site: Step FAILED"}.should raise_error("User NOT Redirected To  #{$local_store_3.to_s.downcase()} Local Site")
      @browser.screenshot.save ("features/support/automation_screenshots/#{$error_time}_error_screenshot.png")
      close_last_window
      use_first_window
    when (500)
      puts "#{false}: Page loaded with a 500 Error page"
      expect { raise StandardError, "User NOT Redirected To  #{$local_store_3.to_s.downcase()} Local Site: Step FAILED"}.should raise_error("User NOT Redirected To  #{$local_store_3.to_s.downcase()} Local Site")
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
