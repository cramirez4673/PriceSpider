require 'watir'
require 'rspec'
require 'pry'
require 'rubygems'
require 'selenium-webdriver'
require 'rspec/expectations'
require 'allure-rspec'

if ENV['allure'] == 'no'
 puts "Not Using Allure Reporting"
else
 RSpec.configure do |c|
   c.include AllureRSpec::Adaptor
   c.example_status_persistence_file_path = "examples.txt"
 end
end
