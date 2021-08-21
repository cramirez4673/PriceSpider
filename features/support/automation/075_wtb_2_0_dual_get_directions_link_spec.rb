#This test is to verify the Web 2.0 dual widget directions
require_relative '../ps_wtb_demo_url_embedded_dual_helpers'
require_relative '../ps_wtb_embedded_widget_helpers'
require_relative '../ps_wtb_send_keys_helpers'
require_relative '../ps_wtb_google_maps_pg_helpers'
require_relative '../ps_wtb_windows_helpers'
require_relative '../ps_wtb_wait_helpers'
require_relative '../ps_wtb_amazon_pg_helpers'
require_relative '../ps_wtb_demo_url_wtb_2_0_helpers'
require_relative '../ps_wtb_2_0_helpers'
require_relative '../ps_wtb_email_helpers'

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
  c.include Email
end

RSpec.describe "075: Verification of Web 2.0 dual widget directions", ps_075_wtb_2_0: true, ps_wtb_2_0: true do
begin
  before(:all) do
    puts "075_ps_wtb_2_0_dual_directions_test"
    launch_ps_demo_app_wtb_2_0_wtb
    $test_number = "075"
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

  it "Verifies the get directions link" do
    sleep(2)
    embedded_pg_get_directions_link.wait_until(&:present?)
    embedded_pg_get_directions_link.scroll.to :center
    embedded_pg_get_directions_link.flash
    embedded_pg_get_directions_link.click
    use_last_window
    browser_ready_state?
    sleep(5)
    puts @current_url = @browser.url
    @response = Typhoeus::Request.head(@current_url)
    puts @response.code
    case @response.code
    when (200)
      puts "Page loaded As expected with a 200 Google Maps Page"
      if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
        sleep(5)
        use_first_window
      else
        sleep(5)
        use_last_window
      end
      google_maps_list_box.wait_until(&:present?)
      google_maps_list_box.flash
      puts @current_url = @browser.url
      if expect(@current_url).to include ($google_maps_partial_url)
        puts "#{true}: Google Maps URL IS A Match"
        if expect(google_maps_drive_icon.present?).to be_truthy
          google_maps_drive_icon.flash
          puts "#{true}: Google Maps Page IS Displayed"
          close_last_window
          use_first_window
        else
          close_last_window
          use_first_window
          expect { raise StandardError, 'Google Maps Page NOT A Match: Step FAILED'}.should raise_error('Google Maps Page NOT A Match')
        end
      else
        close_last_window
        use_first_window
        expect { raise StandardError, 'Google Maps URL NOT A Match: Step FAILED'}.should raise_error('Google Maps URL NOT A Match')
      end
    when (300)
      puts "#{false}: Page loaded with a 300 Error page"
      expect { raise StandardError, "User NOT Redirected To  Google Maps Page: Step FAILED"}.should raise_error("User NOT Redirected To  Google Maps Page")
      headers = Hash[*response.headers.split(/[\r\n]+/).map{ |h| h.split(' ', 2) }.flatten]
      puts "Redirected to: #{ headers['Location:'] }"
      @browser.screenshot.save ("features/support/automation_screenshots/#{$error_time}_error_screenshot.png")
      close_last_window
      use_first_window
    when (404)
      puts "#{false}: Page loaded with a 404 Error page"
      expect { raise StandardError, "User NOT Redirected To  Google Maps Page: Step FAILED"}.should raise_error("User NOT Redirected To  Google Maps Page")
      @browser.screenshot.save ("features/support/automation_screenshots/#{$error_time}_error_screenshot.png")
      close_last_window
      use_first_window
    when (500)
      puts "#{false}: Page loaded with a 500 Error page"
      expect { raise StandardError, "User NOT Redirected To  Google Maps Page: Step FAILED"}.should raise_error("User NOT Redirected To  Google Maps Page")
      @browser.screenshot.save ("features/support/automation_screenshots/#{$error_time}_error_screenshot.png")
      close_last_window
      use_first_window
  end
end
#SECOND DIRECTIONS LINK VERIFICATION
  # it "Clicks on the directions link" do
  #   embedded_pg_directions_link.wait_until_present(120)
  #   embedded_pg_directions_link.flash
  #   embedded_pg_directions_link.fire_event :click
  # end
  #
  # it "Verifies the google maps page" do
  #   sleep(7)
  #   use_last_window
  #   google_maps_list_box.wait_until_present(120)
  #   google_maps_list_box.flash
  #   puts @current_url = @browser.url
  #   if expect(@current_url).to include ($google_maps_partial_url)
  #     puts "#{true}: Google Maps URL IS A Match"
  #     if expect(google_maps_drive_icon.present?).should be_truthy
  #       google_maps_drive_icon.flash
  #       puts "#{true}: Google Maps Page IS Displayed"
  #     else
  #       expect { raise StandardError, 'Google Maps Page NOT A Match: Step FAILED'}.should raise_error('Google Maps Page NOT A Match')
  #     end
  #   else
  #     expect { raise StandardError, 'Google Maps URL NOT A Match: Step FAILED'}.should raise_error('Google Maps URL NOT A Match')
  #   end
  # end
ensure
  after(:all) do
    close_browser
  end
end
end
