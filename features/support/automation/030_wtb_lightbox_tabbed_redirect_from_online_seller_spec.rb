#This test is to verify the lightbox widget redirect online
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

RSpec.describe "030: Verification of the lightbox widget redirect online", ps_030_lightbox_tabbed: true, ps_lightbox_tabbed: true  do
begin
  before(:all) do
    puts "030_wtb_lightbox_tabbed_redirect_from_online_seller_test"
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

  it "Puts the first three retailers" do
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
      sleep(5)
      puts embedded_pg_online_retalier_info_row_1.attribute_value("data-retailer")
      puts embedded_pg_online_retalier_info_row_2.attribute_value("data-retailer")
      puts embedded_pg_online_retalier_info_row_3.attribute_value("data-retailer")
      sleep(3)
    else
      embedded_pg_online_retalier_info_row_1.wait_until(&:present?)
      puts embedded_pg_online_retalier_info_row_1.attribute_value("data-retailer")
      puts embedded_pg_online_retalier_info_row_2.attribute_value("data-retailer")
      puts embedded_pg_online_retalier_info_row_3.attribute_value("data-retailer")
      sleep(3)
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
        sleep(3)
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
    elsif ($rand_number) == 1
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
        sleep(3)
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
    elsif ($rand_number) == 2
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
        sleep(3)
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
    elsif ($rand_number) == 3
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
        sleep(3)
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
