require 'watir'
require 'rspec'
require 'pry'
require 'rubygems'
require 'selenium-webdriver'
require 'rspec/expectations'
require 'base64'

$myPassword = "vdejhgyjevfrcwxm"
$encoded_password = Base64.encode64("#{@myPassword}")
$myEmail = "cramir3z7373+testing@gmail.com"
$toTestEmail = "cramir3z7373+testing@gmail.com"

def self.encoded_email
  @myEmail
end

def self.encoded_password
  @myPassword
end
