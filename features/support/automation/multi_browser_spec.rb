# require 'watir'
# require 'rspec'
# require_relative '../ps_wtb_send_keys_helpers'
#
# $browsers = [:firefox, :chrome]
# $browsers.map do |x|
#
#   RSpec.describe 'Browser' do
#
#     before(:all) do
#       @browser = Watir::Browser.new x
#     end
#
#     it 'goes to Google.ca' do
#       @browser.goto('http://www.google.com')
#     end
#
#     it 'searches' do
#       sleep(5)
#       @browser.text_field(class: ["gLFyf", "gsfi"]).wait_until_present(5).set 'Real Madrid'
#       @browser.send_keys :enter
#       sleep(5) #roughly takes 0.5s for the images to load.
#     end
#
#     it 'closes browser' do
#       @browser.close
#     end
#   end #end describe
# end #end loop
