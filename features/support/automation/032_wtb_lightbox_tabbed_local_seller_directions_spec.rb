#This test is to verify the lightbox widget directions
require_relative '../ps_wtb_demo_url_lightbox_tabbed_helpers'
require_relative '../ps_wtb_embedded_widget_helpers'
require_relative '../ps_wtb_send_keys_helpers'
require_relative '../ps_wtb_google_maps_pg_helpers'
require_relative '../ps_wtb_windows_helpers'
require_relative '../ps_wtb_wait_helpers'
require_relative '../ps_wtb_amazon_pg_helpers'
require_relative '../ps_wtb_lightbox_widget_helpers'

RSpec.configure do |c|
  c.include LightboxTabbedWidget
  c.include EmbeddedHelpers
  c.include SendKeys
  c.include WindowsHelpers
  c.include GoogleMaps
  c.include Wait
  c.include Amazon
  c.include Wait
  c.include Lightbox
end

RSpec.describe "032: Verification of lightbox widget directions", ps_032_lightbox_tabbed: true, ps_lightbox_tabbed: true do
begin
  before(:all) do
    puts "032_wtb_lightbox_tabbed_local_seller_directions_test"
    launch_ps_demo_app_lightbox_tabbed
  end

  it "Clicks on the Where To Buy link" do
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
      sleep(5)
      lightbox_widget_where_to_buy_link.flash
      lightbox_widget_where_to_buy_link.click
    else
      lightbox_widget_where_to_buy_link.wait_until(&:present?)
      lightbox_widget_where_to_buy_link.flash
      lightbox_widget_where_to_buy_link.click
    end
  end

  it "Clicks on the local label" do
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
      sleep(5)
      puts "Local Label Clicked #{embedded_pg_local_label.fire_event :click}"
    else
      puts "Local Label Displayed: #{embedded_pg_local_label.wait_until_present}"
      embedded_pg_local_label.flash
      puts "Local Label Clicked #{embedded_pg_local_label.fire_event :click}"
    end
  end

  it "Verifies the get directions link" do
    sleep(2)
    embedded_pg_get_directions_link.flash
    embedded_pg_get_directions_link.click
    use_last_window
    browser_ready_state?
    sleep(5)
    puts @current_url = @browser.url
    @response = Typhoeus::Request.head(@current_url)
    puts "Response Code: #{@response.code}"
    case @response.code
    when (200)
        puts "Page loaded As expected with a 200 Google Maps Page"
        if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
          use_first_window
        else
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
ensure
  after(:all) do
    close_browser
  end
end
end
