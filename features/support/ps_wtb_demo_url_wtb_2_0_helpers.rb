require 'watir'
require 'rspec'
require 'pry'
require 'rubygems'
require 'selenium-webdriver'
require 'rspec/expectations'
require 'webdriver-user-agent'
require 'pp'
require 'typhoeus'
require 'watir-performance'
require 'time'
require_relative 'spec_helper'

$wtb_2_0_wtb_demo_url = "https://pediasure.com/where-to-buy-pediasure?ps-sku=58049"
$username = "carlos.ramirez@pricespider.com"
$authkey = "u5559ff22c6a1e42"

module WTB20Widget
  include RSpec::Matchers
  include Selenium

##########################WTB 2.0 WTB WIDGET##################################

  def launch_ps_demo_app_wtb_2_0_wtb
    Watir.logger.ignore(:deprecations)
    Watir.default_timeout = 120
    if ENV['driver'] == 'headless'
      puts "Using Headless Environment"
      $opts = Selenium::WebDriver::Firefox::Options::new(args: ['-headless'])
    end
    if ENV['app_type'] == 'local'
      puts "Using Local Environment"
      @client = Selenium::WebDriver::Remote::Http::Default.new
      @client.read_timeout = 120
      @profile = Selenium::WebDriver::Firefox::Profile.new#CHANGE
      @profile['browser.download.dir'] = "/tmp/webdriver-downloads"
      @profile['browser.download.folderList'] = 2
      @profile['browser.helperApps.neverAsk.saveToDisk'] = "application/octet-stream"
      @browser = Watir::Browser.new :firefox, :profile => @profile, :http_client => @client, :options => $opts #CHANGE
      @browser.driver.manage.timeouts.page_load = 120
      @browser.window.maximize()
      @website = ENV['demo_url'] || $wtb_2_0_wtb_demo_url
      @browser.goto @website
      # @browserLoadTimes = @browser.performance.summary[:response_time]
      # puts "Inintial Browser Load Time:#{@browserLoadTimes} MILISECONDS"
      # @blt = @browserLoadTimes
      # @seconds = @blt / 1000 # miliseconds
      # puts "Initial Browser Load Time In Seconds Is: #{@seconds}"
      # @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
      # puts @newBrowserLoadTime
      @browser.ready_state.eql? "complete"
    elsif ENV['app_type'] == 'browserstack'
      puts "Using Browserstack Environment"
      Watir.logger.ignore(:deprecations)
    case @browser_type = ENV['browser_type']
    # CHROME BROWSER #
      when ("Chrome")
        puts ENV['browser_type']
        caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
        caps.platform = :WINDOWS
        caps[:name] = 'Watir WebDriver'
        caps['browser'] = "#{@browser_type}"
        caps['browser_version'] = '75.0'
        caps['name'] = "#{$test_name}"
        caps['os'] = 'OS X'
        caps['os_version'] = 'Mojave'
        caps['resolution'] = '1280x960'
        caps['browserstack.debug'] ='true'
        caps['browserstack.networkLogs'] = 'true'
        caps['record_video'] = 'true'
        @browser = Watir::Browser.new(:remote,
        :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
        :desired_capabilities => caps)
        @website =  ENV['demo_url'] || $wtb_2_0_wtb_demo_url
        @browser.goto @website
        @browser.window.maximize()
        @browserLoadTimes = @browser.performance.summary[:response_time]
        puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
        @blt = @browserLoadTimes
        @seconds = @blt / 1000 # miliseconds
        puts "Browser Load Time In Seconds Is: #{@seconds}"
        @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
        puts @newBrowserLoadTime
        @browser.ready_state.eql? "complete"
    # FIREFOX BROWSER #
      when ("Firefox")
        puts ENV['browser_type']
        caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
        caps.platform = :WINDOWS
        caps[:name] = 'Watir WebDriver'
        caps['browser'] = "#{@browser_type}"
        caps['browser_version'] = '70.0'
        caps['name'] = "#{$test_name}"
        caps['os'] = 'OS X'
        caps['os_version'] = 'Mojave'
        caps['resolution'] = '1280x960'
        caps['browserstack.debug'] ='true'
        caps["record_video"] = "true"
        @browser = Watir::Browser.new(:remote,
        :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
        :desired_capabilities => caps)
        @website =  ENV['demo_url'] || $wtb_2_0_wtb_demo_url
        @browser.goto @website
        @browser.window.maximize()
        @browserLoadTimes = @browser.performance.summary[:response_time]
        puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
        @blt = @browserLoadTimes
        @seconds = @blt / 1000 # miliseconds
        puts "Browser Load Time In Seconds Is: #{@seconds}"
        @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
        puts @newBrowserLoadTime
        @browser.ready_state.eql? "complete"
    # SAFARI BROWSER #
      when ("Safari")
        puts ENV['browser_type']
        caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
        caps.platform = :WINDOWS
        caps[:name] = 'Watir WebDriver'
        caps['browser'] = "#{@browser_type}"
        caps['browser_version'] = '11.1'
        caps['name'] = "#{$test_name}"
        caps['os'] = 'OS X'
        caps['os_version'] = 'High Sierra'
        caps['resolution'] = '1280x960'
        caps['browserstack.debug'] ='true'
        caps["record_video"] = "true"
        @browser = Watir::Browser.new(:remote,
        :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
        :desired_capabilities => caps)
        @website =  ENV['demo_url'] || $wtb_2_0_wtb_demo_url
        @browser.goto @website
        @browser.window.maximize()
        @browser.ready_state.eql? "complete"
    # IE BROWSER #
      when ("IE")
        puts ENV['browser_type']
        caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
        caps.platform = :WINDOWS
        caps[:name] = 'Watir WebDriver'
        caps['browser'] = "#{@browser_type}"
        caps['browser'] = 'IE'
        caps['browser_version'] = '11.0'
        caps['os'] = 'Windows'
        caps['os_version'] = '10'
        caps['resolution'] = '1280x800'
        caps['browserstack.debug'] ='true'
        caps["record_video"] = "true"
        @browser = Watir::Browser.new(:remote,
        :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
        :desired_capabilities => caps)
        @website =  ENV['demo_url'] || $wtb_2_0_wtb_demo_url
        @browser.goto @website
        @browser.window.maximize()
        @browserLoadTimes = @browser.performance.summary[:response_time]
        puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
        @blt = @browserLoadTimes
        @seconds = @blt / 1000 # miliseconds
        puts "Browser Load Time In Seconds Is: #{@seconds}"
        @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
        puts @newBrowserLoadTime
        @browser.ready_state.eql? "complete"
    # EDGE BROWSER #
      when ("Edge")
        puts ENV['browser_type']
        caps = WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
        caps.platform = :WINDOWS
        caps[:name] = 'Watir WebDriver'
        caps['browser'] = "#{@browser_type}"
        caps['browser'] = 'Edge'
        caps['browser_version'] = '18.0'
        caps['os'] = 'Windows'
        caps['os_version'] = '10'
        caps['resolution'] = '1280x800'
        caps['browserstack.debug'] ='true'
        caps["record_video"] = "true"
        @browser = Watir::Browser.new(:remote,
        :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
        :desired_capabilities => caps)
        @website =  ENV['demo_url'] || $wtb_2_0_wtb_demo_url
        @browser.goto @website
        @browser.window.maximize()
        @browserLoadTimes = @browser.performance.summary[:response_time]
        puts "BROWSER LOAD TIME:#{@browserLoadTimes} MILISECONDS"
        @blt = @browserLoadTimes
        @seconds = @blt / 1000 # miliseconds
        puts "Browser Load Time In Seconds Is: #{@seconds}"
        @newBrowserLoadTime = Time.at(@seconds).utc.strftime("%H:%M:%S:%L")
        puts @newBrowserLoadTime
        @browser.ready_state.eql? "complete"
    # MOBILE APP #
    # when ("Mobile")
    #   puts ENV['browser_type']
    #   caps = Selenium::WebDriver::Remote::Capabilities.new
    #   caps[:browserName] = 'iPhone'
    #   caps['device'] = 'iPhone XS'
    #   caps['realMobile'] = 'true'
    #   caps['os_version'] = '12'
    #   caps['name'] = 'Bstack-[Ruby] Sample Test'
    #   driver = Selenium::WebDriver.for(:remote,
    #     :url => "http://pricespider1:iV1H9sErwBZstLsfsvss@hub-cloud.browserstack.com/wd/hub",
    #     :desired_capabilities => caps)
    #     @browser = Watir::Browser.new driver
    #     @website =  ENV['demo_url'] || $wtb_embedded_dual_demo_url
    #     @browser.goto @website
      end
    end
  end

  def close_browser
    @browser.close
  end
end
