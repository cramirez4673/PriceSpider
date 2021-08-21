#This test is to verify the lightbox widget store times
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

RSpec.describe "026: Verification of lightbox widget store times", ps_026_lightbox_dual: true, ps_lightbox_dual: true do
begin
  before(:all) do
    puts "026_wtb_lightbox_dual_local_seller_store_times_test"
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

  it "Verifies the store times" do
    sleep(3)
    if lightbox_widget_call_for_hours.present?
      puts "Store Status IS: #{lightbox_widget_call_for_hours.text}"
      puts "#{true}: Call For Store Hours Status IS Displayed"
    elsif lightbox_widget_store_open_status.present?
      puts "Store Status IS: #{lightbox_widget_store_open_status.text}"
      puts "#{true}: Open Today Status IS Displayed"
    if embedded_pg_store_hours.present?
      puts "#{true}: Store Hours ARE Displayed"
      puts "Store Hours ARE: #{embedded_pg_store_hours.text}"
    else
      expect { raise StandardError, "Store Hours NOT Displayed: Step FAILED"}.should raise_error("Store Hours NOT Displayed")
    end
    else
      expect { raise StandardError, "Store Status NOT Displayed: Step FAILED"}.should raise_error("Store Status NOT Displayed")
    end
  end
ensure
  after(:all) do
    close_browser
  end
end
end



  #    expect { raise StandardError, "Store Hours NOT Displayed: Step FAILED"}.should raise_error("Store Hours NOT Displayed")
  #   end
  #    lightbox_widget_store_open_status.flash
  #    puts lightbox_widget_store_open_status.text
  #   if expect(lightbox_widget_store_open_status).to exist
  #    puts "#{true}: Store Open Text IS Displayed"
  #   else
  #     expect { raise StandardError, "Store Open Text NOT Displayed: Step FAILED"}.should raise_error("Store Open Text NOT Displayed")
  #   end
  # end
