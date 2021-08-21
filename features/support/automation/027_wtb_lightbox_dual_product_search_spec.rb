#This test is to verify the lightbox widget product search
require_relative '../ps_wtb_demo_url_lightbox_dual_helpers'
require_relative '../ps_wtb_embedded_widget_helpers'
require_relative '../ps_wtb_send_keys_helpers'
require_relative '../ps_wtb_google_maps_pg_helpers'
require_relative '../ps_wtb_windows_helpers'
require_relative '../ps_wtb_wait_helpers'
require_relative '../ps_wtb_amazon_pg_helpers'
require_relative '../ps_wtb_lightbox_widget_helpers'

RSpec.configure do |c|
 c.include LightboxDualWidget
 c.include EmbeddedHelpers
 c.include SendKeys
 c.include WindowsHelpers
 c.include GoogleMaps
 c.include Wait
 c.include Amazon
 c.include Lightbox
end

RSpec.describe "027: Verification of lightbox widget product search", ps_027_lightbox_dual: true, ps_lightbox_dual: true do
begin
 before(:all) do
   puts "027_wtb_lightbox_dual_product_search_test"
   launch_ps_demo_app_lightbox_dual
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

 it "Verifies the Find Online section is displayed" do
   sleep(2)
   if expect(embedded_pg_online_label).to be_truthy
     puts "#{true}: The Find Online Label IS Displayed"
     embedded_pg_online_label.flash
   else
     expect { raise StandardError, 'The Find Online Label NOT Displayed: Step FAILED'}.should raise_error('The Find Online Label NOT Displayed')
   end
 end

 it "Puts the product detail" do
   puts "Product Detail Box Text: #{lightbox_widget_details_float_box.text}"
 end

 it "Clicks on the product drop down option 12" do
   if lightbox_widget_online_product_drop_down.present?
     if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
       lightbox_widget_online_product_drop_down.flash
       lightbox_widget_specific_product_select_list_safari_option_12.click
       sleep(2)
       lightbox_widget_size_selection_dropdown.flash
       lightbox_widget_specific_size_select_list_safari_option_12.click
       $expected_product_name_12 = lightbox_widget_details_float_box.text
       puts "Product Detail Box Text: #{$expected_product_name_12}"
     else
       lightbox_widget_online_product_drop_down.flash
       lightbox_widget_online_product_drop_down.click
       sleep(2)
       lightbox_widget_specific_product_select_list(11)
       sleep(2)
       lightbox_widget_size_selection_dropdown.flash
       lightbox_widget_specific_size_select_list(1)
       $expected_product_name_12 = lightbox_widget_details_float_box.text
       puts "Product Detail Box Text: #{$expected_product_name_12}"
     end
   else
     puts "No Product Drop Down Displayed"
   end
 end

 it "Verifies the Product Search for option 12" do
  if lightbox_widget_online_product_drop_down.present?
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
      verify_lightbox_product_search_safari_option_12
    else
      verify_lightbox_product_search_option_12
    end
  else
    puts "No Product Drop Down Displayed"
  end
 end

 it "Clicks on the product drop down option 4" do
   if lightbox_widget_online_product_drop_down.present?
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
      lightbox_widget_online_product_drop_down.flash
      lightbox_widget_specific_product_select_list_safari_option_4.click
      sleep(2)
      lightbox_widget_size_selection_dropdown.flash
      lightbox_widget_specific_size_select_list_safari_option_4.click
      $expected_product_name_4 = lightbox_widget_details_float_box.text
      puts "Product Detail Box Text: #{$expected_product_name_4}"
    else
      lightbox_widget_online_product_drop_down.flash
      lightbox_widget_online_product_drop_down.click
      sleep(2)
      lightbox_widget_specific_product_select_list(3)
      sleep(2)
      lightbox_widget_size_selection_dropdown.flash
      lightbox_widget_specific_size_select_list(0)
      $expected_product_name_4 = lightbox_widget_details_float_box.text
      puts "Product Detail Box Text: #{$expected_product_name_4}"
    end
   else
     puts "No Product Drop Down Displayed"
   end
 end

 it "Verifies the Product Search for option 4" do
  if lightbox_widget_online_product_drop_down.present?
    if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Safari'
      verify_lightbox_product_search_safari_option_4
    else
     verify_lightbox_product_search_option_4
    end
  else
    puts "No Product Drop Down Displayed"
  end
 end
ensure
  after(:all) do
    close_browser
  end
end
end
