#This test is to verify all widgets load as expected
require_relative '../ps_wtb_embedded_widget_helpers'
require_relative '../ps_wtb_lightbox_widget_helpers'
require_relative '../ps_wtb_mega_widget_helpers'
require_relative '../ps_wtb_send_keys_helpers'
require_relative '../ps_wtb_demo_url_embedded_dual_helpers'
require_relative '../ps_wtb_demo_url_embedded_tabbed_helpers'
require_relative '../ps_wtb_demo_url_lightbox_dual_helpers'
require_relative '../ps_wtb_demo_url_lightbox_tabbed_helpers'
require_relative '../ps_wtb_demo_url_mega_helpers'
require_relative '../ps_wtb_demo_url_mega_ne_helpers'
require_relative '../ps_wtb_demo_url_hybrid_helpers'

RSpec.configure do |c|
  c.include EmbeddedHelpers
  c.include Lightbox
  c.include MegaMenu
  c.include SendKeys
  c.include EmbeddedDualWidget
  c.include EmbeddedTabbedWidget
  c.include LightboxDualWidget
  c.include LightboxTabbedWidget
  c.include MegaWidget
  c.include MegaNeWidget
  c.include HybridWidget
end
#EMBEDDED DUAL
RSpec.describe "000: Verification of Embedded Dual widget loads", ps_000_all_widgets: true, ps_all_widgets: true do
  begin
    before(:all) do
      puts "000_wtb_all_widgets_load_test_embedded_dual"
      launch_ps_demo_app_embedded_dual
    end

    before(:each) do
      puts "Step Start Time:#{$step_start_time = Time.new}"
    end

    after(:each) do
      puts "Step End Time:#{$step_end_time = Time.now}"
      puts "Edited Time: #{$step_end_time - $step_start_time}"
    end

    it "Verifies the Find Online section is displayed for Embedded Dual widget" do
       embedded_pg_wtb_header.wait_until(&:present?)
      if expect(embedded_pg_online_label).to be_truthy
        puts "#{true}: The Find Online Label IS Displayed EMBEDDED DUAL"
        embedded_pg_online_label.flash
      else
        expect { raise StandardError, 'The Find Online Label NOT Displayed: Step FAILED'}.should raise_error('The Find Online Label NOT Displayed')
      end
    end
  ensure
    after(:all) do
      close_browser
    end
  end
end
#EMBEDDED TABBED
RSpec.describe "Verification of Embedded Tabbed widget loads", ps_000_all_widgets: true, ps_all_widgets: true do
  begin
    before(:all) do
      puts "000_wtb_all_widgets_load_test_embedded_tabbed"
      launch_ps_demo_app_embedded_tabbed
    end

    before(:each) do
      puts "Step Start Time:#{$step_start_time = Time.new}"
    end

    after(:each) do
      puts "Step End Time:#{$step_end_time = Time.now}"
      puts "Edited Time: #{$step_end_time - $step_start_time}"
    end

    it "Verifies the Find Online section is displayed for Embedded Tabbed widget" do
       sleep(3)
      if expect(embedded_pg_online_label).to be_truthy
        puts "#{true}: The Find Online Label IS Displayed EMBEDDED TABBED"
        embedded_pg_online_label.flash
      else
        expect { raise StandardError, 'The Find Online Label NOT Displayed: Step FAILED'}.should raise_error('The Find Online Label NOT Displayed')
      end
    end
  ensure
    after(:all) do
      close_browser
    end
  end
end
#LIGHTBOX DUAL
RSpec.describe "Verification of Lightbox Dual widget loads", ps_000_all_widgets: true, ps_all_widgets: true do
  begin
    before(:all) do
      puts "000_wtb_all_widgets_load_test_lightbox_dual"
      launch_ps_demo_app_lightbox_dual
    end

    before(:each) do
      puts "Step Start Time:#{$step_start_time = Time.new}"
    end

    after(:each) do
      puts "Step End Time:#{$step_end_time = Time.now}"
      puts "Edited Time: #{$step_end_time - $step_start_time}"
    end

    it "Clicks on the Where To Buy link" do
      if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
        sleep(5)
        lightbox_widget_where_to_buy_link.flash
        lightbox_widget_where_to_buy_link.fire_event :click
      else
        lightbox_widget_where_to_buy_link.wait_until(&:present?)
        lightbox_widget_where_to_buy_link.flash
        lightbox_widget_where_to_buy_link.click
      end
    end

    it "Verifies the Find Online section and store is displayed Lightbox Dual" do
       sleep(3)
      if expect(embedded_pg_online_label).to be_truthy
        puts "#{true}: The Find Online Label IS Displayed for LIGHTBOX DUAL"
        embedded_pg_online_label.flash
      else
        expect { raise StandardError, 'The Find Online Label NOT Displayed: Step FAILED'}.should raise_error('The Find Online Label NOT Displayed')
      end
    end
  ensure
    after(:all) do
      close_browser
    end
  end
