#This test is to verify the Web 2.0 dual widget redirect local
require_relative '../ps_wtb_demo_url_embedded_dual_helpers'
require_relative '../ps_wtb_embedded_widget_helpers'
require_relative '../ps_wtb_send_keys_helpers'
require_relative '../ps_wtb_google_maps_pg_helpers'
require_relative '../ps_wtb_windows_helpers'
require_relative '../ps_wtb_wait_helpers'
require_relative '../ps_wtb_amazon_pg_helpers'
require_relative '../ps_wtb_email_helpers'
require_relative '../ps_wtb_demo_url_wtb_2_0_helpers'
require_relative '../ps_wtb_2_0_helpers'

RSpec.configure do |c|
  c.order = 'defined'
  c.include WTB20Widget
  c.include WTB20Helpers
  c.include EmbeddedDualWidget
  c.include EmbeddedHelpers
  c.include SendKeys
  c.include WindowsHelpers
  c.include GoogleMaps
  c.include Wait
  c.include Amazon
  c.include Wait
  c.include Email
end

RSpec.describe "074: Verification of Web 2.0 dual widget redirect local", ps_074_wtb_2_0: true, ps_wtb_2_0: true do
begin
  before(:all) do
    puts "074_ps_2_0_dual_redirect_local_test"
    launch_ps_demo_app_wtb_2_0_wtb
    $test_number = "074"
  end

  after(:each) do
    example_exceptions = []
    RSpec.world.example_groups.each do |example_group|
    example_group.examples.each do |example|
      example_exceptions << !example.exception.nil?
      end
    end
    has_exceptions = example_exceptions.any? {|exception| exception}
    if has_exceptions == true
      $error_screenshot_path = "screenshots/#{Time.now.strftime("%Y-%m-%d-%I%M%S")}-test-#{$test_number}.png"
      @browser.screenshot.save "#{$error_screenshot_path}"
      email_sending("#{$error_screenshot_path}")
    end
  end

  it "Verifies the user is redirected to the local seller stores via logo" do
  #LOGO
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
      sleep(5)
      embedded_pg_local_logo_1_image.wait_until(&:present?)
      embedded_pg_local_logo_1_image.scroll.to :center
      embedded_pg_local_logo_1_image.flash
      puts @local_store_0  = embedded_pg_local_logo_1_attribute[9...20]
      $local_store_1 = @local_store_0.gsub!(/[\s!@%\/&"']/,'')
      puts $local_store_1
      puts "#{$local_store_1} Image Clicked Redirecting To Seller Local Site"
      embedded_pg_local_logo_1_image.scroll.to :center
      embedded_pg_local_logo_1_image.click
      sleep(1)
      embedded_pg_local_logo_1_image.scroll.to :center
      embedded_pg_local_logo_1_image.click
      use_first_window
    else
      sleep(5)
      embedded_pg_local_logo_1_image.wait_until(&:present?)
      embedded_pg_local_logo_1_image.scroll.to :center
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
    puts "Pediasure Does NOT have a 'View link' link"
  #LINK
    # sleep(5)
    # embedded_pg_local_view_online_link_1.scroll.to :top
    # embedded_pg_local_view_online_link_1.flash
    # embedded_pg_local_view_online_link_1.click
    # puts @local_store_3  = embedded_pg_local_logo_1_attribute[9...20]
    # $local_store_3 = @local_store_3.gsub!(/[\s!@%\/&"']/,'')
    # puts $local_store_3
    # puts "#{$local_store_3} Link Clicked Redirecting To Seller Local Site"
    # use_last_window
    # if ENV['app_type'] == 'local'
    #   sleep(1)
    #   puts "One Second Sleep Needed For Local Run"
    # elsif ENV['app_type'] == 'browserstack'
    #   puts "No Sleep Needed For Browserstack Run"
    # end
    # browser_ready_state?
    # puts @current_url = @browser.url
    # @response = Typhoeus::Request.head(@current_url)
    # puts "Response Code: #{@response.code}"
    # case @response.code
    # when (200)
    #   sleep(5)
    #   puts "Page loaded As expected with a 200 to: #{$local_store_3} Local site"
    #   if (@browser.url.include? "#{$local_store_3.to_s.downcase()}") == true
    #     puts "#{true}: Redirected User To #{$local_store_3.to_s.downcase()} Local Site"
    #     close_first_window
    #     use_last_window
    #   else
    #     close_first_window
    #     use_last_window
    #      expect { raise StandardError, "User NOT Redirected To  #{$local_store_3.to_s.downcase()} Local Site: Step FAILED"}.should raise_error("User NOT Redirected To  #{$local_store_3.to_s.downcase()} Local Site")
    #   end
    # when (300)
    #   puts "#{false}: Page loaded with a 300 Error page"
    #   expect { raise StandardError, "User NOT Redirected To  #{$local_store_3.to_s.downcase()} Local Site: Step FAILED"}.should raise_error("User NOT Redirected To  #{$local_store_3.to_s.downcase()} Local Site")
    #   headers = Hash[*response.headers.split(/[\r\n]+/).map{ |h| h.split(' ', 2) }.flatten]
    #   puts "Redirected to: #{ headers['Location:'] }"
    #   @browser.screenshot.save ("features/support/automation_screenshots/#{$error_time}_error_screenshot.png")
    #   close_last_window
    #   use_first_window
    # when (404)
    #   puts "#{false}: Page loaded with a 404 Error page"
    #   expect { raise StandardError, "User NOT Redirected To  #{$local_store_3.to_s.downcase()} Local Site: Step FAILED"}.should raise_error("User NOT Redirected To  #{$local_store_3.to_s.downcase()} Local Site")
    #   @browser.screenshot.save ("features/support/automation_screenshots/#{$error_time}_error_screenshot.png")
    #   close_last_window
    #   use_first_window
    # when (500)
    #   puts "#{false}: Page loaded with a 500 Error page"
    #   expect { raise StandardError, "User NOT Redirected To  #{$local_store_3.to_s.downcase()} Local Site: Step FAILED"}.should raise_error("User NOT Redirected To  #{$local_store_3.to_s.to_s.downcase()} Local Site")
    #   @browser.screenshot.save ("features/support/automation_screenshots/#{$error_time}_error_screenshot.png")
    #   close_last_window
    #   use_first_window
    # end
  end
ensure
  after(:all) do
    close_browser
  end
end
end
