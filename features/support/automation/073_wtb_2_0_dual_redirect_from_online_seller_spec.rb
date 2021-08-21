#This test is to verify the Web 2.0 dual widget redirect online
require_relative '../ps_wtb_demo_url_embedded_dual_helpers'
require_relative '../ps_wtb_embedded_widget_helpers'
require_relative '../ps_wtb_send_keys_helpers'
require_relative '../ps_wtb_google_maps_pg_helpers'
require_relative '../ps_wtb_windows_helpers'
require_relative '../ps_wtb_wait_helpers'
require_relative '../ps_wtb_amazon_pg_helpers'
require_relative '../ps_wtb_2_0_helpers'
require_relative '../ps_wtb_demo_url_wtb_2_0_helpers'

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
end

RSpec.describe "073: Verification of Web 2.0 dual widget redirect online", ps_073_wtb_2_0: true, ps_wtb_2_0: true do
begin
  before(:all) do
    puts "073_wtb_2_0_dual_redirect_online_test"
    launch_ps_demo_app_wtb_2_0_wtb
    $test_number = "073"
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

  it "Clicks on the Amazon online link and verifies redirect" do
    embedded_pg_online_retailer_tab.wait_until(&:present?)
    embedded_pg_online_retailer_tab.scroll.to :center
    embedded_pg_online_retailer_tab.flash
    sleep(3)
    if embedded_pg_online_retailer_amazon.present?
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
  embedded_pg_online_retalier_info_row_1.wait_until(&:present?)
  embedded_pg_online_retalier_info_row_1.scroll.to :center
  embedded_pg_online_retalier_info_row_1.flash
  puts embedded_pg_online_retalier_info_row_1.attribute_value("data-retailer")
  puts embedded_pg_online_retalier_info_row_2.attribute_value("data-retailer")
  puts embedded_pg_online_retalier_info_row_3.attribute_value("data-retailer")
  sleep(3)
end

it "Verifies the user is redirected to a random online seller stores" do
  begin
    puts "Random Selection Starting"
  ensure
    $rand_number = rand(4)
    puts $rand_number
  end
  if ($rand_number) == 0
    puts "Random Link #{$rand_number} Selected"
    puts $online_store_1 = embedded_pg_online_retalier_info_row_1.attribute_value("data-retailer")
    puts "Row 1 store name: #{$online_store_1}"
    puts embedded_pg_view_button_1.attribute_value("data-retailer")
    if (embedded_pg_view_button_1.attribute_value("data-retailer").include? "#{$online_store_1}") == true
      embedded_pg_view_button_1.scroll.to :center
      embedded_pg_view_button_1.flash
      embedded_pg_view_button_1.click
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
      puts $downcasetext_1 = $online_store_1.to_s.downcase()
      puts $online_store_a = $downcasetext_1.gsub!(/[\s!@%\/&"']/,'')
      if (@browser.url.include? "#{$online_store_a}") == true
        puts "#{true}: Redirected User To #{$online_store_a} Site"
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
        expect { raise StandardError, "User NOT Redirected To  #{$online_store_1} Website: Step FAILED"}.should raise_error("User NOT Redirected To  #{$online_store_1} Website")
      end
    else
      puts "View link and Row 1 Description for #{$online_store_1} do NOT match"
    end
  elsif ($rand_number) == 1
    puts "Random Link #{$rand_number} Selected"
    puts $online_store_1 = embedded_pg_online_retalier_info_row_1.attribute_value("data-retailer")
    puts "Row 1 store name: #{$online_store_1}"
    puts embedded_pg_view_button_1.attribute_value("data-retailer")
    if (embedded_pg_view_button_1.attribute_value("data-retailer").include? "#{$online_store_1}") == true
      embedded_pg_view_button_1.scroll.to :center
      embedded_pg_view_button_1.flash
      embedded_pg_view_button_1.click
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
      puts $downcasetext_1 = $online_store_1.to_s.downcase()
      puts $online_store_a = $downcasetext_1.gsub!(/[\s!@%\/&"']/,'')
      if (@browser.url.include? "#{$online_store_a}") == true
        puts "#{true}: Redirected User To #{$online_store_a} Site"
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
        expect { raise StandardError, "User NOT Redirected To  #{$online_store_1} Website: Step FAILED"}.should raise_error("User NOT Redirected To  #{$online_store_1} Website")
      end
    else
      puts "View link and Row 1 Description for #{$online_store_1} do NOT match"
    end
  elsif ($rand_number) == 2
    puts "Random Link #{$rand_number} Selected"
    puts $online_store_2 = embedded_pg_online_retalier_info_row_2.attribute_value("data-retailer")
    puts "Row 2 store name: #{$online_store_2}"
    if (embedded_pg_view_button_2.attribute_value("data-retailer").include? "#{$online_store_2}") == true
      embedded_pg_view_button_2.scroll.to :center
      embedded_pg_view_button_2.flash
      embedded_pg_view_button_2.click
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
      puts $downcasetext_2 = $online_store_2.to_s.downcase()
      puts $online_store_b = $downcasetext_2.gsub!(/[\s!@%\/&"']/,'')
      if (@browser.url.include? "#{$online_store_b}") == true
        puts "#{true}: Redirected User To #{$online_store_b} Site"
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
        expect { raise StandardError, "User NOT Redirected To  #{$online_store_2} Website: Step FAILED"}.should raise_error("User NOT Redirected To  #{$online_store_2} Website")
      end
    else
      puts "View link and Row 2 Description for  #{$online_store_2} do NOT match"
    end
  elsif ($rand_number) == 3
    puts "Random Link #{$rand_number} Selected"
    puts $online_store_3 = embedded_pg_online_retalier_info_row_3.attribute_value("data-retailer")
    puts "Row 3 store name: #{$online_store_3}"
    if (embedded_pg_view_button_3.attribute_value("data-retailer").include? "#{$online_store_3}") == true
      embedded_pg_view_button_3.scroll.to :center
      embedded_pg_view_button_3.flash
      embedded_pg_view_button_3.click
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
      puts $downcasetext_3 = $online_store_3.to_s.downcase()
      puts $online_store_c = $downcasetext_3.gsub!(/[\s!@%\/&"']/,'')
      if (@browser.url.include? "#{$online_store_c}") == true
        puts "#{true}: Redirected User To #{$online_store_c} Site"
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
        expect { raise StandardError, "User NOT Redirected To  #{$online_store_3} Website: Step FAILED"}.should raise_error("User NOT Redirected To  #{$online_store_3} Website")
      end
      else
        puts "View link and Row 3 Description for  #{$online_store_3} do NOT match"
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
