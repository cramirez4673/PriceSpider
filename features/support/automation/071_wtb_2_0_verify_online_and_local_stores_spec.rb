#This test is to verify the WTB 2.0 WTB widget dual colums
require_relative '../ps_wtb_2_0_helpers'
require_relative '../ps_wtb_send_keys_helpers'
require_relative '../ps_wtb_google_maps_pg_helpers'
require_relative '../ps_wtb_windows_helpers'
require_relative '../ps_wtb_wait_helpers'
require_relative '../ps_wtb_amazon_pg_helpers'
require_relative '../ps_wtb_demo_url_wtb_2_0_helpers'
require_relative '../ps_wtb_email_helpers'
require_relative '../ps_wtb_embedded_widget_helpers'

RSpec.configure do |c|
  c.order = 'defined'
  c.include WTB20Widget
  c.include WTB20Helpers
  c.include SendKeys
  c.include WindowsHelpers
  c.include GoogleMaps
  c.include Wait
  c.include Amazon
  c.include Email
  c.include EmbeddedHelpers
end

RSpec.describe "071: Verification of embedded dual widget dual colums", ps_071_wtb_2_0: true, ps_wtb_2_0: true do
begin
  before(:all) do
    puts "071_wtb_2_0_wtb_verify_online_and_local_stores_test"
    launch_ps_demo_app_wtb_2_0_wtb
    $test_number = "071"
  end

  after(:each) do
    example_exceptions = []
    RSpec.world.example_groups.each do |example_group|
    example_group.examples.each do |example|
      example_exceptions << !example.exception.nil?
      end
    end
    has_exceptions = example_exceptions.any? {|exception| exception}
    if has_exceptions == true
      $error_screenshot_path = "screenshots/#{Time.now.strftime("%Y-%m-%d-%I%M%S")}-test-#{$test_number}.png"
      @browser.screenshot.save "#{$error_screenshot_path}"
      email_sending("#{$error_screenshot_path}")
    end
  end

  it "Verifies the Find Online section and store is displayed" do
     wtb_2_0_wtb_header.wait_until(&:present?)
     wtb_2_0_wtb_online_retailer_tab.scroll.to :center
     wtb_2_0_wtb_online_retailer_tab.flash
    if expect(wtb_2_0_wtb_online_retailer_tab).to be_truthy
      puts "#{true}: The Find Online Label IS Displayed"
      wtb_2_0_wtb_online_retailer_tab.flash
      puts "Retailer Name: #{wtb_2_0_wtb_online_retailer_seller(wtb_2_0_wtb_retalier_info_row_1.attribute_value("data-seller"))}"
      if ($expected_retailer_seller.include? "#{wtb_2_0_wtb_online_retailer_seller(wtb_2_0_wtb_retalier_info_row_1.attribute_value("data-seller"))}") == true
        wtb_2_0_wtb_retalier_info_row_1.flash
        puts "Online Store #{wtb_2_0_wtb_online_retailer_seller(wtb_2_0_wtb_retalier_info_row_1.attribute_value("data-seller"))} Displayed for Online Section"
      else
        expect { raise StandardError, 'No Stores Displayed for Find Online Section: Step FAILED'}.should raise_error('No Stores Displayed for Find Online Section')
      end
    else
      expect { raise StandardError, 'The Find Online Label NOT Displayed: Step FAILED'}.should raise_error('The Find Online Label NOT Displayed')
    end
  end

  it "Verifies the Find Nearby section and store is displayed" do
    if expect(wtb_2_0_wtb_local_retailer_tab).to be_truthy
      wtb_2_0_wtb_local_retailer_tab.scroll.to :center
      puts "#{true}: The Find Local Label IS Displayed"
      wtb_2_0_wtb_local_retailer_tab.flash
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
