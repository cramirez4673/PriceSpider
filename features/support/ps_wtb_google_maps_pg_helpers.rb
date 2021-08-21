require 'watir'
require 'rspec'
require 'pry'
require 'rubygems'
require 'selenium-webdriver'
require 'rspec/expectations'

$google_maps_partial_url = "https://www.google.com/maps/dir/"

module GoogleMaps
	include RSpec::Matchers
	include Selenium

  def google_maps_list_box
    @browser.div(id: 'omnibox-directions')
  end

  def google_maps_drive_icon
    @browser.div(class: ["directions-travel-mode-icon", "directions-drive-icon"])
  end
end
