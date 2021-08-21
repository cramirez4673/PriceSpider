# require 'watir'
# require 'rspec'
# require 'pry'
# require 'rubygems'
# require 'selenium-webdriver'
# require 'rspec/expectations'
# require 'webdriver-user-agent'
# require 'pp'
# require 'typhoeus'
# require 'watir-performance'
# require 'time'
# require_relative 'spec_helper'
#
# $wtb_embedded_dual_demo_url = "https://demo.pricespider.com/wtb/Demos/WTBO-1287/EmbeddedDualColumn/?ps-version=0.0.3.2"
# $wtb_embedded_tabbed_demo_url = "https://demo.pricespider.com/wtb/Demos/WTBO-1309/Embedded400px/?ps-version=0.0.3.0"
# $wtb_lightbox_dual_demo_url = "https://demo.pricespider.com/wtb/Demos/WTBO-1262/Lightbox/DropdownDualColumnStackedLocal/?ps-version=0.0.3.10"
# $wtb_lightbox_tabbed_demo_url = "https://demo.pricespider.com/wtb/Demos/WTBO-1149/Lightbox/?ps-version=0.0.3.4"
# $wtb_mega_demo_url = "https://demo.pricespider.com/wtb/Demos/WTBO-1942/Megamenu/"
# $wtb_hybrid_demo_url = "https://demo.pricespider.com/wtb/Demos/WTBO-2500/Case3/Hybrid/?ps-version=0.0.4.53"
# $wtb_hybrid_dremel_demo_url = "https://www.dremel.com/en_US/where-to-buy"
# $wtb_mega_ne_demo_url = "https://demo.pricespider.com/wtb/Demos/WTBO-1863/WTBO-1821/Megamenu/?ps-version=2.0.10"
# $username = "carlos.ramirez@pricespider.com"
# $authkey = "u5559ff22c6a1e42"
#
# module DemoAccounts
#   include RSpec::Matchers
#   include Selenium
#
#   def ps_mobile_browser
#     driver = Webdriver::UserAgent.driver(browser: :firefox, agent: :iphone, orientation: :portrait)
#     @browser = Watir::Browser.new driver
#   end
# #EMBEDDED DUAL WIDGET
#   def launch_ps_demo_app_embedded_dual
#     Watir.logger.ignore(:deprecations)
#     @client = Selenium::WebDriver::Remote::Http::Default.new
#     @client.read_timeout = 120
#     @profile = Selenium::WebDriver::Firefox::Profile.new#CHANGE
#     @profile['browser.download.dir'] = "/tmp/webdriver-downloads"
#     @profile['browser.download.folderList'] = 2
#     @profile['browser.helperApps.neverAsk.saveToDisk'] = "application/octet-stream"
#     @browser = Watir::Browser.new :firefox, :profile => @profile, :http_client => @client, :options => $opts #CHANGE
#     @browser.driver.manage.timeouts.page_load = 120
#     @browser.window.maximize()
#     @website = ENV['demo_url'] || $wtb_embedded_dual_demo_url
#     @browser.goto @website
#     @browserLoadTimes = @browser.performance.summary[:response_time]
#     puts "Inintial Browser Load Time:#{@browserLoadTimes} MILISECONDS"
#     @blt = @browserLoadTimes
#     @seconds = @blt / 1000 # miliseconds
#     puts "Initial Browser Load Time In Seconds Is: #{@seconds}"
#     @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#     puts @newBrowserLoadTime
#     @browser.ready_state.eql? "complete"
# 	end
#
#   def launch_ps_demo_app_embedded_dual_default_profile
#     Watir.logger.ignore(:deprecations)
#     case @browser_type = ENV['browser_type']
#     # CHROME BROWSER #
#     when ("Chrome")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser_version'] = '75.0 beta'
#       caps['name'] = "#{$test_name}"
#       caps['os'] = 'OS X'
#       caps['os_version'] = 'Mojave'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || "https://demo.pricespider.com/wtb/Demos/WTBO-1287/EmbeddedDualColumn/?ps-version=0.0.3.2"
#       @browser.goto @website
#       @browser.window.maximize()
#       @browserLoadTimes = @browser.performance.summary[:response_time]
#       puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       @blt = @browserLoadTimes
#       @seconds = @blt / 1000 # miliseconds
#       puts "Browser Load Time In Seconds Is: #{@seconds}"
#       @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#     # FIREFOX BROWSER #
#     when ("Firefox")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser_version'] = '67.0 beta'
#       caps['name'] = "#{$test_name}"
#       caps['os'] = 'OS X'
#       caps['os_version'] = 'Mojave'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || "https://demo.pricespider.com/wtb/Demos/WTBO-1287/EmbeddedDualColumn/?ps-version=0.0.3.2"
#       @browser.goto @website
#       @browser.window.maximize()
#       @browserLoadTimes = @browser.performance.summary[:response_time]
#       puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       @blt = @browserLoadTimes
#       @seconds = @blt / 1000 # miliseconds
#       puts "Browser Load Time In Seconds Is: #{@seconds}"
#       @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#     # SAFARI BROWSER #
#     when ("Safari")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser_version'] = '12.0'
#       caps['name'] = "#{$test_name}"
#       caps['os'] = 'OS X'
#       caps['os_version'] = 'Mojave'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || "https://demo.pricespider.com/wtb/Demos/WTBO-1287/EmbeddedDualColumn/?ps-version=0.0.3.2"
#       @browser.goto @website
#       @browser.window.maximize()
#       # @browserLoadTimes = @browser.performance.summary[:response_time]
#       # puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       # @blt = @browserLoadTimes
#       # @seconds = @blt / 1000 # miliseconds
#       # puts "Browser Load Time In Seconds Is: #{@seconds}"
#       # @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       # puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#     # IE BROWSER #
#     when ("IE")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser'] = 'IE'
#       caps['browser_version'] = '11.0'
#       caps['os'] = 'Windows'
#       caps['os_version'] = '10'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || "https://demo.pricespider.com/wtb/Demos/WTBO-1287/EmbeddedDualColumn/?ps-version=0.0.3.2"
#       @browser.goto @website
#       @browser.window.maximize()
#       @browserLoadTimes = @browser.performance.summary[:response_time]
#       puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       @blt = @browserLoadTimes
#       @seconds = @blt / 1000 # miliseconds
#       puts "Browser Load Time In Seconds Is: #{@seconds}"
#       @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#     # EDGE BROWSER #
#     when ("Edge")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser'] = 'Edge'
#       caps['browser_version'] = '18.0'
#       caps['os'] = 'Windows'
#       caps['os_version'] = '10'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || "https://demo.pricespider.com/wtb/Demos/WTBO-1287/EmbeddedDualColumn/?ps-version=0.0.3.2"
#       @browser.goto @website
#       @browser.window.maximize()
#       @browserLoadTimes = @browser.performance.summary[:response_time]
#       puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       @blt = @browserLoadTimes
#       @seconds = @blt / 1000 # miliseconds
#       puts "Browser Load Time In Seconds Is: #{@seconds}"
#       @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#     end
#   end
#     # Watir.logger.ignore(:deprecations)
#     # if ENV['driver'] == 'headless'
#     #   $opts = Selenium::WebDriver::Firefox::Options::new(args: ['-headless'])
#     # end
#     # @client = Selenium::WebDriver::Remote::Http::Default.new
#     # @client.read_timeout = 120
#     # @profile_2 = Selenium::WebDriver::Firefox::Profile.from_name "default-1481575486611"#CHANGE
#     # @profile_2['browser.download.dir'] = "/tmp/webdriver-downloads"
#     # @profile_2['browser.download.folderList'] = 2
#     # @profile_2['browser.helperApps.neverAsk.saveToDisk'] = "application/octet-stream"
#     # @browser = Watir::Browser.new :firefox, :profile => @profile_2, :http_client => @client, :options => $opts#CHANGE
#     # @browser.driver.manage.timeouts.page_load = 120
#     # @browser.window.maximize()
#     # @website = ENV['demo_url'] || $wtb_embedded_dual_demo_url
#     # @browser.goto @website
#     # @browserLoadTimes = @browser.performance.summary[:response_time]
#     # puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#     # @blt = @browserLoadTimes
#     # @seconds = @blt / 1000 # miliseconds
#     # puts "Browser Load Time In Seconds Is: #{@seconds}"
#     # @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#     # puts @newBrowserLoadTime
#     # @browser.ready_state.eql? "complete"
#   # end
# #EMBEDDED TABBED WIDGET
#   def launch_ps_demo_app_embedded_tabbed
#     case @browser_type = ENV['browser_type']
#     # CHROME BROWSER #
#     when ("Chrome")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser_version'] = '75.0 beta'
#       caps['name'] = "#{$test_name}"
#       caps['os'] = 'OS X'
#       caps['os_version'] = 'Mojave'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || $wtb_embedded_tabbed_demo_url
#       @browser.goto @website
#       @browser.window.maximize()
#       @browserLoadTimes = @browser.performance.summary[:response_time]
#       puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       @blt = @browserLoadTimes
#       @seconds = @blt / 1000 # miliseconds
#       puts "Browser Load Time In Seconds Is: #{@seconds}"
#       @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#     # FIREFOX BROWSER #
#     when ("Firefox")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser_version'] = '67.0 beta'
#       caps['name'] = "#{$test_name}"
#       caps['os'] = 'OS X'
#       caps['os_version'] = 'Mojave'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || $wtb_embedded_tabbed_demo_url
#       @browser.goto @website
#       @browser.window.maximize()
#       @browserLoadTimes = @browser.performance.summary[:response_time]
#       puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       @blt = @browserLoadTimes
#       @seconds = @blt / 1000 # miliseconds
#       puts "Browser Load Time In Seconds Is: #{@seconds}"
#       @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#     # SAFARI BROWSER #
#     when ("Safari")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser_version'] = '12.0'
#       caps['name'] = "#{$test_name}"
#       caps['os'] = 'OS X'
#       caps['os_version'] = 'Mojave'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || $wtb_embedded_tabbed_demo_url
#       @browser.goto @website
#       @browser.window.maximize()
#       # @browserLoadTimes = @browser.performance.summary[:response_time]
#       # puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       # @blt = @browserLoadTimes
#       # @seconds = @blt / 1000 # miliseconds
#       # puts "Browser Load Time In Seconds Is: #{@seconds}"
#       # @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       # puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#     # IE BROWSER #
#     when ("IE")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser'] = 'IE'
#       caps['browser_version'] = '11.0'
#       caps['os'] = 'Windows'
#       caps['os_version'] = '10'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || $wtb_embedded_tabbed_demo_url
#       @browser.goto @website
#       @browser.window.maximize()
#       @browserLoadTimes = @browser.performance.summary[:response_time]
#       puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       @blt = @browserLoadTimes
#       @seconds = @blt / 1000 # miliseconds
#       puts "Browser Load Time In Seconds Is: #{@seconds}"
#       @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#     # EDGE BROWSER #
#     when ("Edge")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser'] = 'Edge'
#       caps['browser_version'] = '18.0'
#       caps['os'] = 'Windows'
#       caps['os_version'] = '10'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || $wtb_embedded_tabbed_demo_url
#       @browser.goto @website
#       @browser.window.maximize()
#       @browserLoadTimes = @browser.performance.summary[:response_time]
#       puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       @blt = @browserLoadTimes
#       @seconds = @blt / 1000 # miliseconds
#       puts "Browser Load Time In Seconds Is: #{@seconds}"
#       @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#     end
#   end
#
#   def launch_ps_demo_app_embedded_tabbed_default_profile
#     caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#     caps.platform = :WINDOWS
#     caps[:name] = 'Watir WebDriver'
#     caps['browser'] = 'Safari'
#     caps['browser_version'] = '11.0'
#     caps['os'] = 'OS X'
#     caps['os_version'] = 'High Sierra'
#     caps['resolution'] = '1280x960'
#     caps['browserstack.debug'] ='true'
#     @browser = Watir::Browser.new(:remote,
#     :url => "http://carlosramirez16:eE46vu1qPPGpBzxUM1pG@hub-cloud.browserstack.com/wd/hub",
#     :desired_capabilities => caps)
#     @website =  ENV['demo_url'] || $wtb_embedded_tabbed_demo_url
#     @browser.goto @website
#     @browser.window.maximize()
#     Watir.logger.ignore(:deprecations)
#     if ENV['driver'] == 'headless'
#       $opts = Selenium::WebDriver::Firefox::Options::new(args: ['-headless'])
#     end
#     @client = Selenium::WebDriver::Remote::Http::Default.new
#     @client.read_timeout = 120
#     @profile_2 = Selenium::WebDriver::Firefox::Profile.from_name "default-1481575486611"#CHANGE
#     @profile_2['browser.download.dir'] = "/tmp/webdriver-downloads"
#     @profile_2['browser.download.folderList'] = 2
#     @profile_2['browser.helperApps.neverAsk.saveToDisk'] = "application/octet-stream"
#     @browser = Watir::Browser.new :firefox, :profile => @profile_2, :http_client => @client, :options => $opts#CHANGE
#     @browser.driver.manage.timeouts.page_load = 120
#     @browser.window.maximize()
#     @website = ENV['demo_url'] || $wtb_embedded_tabbed_demo_url
#     @browser.goto @website
#     @browserLoadTimes = @browser.performance.summary[:response_time]
#     puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#     @blt = @browserLoadTimes
#     @seconds = @blt / 1000 # miliseconds
#     puts "Browser Load Time In Seconds Is: #{@seconds}"
#     @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#     puts @newBrowserLoadTime
#     @browser.ready_state.eql? "complete"
#   end
# #LIGHTBOX WIDGET DUAL
#   def launch_ps_demo_app_lightbox_dual
#     Watir.logger.ignore(:deprecations)
#     @client = Selenium::WebDriver::Remote::Http::Default.new
#     @client.read_timeout = 120
#     @profile_2 = Selenium::WebDriver::Firefox::Profile.from_name "default-1481575486611"#CHANGE
#     @profile_2['browser.download.dir'] = "/tmp/webdriver-downloads"
#     @profile_2['browser.download.folderList'] = 2
#     @profile_2['browser.helperApps.neverAsk.saveToDisk'] = "application/octet-stream"
#     @browser = Watir::Browser.new :firefox, :profile => @profile_2, :http_client => @client, :options => $opts#CHANGE
#     @browser.driver.manage.timeouts.page_load = 120
#     @browser.window.maximize()
#     @website = ENV['demo_url'] || $wtb_lightbox_dual_demo_url
#     @browser.goto @website
#     # @browserLoadTimes = @browser.performance.summary[:response_time]
#     # puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#     # @blt = @browserLoadTimes
#     # @seconds = @blt / 1000 # miliseconds
#     # puts "Browser Load Time In Seconds Is: #{@seconds}"
#     # @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#     # puts @newBrowserLoadTime
#     @browser.ready_state.eql? "complete"
#   end
#
#   def launch_ps_demo_app_lightbox_dual_default_profile
#     case @browser_type = ENV['browser_type']
#     # CHROME BROWSER #
#     when ("Chrome")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser_version'] = '75.0 beta'
#       caps['name'] = "#{$test_name}"
#       caps['os'] = 'OS X'
#       caps['os_version'] = 'Mojave'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || $wtb_lightbox_dual_demo_url
#       @browser.goto @website
#       @browser.window.maximize()
#       @browserLoadTimes = @browser.performance.summary[:response_time]
#       puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       @blt = @browserLoadTimes
#       @seconds = @blt / 1000 # miliseconds
#       puts "Browser Load Time In Seconds Is: #{@seconds}"
#       @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#     # FIREFOX BROWSER #
#     when ("Firefox")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser_version'] = '67.0 beta'
#       caps['name'] = "#{$test_name}"
#       caps['os'] = 'OS X'
#       caps['os_version'] = 'Mojave'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || $wtb_lightbox_dual_demo_url
#       @browser.goto @website
#       @browser.window.maximize()
#       @browserLoadTimes = @browser.performance.summary[:response_time]
#       puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       @blt = @browserLoadTimes
#       @seconds = @blt / 1000 # miliseconds
#       puts "Browser Load Time In Seconds Is: #{@seconds}"
#       @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#     # SAFARI BROWSER #
#     when ("Safari")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser_version'] = '12.0'
#       caps['name'] = "#{$test_name}"
#       caps['os'] = 'OS X'
#       caps['os_version'] = 'Mojave'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || $wtb_lightbox_dual_demo_url
#       @browser.goto @website
#       @browser.window.maximize()
#       # @browserLoadTimes = @browser.performance.summary[:response_time]
#       # puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       # @blt = @browserLoadTimes
#       # @seconds = @blt / 1000 # miliseconds
#       # puts "Browser Load Time In Seconds Is: #{@seconds}"
#       # @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       # puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#     # IE BROWSER #
#     when ("IE")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser'] = 'IE'
#       caps['browser_version'] = '11.0'
#       caps['os'] = 'Windows'
#       caps['os_version'] = '10'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || $wtb_lightbox_dual_demo_url
#       @browser.goto @website
#       @browser.window.maximize()
#       @browserLoadTimes = @browser.performance.summary[:response_time]
#       puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       @blt = @browserLoadTimes
#       @seconds = @blt / 1000 # miliseconds
#       puts "Browser Load Time In Seconds Is: #{@seconds}"
#       @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#     # EDGE BROWSER #
#     when ("Edge")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser'] = 'Edge'
#       caps['browser_version'] = '18.0'
#       caps['os'] = 'Windows'
#       caps['os_version'] = '10'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || $wtb_lightbox_dual_demo_url
#       @browser.goto @website
#       @browser.window.maximize()
#       @browserLoadTimes = @browser.performance.summary[:response_time]
#       puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       @blt = @browserLoadTimes
#       @seconds = @blt / 1000 # miliseconds
#       puts "Browser Load Time In Seconds Is: #{@seconds}"
#       @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#     end
#   end
# #LIGHTBOX WIDGET TABBED
#   def launch_ps_demo_app_lightbox_tabbed
#     Watir.logger.ignore(:deprecations)
#     @client = Selenium::WebDriver::Remote::Http::Default.new
#     @client.read_timeout = 120
#     @profile = Selenium::WebDriver::Firefox::Profile.new#CHANGE
#     @profile['browser.download.dir'] = "/tmp/webdriver-downloads"
#     @profile['browser.download.folderList'] = 2
#     @profile['browser.helperApps.neverAsk.saveToDisk'] = "application/octet-stream"
#     @browser = Watir::Browser.new :firefox, :profile => @profile, :http_client => @client, :options => $opts #CHANGE
#     @browser.driver.manage.timeouts.page_load = 120
#     @browser.window.maximize()
#     @website = ENV['demo_url'] || $wtb_lightbox_tabbed_demo_url
#     @browser.goto @website
#     @browserLoadTimes = @browser.performance.summary[:response_time]
#     puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#     @blt = @browserLoadTimes
#     @seconds = @blt / 1000 # miliseconds
#     puts "Browser Load Time In Seconds Is: #{@seconds}"
#     @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#     puts @newBrowserLoadTime
#     @browser.ready_state.eql? "complete"
#   end
#
#   def launch_ps_demo_app_lightbox_tabbed_default_profile
#     Watir.logger.ignore(:deprecations)
#     if ENV['driver'] == 'headless'
#       $opts = Selenium::WebDriver::Firefox::Options::new(args: ['-headless'])
#     end
#     @client = Selenium::WebDriver::Remote::Http::Default.new
#     @client.read_timeout = 120
#     @profile_2 = Selenium::WebDriver::Firefox::Profile.from_name "default-1481575486611"#CHANGE
#     @profile_2['browser.download.dir'] = "/tmp/webdriver-downloads"
#     @profile_2['browser.download.folderList'] = 2
#     @profile_2['browser.helperApps.neverAsk.saveToDisk'] = "application/octet-stream"
#     @browser = Watir::Browser.new :firefox, :profile => @profile_2, :http_client => @client, :options => $opts#CHANGE
#     @browser.driver.manage.timeouts.page_load = 120
#     @browser.window.maximize()
#     @website = ENV['demo_url'] || $wtb_lightbox_tabbed_demo_url
#     @browser.goto @website
#     @browserLoadTimes = @browser.performance.summary[:response_time]
#     puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#     @blt = @browserLoadTimes
#     @seconds = @blt / 1000 # miliseconds
#     puts "Browser Load Time In Seconds Is: #{@seconds}"
#     @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#     puts @newBrowserLoadTime
#     @browser.ready_state.eql? "complete"
#   end
#
#   def launch_ps_demo_app_lightbox_dual_browserstack
#     case @browser_type = ENV['browser_type']
#   # CHROME BROWSER #
#     when ("Chrome")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser_version'] = '75.0 beta'
#       caps['name'] = "#{$test_name}"
#       caps['os'] = 'OS X'
#       caps['os_version'] = 'Mojave'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || $wtb_lightbox_dual_demo_url
#       @browser.goto @website
#       @browser.window.maximize()
#       @browserLoadTimes = @browser.performance.summary[:response_time]
#       puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       @blt = @browserLoadTimes
#       @seconds = @blt / 1000 # miliseconds
#       puts "Browser Load Time In Seconds Is: #{@seconds}"
#       @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#   # FIREFOX BROWSER #
#     when ("Firefox")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser_version'] = '67.0 beta'
#       caps['name'] = "#{$test_name}"
#       caps['os'] = 'OS X'
#       caps['os_version'] = 'Mojave'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || $wtb_lightbox_dual_demo_url
#       @browser.goto @website
#       @browser.window.maximize()
#       @browserLoadTimes = @browser.performance.summary[:response_time]
#       puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       @blt = @browserLoadTimes
#       @seconds = @blt / 1000 # miliseconds
#       puts "Browser Load Time In Seconds Is: #{@seconds}"
#       @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#   # SAFARI BROWSER #
#     when ("Safari")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser_version'] = '12.0'
#       caps['name'] = "#{$test_name}"
#       caps['os'] = 'OS X'
#       caps['os_version'] = 'Mojave'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || $wtb_lightbox_dual_demo_url
#       @browser.goto @website
#       @browser.window.maximize()
#       # @browserLoadTimes = @browser.performance.summary[:response_time]
#       # puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       # @blt = @browserLoadTimes
#       # @seconds = @blt / 1000 # miliseconds
#       # puts "Browser Load Time In Seconds Is: #{@seconds}"
#       # @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       # puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#   # IE BROWSER #
#     when ("IE")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser'] = 'IE'
#       caps['browser_version'] = '11.0'
#       caps['os'] = 'Windows'
#       caps['os_version'] = '10'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || $wtb_lightbox_dual_demo_url
#       @browser.goto @website
#       @browser.window.maximize()
#       @browserLoadTimes = @browser.performance.summary[:response_time]
#       puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       @blt = @browserLoadTimes
#       @seconds = @blt / 1000 # miliseconds
#       puts "Browser Load Time In Seconds Is: #{@seconds}"
#       @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#   # EDGE BROWSER #
#     when ("Edge")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser'] = 'Edge'
#       caps['browser_version'] = '18.0'
#       caps['os'] = 'Windows'
#       caps['os_version'] = '10'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || $wtb_lightbox_dual_demo_url
#       @browser.goto @website
#       @browser.window.maximize()
#       @browserLoadTimes = @browser.performance.summary[:response_time]
#       puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       @blt = @browserLoadTimes
#       @seconds = @blt / 1000 # miliseconds
#       puts "Browser Load Time In Seconds Is: #{@seconds}"
#       @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#     end
#   end
#
#   def launch_ps_demo_app_lightbox_tabbed_browserstack
#     case @browser_type = ENV['browser_type']
#   # CHROME BROWSER #
#     when ("Chrome")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser_version'] = '75.0 beta'
#       caps['name'] = "#{$test_name}"
#       caps['os'] = 'OS X'
#       caps['os_version'] = 'Mojave'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || $wtb_lightbox_tabbed_demo_url
#       @browser.goto @website
#       @browser.window.maximize()
#       @browserLoadTimes = @browser.performance.summary[:response_time]
#       puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       @blt = @browserLoadTimes
#       @seconds = @blt / 1000 # miliseconds
#       puts "Browser Load Time In Seconds Is: #{@seconds}"
#       @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#   # FIREFOX BROWSER #
#     when ("Firefox")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser_version'] = '67.0 beta'
#       caps['name'] = "#{$test_name}"
#       caps['os'] = 'OS X'
#       caps['os_version'] = 'Mojave'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || $wtb_lightbox_tabbed_demo_url
#       @browser.goto @website
#       @browser.window.maximize()
#       @browserLoadTimes = @browser.performance.summary[:response_time]
#       puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       @blt = @browserLoadTimes
#       @seconds = @blt / 1000 # miliseconds
#       puts "Browser Load Time In Seconds Is: #{@seconds}"
#       @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#   # SAFARI BROWSER #
#     when ("Safari")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser_version'] = '12.0'
#       caps['name'] = "#{$test_name}"
#       caps['os'] = 'OS X'
#       caps['os_version'] = 'Mojave'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || $wtb_lightbox_tabbed_demo_url
#       @browser.goto @website
#       @browser.window.maximize()
#       # @browserLoadTimes = @browser.performance.summary[:response_time]
#       # puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       # @blt = @browserLoadTimes
#       # @seconds = @blt / 1000 # miliseconds
#       # puts "Browser Load Time In Seconds Is: #{@seconds}"
#       # @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       # puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#   # IE BROWSER #
#     when ("IE")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser'] = 'IE'
#       caps['browser_version'] = '11.0'
#       caps['os'] = 'Windows'
#       caps['os_version'] = '10'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || $wtb_lightbox_tabbed_demo_url
#       @browser.goto @website
#       @browser.window.maximize()
#       @browserLoadTimes = @browser.performance.summary[:response_time]
#       puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       @blt = @browserLoadTimes
#       @seconds = @blt / 1000 # miliseconds
#       puts "Browser Load Time In Seconds Is: #{@seconds}"
#       @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#   # EDGE BROWSER #
#     when ("Edge")
#       puts ENV['browser_type']
#       caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#       caps.platform = :WINDOWS
#       caps[:name] = 'Watir WebDriver'
#       caps['browser'] = "#{@browser_type}"
#       caps['browser'] = 'Edge'
#       caps['browser_version'] = '18.0'
#       caps['os'] = 'Windows'
#       caps['os_version'] = '10'
#       caps['resolution'] = '1024x768'
#       caps['browserstack.debug'] ='true'
#       caps["record_video"] = "true"
#       @browser = Watir::Browser.new(:remote,
#       :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#       :desired_capabilities => caps)
#       @website =  ENV['demo_url'] || $wtb_lightbox_tabbed_demo_url
#       @browser.goto @website
#       @browser.window.maximize()
#       @browserLoadTimes = @browser.performance.summary[:response_time]
#       puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#       @blt = @browserLoadTimes
#       @seconds = @blt / 1000 # miliseconds
#       puts "Browser Load Time In Seconds Is: #{@seconds}"
#       @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#     end
#   end
# #MEGA MENU WIDGET
#   def launch_ps_demo_app_mega
#     Watir.logger.ignore(:deprecations)
#     if ENV['driver'] == 'headless'
#       $opts = Selenium::WebDriver::Firefox::Options::new(args: ['-headless'])
#     end
#     @client = Selenium::WebDriver::Remote::Http::Default.new
#     @client.read_timeout = 120
#     @profile = Selenium::WebDriver::Firefox::Profile.new#CHANGE
#     @profile['browser.download.dir'] = "/tmp/webdriver-downloads"
#     @profile['browser.download.folderList'] = 2
#     @profile['browser.helperApps.neverAsk.saveToDisk'] = "application/octet-stream"
#     @browser = Watir::Browser.new :firefox, :profile => @profile, :http_client => @client, :options => $opts #CHANGE
#     @browser.driver.manage.timeouts.page_load = 120
#     @browser.window.maximize()
#     @website = ENV['demo_url'] || $wtb_mega_demo_url
#     @browser.goto @website
#     @browserLoadTimes = @browser.performance.summary[:response_time]
#     puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#     @blt = @browserLoadTimes
#     @seconds = @blt / 1000 # miliseconds
#     puts "Browser Load Time In Seconds Is: #{@seconds}"
#     @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#     puts @newBrowserLoadTime
#     @browser.ready_state.eql? "complete"
#   end
#
#   def launch_ps_demo_app_mega_default_profile
#     Watir.logger.ignore(:deprecations)
#     if ENV['driver'] == 'headless'
#       $opts = Selenium::WebDriver::Firefox::Options::new(args: ['-headless'])
#     end
#     @client = Selenium::WebDriver::Remote::Http::Default.new
#     @client.read_timeout = 120
#     @profile_2 = Selenium::WebDriver::Firefox::Profile.from_name "default-1481575486611"#CHANGE
#     @profile_2['browser.download.dir'] = "/tmp/webdriver-downloads"
#     @profile_2['browser.download.folderList'] = 2
#     @profile_2['browser.helperApps.neverAsk.saveToDisk'] = "application/octet-stream"
#     @browser = Watir::Browser.new :firefox, :profile => @profile_2, :http_client => @client, :options => $opts#CHANGE
#     @browser.driver.manage.timeouts.page_load = 120
#     @browser.window.maximize()
#     @website = ENV['demo_url'] || $wtb_mega_demo_url
#     @browser.goto @website
#     @browserLoadTimes = @browser.performance.summary[:response_time]
#     puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#     @blt = @browserLoadTimes
#     @seconds = @blt / 1000 # miliseconds
#     puts "Browser Load Time In Seconds Is: #{@seconds}"
#     @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#     puts @newBrowserLoadTime
#     @browser.ready_state.eql? "complete"
#   end
#   #HYBRID WIDGET
#     def launch_ps_demo_app_hybrid
#       Watir.logger.ignore(:deprecations)
#       @client = Selenium::WebDriver::Remote::Http::Default.new
#       @client.read_timeout = 120
#       @profile = Selenium::WebDriver::Firefox::Profile.new#CHANGE
#       @profile['browser.download.dir'] = "/tmp/webdriver-downloads"
#       @profile['browser.download.folderList'] = 2
#       @profile['browser.helperApps.neverAsk.saveToDisk'] = "application/octet-stream"
#       @browser = Watir::Browser.new :firefox, :profile => @profile, :http_client => @client, :options => $opts #CHANGE
#       @browser.driver.manage.timeouts.page_load = 120
#       @browser.window.maximize()
#       @website = ENV['demo_url'] || $wtb_hybrid_demo_url
#       @browser.goto @website
#       @browserLoadTimes = @browser.performance.summary[:response_time]
#       puts "Inintial Browser Load Time:#{@browserLoadTimes} MILISECONDS"
#       @blt = @browserLoadTimes
#       @seconds = @blt / 1000 # miliseconds
#       puts "Initial Browser Load Time In Seconds Is: #{@seconds}"
#       @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#       puts @newBrowserLoadTime
#       @browser.ready_state.eql? "complete"
#   	end
#
#     def launch_ps_demo_app_hybrid_default_profile
#       Watir.logger.ignore(:deprecations)
#       case @browser_type = ENV['browser_type']
#       # CHROME BROWSER #
#       when ("Chrome")
#         puts ENV['browser_type']
#         caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#         caps.platform = :WINDOWS
#         caps[:name] = 'Watir WebDriver'
#         caps['browser'] = "#{@browser_type}"
#         caps['browser_version'] = '75.0 beta'
#         caps['name'] = "#{$test_name}"
#         caps['os'] = 'OS X'
#         caps['os_version'] = 'Mojave'
#         caps['resolution'] = '1024x768'
#         caps['browserstack.debug'] ='true'
#         caps["record_video"] = "true"
#         @browser = Watir::Browser.new(:remote,
#         :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#         :desired_capabilities => caps)
#         @website =  ENV['demo_url'] || "https://demo.pricespider.com/wtb/Demos/WTBO-2500/Case3/Hybrid/?ps-version=0.0.4.53"
#         @browser.goto @website
#         @browser.window.maximize()
#         @browserLoadTimes = @browser.performance.summary[:response_time]
#         puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#         @blt = @browserLoadTimes
#         @seconds = @blt / 1000 # miliseconds
#         puts "Browser Load Time In Seconds Is: #{@seconds}"
#         @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#         puts @newBrowserLoadTime
#         @browser.ready_state.eql? "complete"
#       # FIREFOX BROWSER #
#       when ("Firefox")
#         puts ENV['browser_type']
#         caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#         caps.platform = :WINDOWS
#         caps[:name] = 'Watir WebDriver'
#         caps['browser'] = "#{@browser_type}"
#         caps['browser_version'] = '67.0 beta'
#         caps['name'] = "#{$test_name}"
#         caps['os'] = 'OS X'
#         caps['os_version'] = 'Mojave'
#         caps['resolution'] = '1024x768'
#         caps['browserstack.debug'] ='true'
#         caps["record_video"] = "true"
#         @browser = Watir::Browser.new(:remote,
#         :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#         :desired_capabilities => caps)
#         @website =  ENV['demo_url'] || "https://demo.pricespider.com/wtb/Demos/WTBO-2500/Case3/Hybrid/?ps-version=0.0.4.53"
#         @browser.goto @website
#         @browser.window.maximize()
#         @browserLoadTimes = @browser.performance.summary[:response_time]
#         puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#         @blt = @browserLoadTimes
#         @seconds = @blt / 1000 # miliseconds
#         puts "Browser Load Time In Seconds Is: #{@seconds}"
#         @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#         puts @newBrowserLoadTime
#         @browser.ready_state.eql? "complete"
#       # SAFARI BROWSER #
#       when ("Safari")
#         puts ENV['browser_type']
#         caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#         caps.platform = :WINDOWS
#         caps[:name] = 'Watir WebDriver'
#         caps['browser'] = "#{@browser_type}"
#         caps['browser_version'] = '12.0'
#         caps['name'] = "#{$test_name}"
#         caps['os'] = 'OS X'
#         caps['os_version'] = 'Mojave'
#         caps['resolution'] = '1024x768'
#         caps['browserstack.debug'] ='true'
#         caps["record_video"] = "true"
#         @browser = Watir::Browser.new(:remote,
#         :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#         :desired_capabilities => caps)
#         @website =  ENV['demo_url'] || "https://demo.pricespider.com/wtb/Demos/WTBO-2500/Case3/Hybrid/?ps-version=0.0.4.53"
#         @browser.goto @website
#         @browser.window.maximize()
#         # @browserLoadTimes = @browser.performance.summary[:response_time]
#         # puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#         # @blt = @browserLoadTimes
#         # @seconds = @blt / 1000 # miliseconds
#         # puts "Browser Load Time In Seconds Is: #{@seconds}"
#         # @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#         # puts @newBrowserLoadTime
#         @browser.ready_state.eql? "complete"
#       # IE BROWSER #
#       when ("IE")
#         puts ENV['browser_type']
#         caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#         caps.platform = :WINDOWS
#         caps[:name] = 'Watir WebDriver'
#         caps['browser'] = "#{@browser_type}"
#         caps['browser'] = 'IE'
#         caps['browser_version'] = '11.0'
#         caps['os'] = 'Windows'
#         caps['os_version'] = '10'
#         caps['resolution'] = '1024x768'
#         caps['browserstack.debug'] ='true'
#         caps["record_video"] = "true"
#         @browser = Watir::Browser.new(:remote,
#         :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#         :desired_capabilities => caps)
#         @website =  ENV['demo_url'] || "https://demo.pricespider.com/wtb/Demos/WTBO-2500/Case3/Hybrid/?ps-version=0.0.4.53"
#         @browser.goto @website
#         @browser.window.maximize()
#         @browserLoadTimes = @browser.performance.summary[:response_time]
#         puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#         @blt = @browserLoadTimes
#         @seconds = @blt / 1000 # miliseconds
#         puts "Browser Load Time In Seconds Is: #{@seconds}"
#         @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#         puts @newBrowserLoadTime
#         @browser.ready_state.eql? "complete"
#       # EDGE BROWSER #
#       when ("Edge")
#         puts ENV['browser_type']
#         caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
#         caps.platform = :WINDOWS
#         caps[:name] = 'Watir WebDriver'
#         caps['browser'] = "#{@browser_type}"
#         caps['browser'] = 'Edge'
#         caps['browser_version'] = '18.0'
#         caps['os'] = 'Windows'
#         caps['os_version'] = '10'
#         caps['resolution'] = '1024x768'
#         caps['browserstack.debug'] ='true'
#         caps["record_video"] = "true"
#         @browser = Watir::Browser.new(:remote,
#         :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
#         :desired_capabilities => caps)
#         @website =  ENV['demo_url'] || "https://demo.pricespider.com/wtb/Demos/WTBO-2500/Case3/Hybrid/?ps-version=0.0.4.53"
#         @browser.goto @website
#         @browser.window.maximize()
#         @browserLoadTimes = @browser.performance.summary[:response_time]
#         puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#         @blt = @browserLoadTimes
#         @seconds = @blt / 1000 # miliseconds
#         puts "Browser Load Time In Seconds Is: #{@seconds}"
#         @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#         puts @newBrowserLoadTime
#         @browser.ready_state.eql? "complete"
#       end
#     end
# #MEGA NETHERLANDS WIDGET
#   def launch_ps_demo_app_mega_ne
#     Watir.logger.ignore(:deprecations)
#     if ENV['driver'] == 'headless'
#       $opts = Selenium::WebDriver::Firefox::Options::new(args: ['-headless'])
#     end
#     @client = Selenium::WebDriver::Remote::Http::Default.new
#     @client.read_timeout = 120
#     @profile = Selenium::WebDriver::Firefox::Profile.new#CHANGE
#     @profile['browser.download.dir'] = "/tmp/webdriver-downloads"
#     @profile['browser.download.folderList'] = 2
#     @profile['browser.helperApps.neverAsk.saveToDisk'] = "application/octet-stream"
#     @browser = Watir::Browser.new :firefox, :profile => @profile, :http_client => @client, :options => $opts #CHANGE
#     @browser.driver.manage.timeouts.page_load = 120
#     @browser.window.maximize()
#     @website = ENV['demo_url'] || $wtb_mega_ne_demo_url
#     @browser.goto @website
#     @browserLoadTimes = @browser.performance.summary[:response_time]
#     puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#     @blt = @browserLoadTimes
#     @seconds = @blt / 1000 # miliseconds
#     puts "Browser Load Time In Seconds Is: #{@seconds}"
#     @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#     puts @newBrowserLoadTime
#     @browser.ready_state.eql? "complete"
#   end
#
#   def launch_ps_demo_app_mega_ne_default_profile
#     Watir.logger.ignore(:deprecations)
#     if ENV['driver'] == 'headless'
#       $opts = Selenium::WebDriver::Firefox::Options::new(args: ['-headless'])
#     end
#     @client = Selenium::WebDriver::Remote::Http::Default.new
#     @client.read_timeout = 120
#     @profile_2 = Selenium::WebDriver::Firefox::Profile.from_name "default-1481575486611"#CHANGE
#     @profile_2['browser.download.dir'] = "/tmp/webdriver-downloads"
#     @profile_2['browser.download.folderList'] = 2
#     @profile_2['browser.helperApps.neverAsk.saveToDisk'] = "application/octet-stream"
#     @browser = Watir::Browser.new :firefox, :profile => @profile_2, :http_client => @client, :options => $opts#CHANGE
#     @browser.driver.manage.timeouts.page_load = 120
#     @browser.window.maximize()
#     @website = ENV['demo_url'] || $wtb_mega_ne_demo_url
#     @browser.goto @website
#     @browserLoadTimes = @browser.performance.summary[:response_time]
#     puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
#     @blt = @browserLoadTimes
#     @seconds = @blt / 1000 # miliseconds
#     puts "Browser Load Time In Seconds Is: #{@seconds}"
#     @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
#     puts @newBrowserLoadTime
#     @browser.ready_state.eql? "complete"
#   end
#
#   def screen_shot
#     $screen_shot_time = Time.now.strftime("%I-%M")
#     @browser.screenshot.save "/Users/carlosramirez/git/wtb-automation-ps/screenshots/""#{$screen_shot_time}""_""#{$test_name}"".png"
#   end
#
#   def close_browser
#     @browser.close
#   end
# end
