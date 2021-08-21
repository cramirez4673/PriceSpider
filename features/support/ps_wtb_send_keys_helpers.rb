require 'watir'
require 'rspec'
require 'pry'
require 'rubygems'
require 'selenium-webdriver'
require 'rspec/expectations'

module SendKeys
	include RSpec::Matchers
	include Selenium

  def send_keys_arrow_down
    @browser.send_keys :arrow_down
  end

  def send_keys_arrow_up
    @browser.send_keys :arrow_up
  end

  def send_keys_enter
    @browser.send_keys :enter
  end

  def send_keys_page_down
    @browser.send_keys :page_down
  end

  def send_keys_page_up
    @browser.send_keys :page_up
  end

  def send_keys_tab
    @browser.send_keys :tab
  end

  def send_keys_set_text(set_text)
    @browser.send_keys(set_text)
  end

  def send_keys_page_back
    @browser.send_keys :command, :arrow_left
  end

  def send_keys_command_down
    @browser.send_keys :command, :arrow_down
  end

  def send_keys_clear
    @browser.send_keys :clear
  end

  def send_keys_delete
    @browser.send_keys :delete
  end

  def send_keys_space
    @browser.send_keys :space
  end

  def send_keys_insert
    @browser.send_keys :insert
  end

  def send_keys_shift_tab
    @browser.send_keys :shift, :tab
  end

  def send_keys_backspace
    @browser.send_keys :backspace
  end
end