end
#LIGHTBOX TABBED
RSpec.describe "Verification of Lightbox Tabbed widget loads", ps_000_all_widgets: true, ps_all_widgets: true do
  begin
    before(:all) do
      puts "000_wtb_all_widgets_load_test_lightbox_tabbed"
      launch_ps_demo_app_lightbox_tabbed
    end

    before(:each) do
      puts "Step Start Time:#{$step_start_time = Time.new}"
    end

    after(:each) do
      puts "Step End Time:#{$step_end_time = Time.now}"
      puts "Edited Time: #{$step_end_time - $step_start_time}"
    end

    it "Clicks on the Where To Buy link" do
      if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
        sleep(5)
        lightbox_widget_where_to_buy_link.flash
        lightbox_widget_where_to_buy_link.fire_event :click
      else
        lightbox_widget_where_to_buy_link.wait_until(&:present?)
        lightbox_widget_where_to_buy_link.flash
        lightbox_widget_where_to_buy_link.click
      end
    end

    it "Verifies the Find Online section and store is displayed for Lightbox Tabbed" do
       sleep(3)
      if expect(embedded_pg_online_label).to be_truthy
        puts "#{true}: The Find Online Label IS Displayed for LIGHTBOX TABBED"
        embedded_pg_online_label.flash
      else
        expect { raise StandardError, 'The Find Online Label NOT Displayed: Step FAILED'}.should raise_error('The Find Online Label NOT Displayed')
      end
    end
  ensure
    after(:all) do
      close_browser
    end
  end
end
#MEGA
RSpec.describe "Verification of Mega widget loads", ps_000_all_widgets: true, ps_all_widgets: true do
  begin
    before(:all) do
      puts "000_wtb_all_widgets_load_test_mega"
      launch_ps_demo_app_mega
    end

    before(:each) do
      puts "Step Start Time:#{$step_start_time = Time.new}"
    end

    after(:each) do
      puts "Step End Time:#{$step_end_time = Time.now}"
      puts "Edited Time: #{$step_end_time - $step_start_time}"
    end

    it "Clicks on the Buy Now button" do
      if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
        sleep(5)
        mega_widget_buy_now_button.flash
        mega_widget_buy_now_button.click
      else
        mega_widget_buy_now_button.wait_until(&:present?)
        mega_widget_buy_now_button.flash
        mega_widget_buy_now_button.click
      end
    end

    it "Verifies the Find Online section and store is displayed for Mega" do
       sleep(3)
       embedded_pg_online_label.wait_until(&:present?)
      if expect(embedded_pg_online_label).to be_truthy
        puts "#{true}: The Find Online Label IS Displayed for MEGA"
        embedded_pg_online_label.flash
      else
        expect { raise StandardError, 'The Find Online Label NOT Displayed: Step FAILED'}.should raise_error('The Find Online Label NOT Displayed')
      end
    end
  ensure
    after(:all) do
      close_browser
    end
  end
end
#MEGA NE
RSpec.describe "Verification of Mega NE widget loads", ps_000_all_widgets: true, ps_all_widgets: true do
  begin
    before(:all) do
      puts "000_wtb_all_widgets_load_test_mega_ne"
      launch_ps_demo_app_mega_ne
    end

    before(:each) do
      puts "Step Start Time:#{$step_start_time = Time.new}"
    end

    after(:each) do
      puts "Step End Time:#{$step_end_time = Time.now}"
      puts "Edited Time: #{$step_end_time - $step_start_time}"
    end

    it "Clicks on the Buy Now button" do
      if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
        sleep(5)
        mega_widget_buy_now_button.flash
        mega_widget_buy_now_button.click
      else
        mega_widget_buy_now_button.wait_until(&:present?)
        mega_widget_buy_now_button.flash
        mega_widget_buy_now_button.click
      end
    end

    it "Sets the country in text field" do
      if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
        sleep(5)
        mega_widget_search_box.flash
        mega_widget_search_box.set ($search_city_4)
        send_keys_enter
        sleep(5)
      else
        mega_widget_search_box.wait_until(&:present?)
        mega_widget_search_box.flash
        mega_widget_search_box.set ($search_city_4)
        send_keys_enter
        sleep(5)
      end
    end

    it "Verifies the Find Online section and store is displayed for Mega NE" do
       sleep(3)
       embedded_pg_online_label.wait_until(&:present?)
      if expect(embedded_pg_online_label).to be_truthy
        puts "#{true}: The Find Online Label IS Displayed for MEGA NE"
        embedded_pg_online_label.flash
      else
        expect { raise StandardError, 'The Find Online Label NOT Displayed: Step FAILED'}.should raise_error('The Find Online Label NOT Displayed')
      end
    end
  ensure
      after(:all) do
        close_browser
      end
    end
  end
#HYBRID
RSpec.describe "Verification of Hybrid widget loads", ps_000_all_widgets: true, ps_all_widgets: true do
  begin
    before(:all) do
      puts "000_wtb_all_widgets_load_test_hybrid"
      launch_ps_demo_app_hybrid
    end

    before(:each) do
      puts "Step Start Time:#{$step_start_time = Time.new}"
    end

    after(:each) do
      puts "Step End Time:#{$step_end_time = Time.now}"
      puts "Edited Time: #{$step_end_time - $step_start_time}"
    end

    it "Verifies the Find Online section is displayed for Hybrid" do
      if ENV['app_type'] == 'browserstack' and ENV['browser_type'] == 'Edge'
        sleep(5)
      else
        embedded_pg_wtb_header.wait_until(&:present?)
      end
      if expect(embedded_pg_online_label).to be_truthy
        puts "#{true}: The Find Online Label IS Displayed for HYBRID"
        embedded_pg_online_label.flash
      else
        expect { raise StandardError, 'The Find Online Label NOT Displayed: Step FAILED'}.should raise_error('The Find Online Label NOT Displayed')
      end
    end
  ensure
    after(:all) do
      close_browser
    end
  end
end
