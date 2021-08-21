require 'watir'
require 'rspec'
require 'pry'
require 'rubygems'
require 'selenium-webdriver'
require 'rspec/expectations'
require 'base64'
require 'mail'
require_relative 'ps_wtb_encoding_helpers'

$screen_shot_time = Time.new

module Email
  include RSpec::Matchers
  include Selenium

  def email_sending(string)
    options = { :address              => "smtp.gmail.com",
                :port                 => 587,
                :domain               => "localhost",
                :user_name            => "#{$myEmail}",
                :password             => "#{$myPassword}",
                :authentication       => "plain",
                :enable_starttls_auto => true  }

    Mail.deliver do
      delivery_method :smtp, options
      to "#{$toTestEmail}"
      from "automationTesting@testing.com"
      subject "Testing Failure For Test: #{$test_number}"
      # body "testing sendmail 5"

      # text_part do
      #   body 'Put your plain text here'
      # end

      html_part do
        content_type 'text/html; charset=UTF-8'
        body "<h1>Test #{$test_number} Failed Screenshot Below</h1>"
      end
        add_file "#{$error_screenshot_path}"
    end
  end
end
