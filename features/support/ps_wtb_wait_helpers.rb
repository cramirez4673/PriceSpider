module Wait
    include RSpec::Matchers
    include Selenium

    def browser_ready_state?
        Watir.default_timeout = 200
        @browser.ready_state.eql? "complete"
    end
end
