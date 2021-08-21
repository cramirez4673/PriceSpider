#This test is to verify the embedded tabbed widget
require_relative '../ps_wtb_demo_url_embedded_tabbed_helpers'
require_relative '../ps_wtb_embedded_widget_helpers'
require_relative '../ps_wtb_send_keys_helpers'
require_relative '../ps_wtb_google_maps_pg_helpers'
require_relative '../ps_wtb_windows_helpers'
require_relative '../ps_wtb_wait_helpers'
require_relative '../ps_wtb_amazon_pg_helpers'

RSpec.configure do |c|
  c.include EmbeddedTabbedWidget
  c.include EmbeddedHelpers
  c.include SendKeys
  c.include WindowsHelpers
  c.include GoogleMaps
  c.include Wait
  c.include Amazon
  c.include Wait
end

RSpec.describe "011: Verification of embedded tabbed widget", ps_011_embedded_tabbed: true, ps_embedded_tabbed: true do
begin
  before(:all) do
    puts "011_wtb_embedded_tabbed_verify_online_and_local_stores_test"
    launch_ps_demo_app_embedded_tabbed
  end

  it "Verifies the Find Online section and store is displayed" do
     sleep(3)
    if expect(embedded_pg_online_label).to be_truthy
      puts "#{true}: The Find Online Label IS Displayed"
      embedded_pg_online_label.flash
      puts $online_store_1 = embedded_pg_online_retalier_info_row_1.attribute_value("data-retailer")
      puts embedded_pg_view_button_1.attribute_value("data-retailer")
      if (embedded_pg_view_button_1.attribute_value("data-retailer").include? "#{$online_store_1}") == true
        embedded_pg_view_button_1.flash
        puts "Online Store #{$online_store_1} Displayed for Online Section"
      else
        expect { raise StandardError, 'No Stores Displayed for Find Online Section: Step FAILED'}.should raise_error('No Stores Displayed for Find Online Section')
      end
    else
      expect { raise StandardError, 'The Find Online Label NOT Displayed: Step FAILED'}.should raise_error('The Find Online Label NOT Displayed')
    end
  end

  it "Verifies the Find Nearby section and store is displayed" do
    if expect(embedded_pg_local_label).to be_truthy
      puts "#{true}: The Find Local Label IS Displayed"
      embedded_pg_local_label.flash
      embedded_pg_local_label.click
      if expect(embedded_pg_local_logo_1_image.present?).to be_truthy
        embedded_pg_local_logo_1_image.flash
        puts @local_store_0  = embedded_pg_local_logo_1_attribute[9...20]
        $local_store_1 = @local_store_0.gsub!(/[\s!@%\/&"']/,'')
        puts "Local Seller #{$local_store_1} Store Displayed"
      else
        expect { raise StandardError, 'No Stores Displayed for Find Nearby Section: Step FAILED'}.should raise_error('No Stores Displayed for Find Nearby Section')
      end
    else
      expect { raise StandardError, 'The Find Local Label NOT Displayed: Step FAILED'}.should raise_error('The Find Local Label NOT Displayed')
    end
  end
ensure
  after(:all) do
    close_browser
  end
end
end
