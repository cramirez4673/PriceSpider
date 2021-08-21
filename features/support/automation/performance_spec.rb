#
# require 'influxDB'
# require_relative '../ps_wtb_demo_url_lightbox_dual_helpers'
# require_relative '../ps_wtb_embedded_widget_helpers'
# require_relative '../ps_wtb_send_keys_helpers'
# require_relative '../ps_wtb_google_maps_pg_helpers'
# require_relative '../ps_wtb_windows_helpers'
# require_relative '../ps_wtb_wait_helpers'
# require_relative '../ps_wtb_amazon_pg_helpers'
# require_relative '../ps_wtb_lightbox_widget_helpers'
# require_relative '../ps_wtb_influxdb_helpers'
# 
# RSpec.configure do |c|
#   c.include LightboxDualWidget
#   c.include EmbeddedHelpers
#   c.include SendKeys
#   c.include WindowsHelpers
#   c.include GoogleMaps
#   c.include Wait
#   c.include Amazon
#   c.include Wait
#   c.include Lightbox
#   c.include InfluxDB
# end
#
# RSpec.describe "Initial Widget Load Time" do
#
#   before(:all) do
#     puts $test_name = "Performance_wtb_initial_widget_load_test"
#     launch_ps_demo_app_lightbox_dual_browserstack
#   end
#
#   it "Writes to InfluxDB" do |e|
#   database = 'wtb_automation_metrics'
#   username = 'admin'
#   password = 'pS5uwXL8M9djDAfa'
#   permission = :write
#   ## Table name
#   name = 'LoadTimes'
#   ## Columns
#   # WidgetName = "CocoRice"
#   # BrowserType = "Safari"
#   OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
#     ## Connection to InfluxDB
#     influxdb = InfluxDB::Client.new(database: database,
#        host: "35.235.64.255",
#        use_ssl: true,
#        verify_ssl: false,
#        username: username,
#        password: password,
#        retry: 4)
#     sleep 1
#     ## Writing to DB
#     data = {
#       values: {value: 0},
#       tags:   {WTBInitialBrowserLoad: "#{$newBrowserLoadTime}"}
#     }
#       influxdb.write_point(name, data)
#       puts "Performance data written for Lightbox Initial Widget Load Test to InfluxDB"
#   end
#
#   after(:all) do
#     close_browser
#   end
# end
#
# RSpec.describe "Performance for WTB Button Load" do
#
#   before(:all) do
#     puts $test_name = "Performance_wtb_button_test"
#     launch_ps_demo_app_lightbox_dual
#   end
#
#   it "Performance for WTB Button Click" do
#     lightbox_widget_where_to_buy_link.wait_until(&:present?)
#     lightbox_widget_where_to_buy_link.flash
#     screen_shot
#     puts "Lightbox WTB Button Clicked #{lightbox_widget_where_to_buy_link.click}"
#     $buttonClickLoadTime = @browser.performance.summary[:response_time]
#     time_to_first_byte = @browser.performance.summary[:time_to_first_byte]
#     puts time_to_first_byte / 1000.0
#     time_to_last_byte = @browser.performance.summary[:time_to_last_byte]
#     puts time_to_last_byte / 1000.0
#     time_elapsed_button_click = (time_to_last_byte) - (time_to_first_byte)
#     puts "This is the difference between the last and first bite of WTB Button #{time_elapsed_button_click / 1000.0}"
#     puts "Lightbox WTB Button Load Time in miliseconds:#{$buttonClickLoadTime}"
#     $bclt = $buttonClickLoadTime
#     $wtbButtonLoadTime = $bclt / 1000.0 # miliseconds
#     puts "Lightbox WTB Button Load Time In Seconds Is: #{$wtbButtonLoadTime}"
#     ## Verifies the modal loaded
#     expect(embedded_pg_online_label).to be_truthy
#     expect(embedded_pg_online_label).to be_truthy
#     puts "#{true}: The Find Online Label IS Displayed"
#     embedded_pg_online_label.flash
#   end
#
#   it "Writes to InfluxDB" do
#     database = 'wtb_automation_metrics'
#     username = 'admin'
#     password = 'pS5uwXL8M9djDAfa'
#     permission = :write
#     ## Table name
#     name = 'LoadTimes'
#     ## Columns
#     # WidgetName = "CocoRice"
#     # BrowserType = "Safari"
#     OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
#       ## Connection to InfluxDB
#       influxdb = InfluxDB::Client.new(database: database,
#          host: "35.235.64.255",
#          use_ssl: true,
#          verify_ssl: false,
#          username: username,
#          password: password,
#          retry: 4)
#       sleep 1
#       ## Writing to DB
#       data = {
#         values: {value: 0},
#         tags:   {WTBWidgetLoad: "#{$wtbButtonLoadTime}"}
#       }
#       influxdb.write_point(name, data)
#       puts "Performance data written for Lightbox WTB Button Test to InfluxDB"
#   end
#
#   after(:all) do
#     close_browser
#   end
# end
#
# RSpec.describe "Performance for Buy Button Page Load" do
#
#   before(:all) do
#     puts $test_name = "Performance_buy_button_test"
#     launch_ps_demo_app_lightbox_dual
#   end
#
#   it "Performance for Buy Now Button Click" do
#     lightbox_widget_where_to_buy_link.wait_until(&:present?)
#     lightbox_widget_where_to_buy_link.flash
#     puts "Lightbox Buy Now Button Clicked #{lightbox_widget_where_to_buy_link.click}"
#     embedded_pg_buy_button_1.flash
#     screen_shot
#     puts "Buy Now Button Clicked #{embedded_pg_buy_button_1.click}"
#     time_to_first_byte_2 = @browser.performance.summary[:time_to_first_byte]
#     puts time_to_first_byte_2 / 1000.0
#     time_to_last_byte_2 = @browser.performance.summary[:time_to_last_byte]
#     puts time_to_last_byte_2 / 1000.0
#     time_elapsed_button_click_2 = (time_to_last_byte_2) - (time_to_first_byte_2)
#     puts "This is the difference between the last and first bite of Buy Now Button #{time_elapsed_button_click_2 / 1000.0}"
#     $buynowButtonClickLoadTime = @browser.performance.summary[:response_time]
#     @browser.performance.summary[:to_to_first_byte]
#     puts "Lightbox Buy Now Button Load Time in miliseconds:#{$buynowButtonClickLoadTime}"
#     $bnbclt = $buynowButtonClickLoadTime
#     $wtbBuyNowPageLoadTime = $bnbclt / 1000.0 # miliseconds
#     puts "Lightbox Buy Now Button Load Time In Seconds Is: #{$wtbBuyNowPageLoadTime}"
#     ## Verifies page loaded
#     @current_url = @browser.url
#     expect(@current_url).to eql(@current_url)
#   end
#
#   it "Writes to InfluxDB" do
#     database = 'wtb_automation_metrics'
#     username = 'admin'
#     password = 'pS5uwXL8M9djDAfa'
#     permission = :write
#     ## Table name
#     name = 'LoadTimes'
#     ## Columns
#     # WidgetName = "CocoRice"
#     # BrowserType = "Safari"
#     OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
#       ## Connection to InfluxDB
#       influxdb = InfluxDB::Client.new(database: database,
#          host: "35.235.64.255",
#          use_ssl: true,
#          verify_ssl: false,
#          username: username,
#          password: password,
#          retry: 4)
#       sleep 1
#       ## Writing to DB
#       data = {
#         values: {value: 0},
#         tags:   {WTBBuyButtonLoad: "#{$wtbBuyNowPageLoadTime}"}
#       }
#       influxdb.write_point(name, data)
#       puts "Performance data written for Lightbox Buy Now Button Test to InfluxDB"
#   end
#
#   after(:all) do
#     close_browser
#   end
# end
