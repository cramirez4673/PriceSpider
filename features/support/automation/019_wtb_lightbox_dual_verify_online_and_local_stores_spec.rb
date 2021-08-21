#This test is to verify the lightbox widget colums
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
  c.include Wait
  c.include Lightbox
end

RSpec.describe "019: Verification of the lightbox widget colums", ps_019_lightbox_dual: true, ps_lightbox_dual: true do
begin
  before(:all) do
    puts "019_wtb_lightbox_dual_verify_online_and_local_stores_test"
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
