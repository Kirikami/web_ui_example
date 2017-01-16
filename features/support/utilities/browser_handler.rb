class BrowserHandler

  BROWSER_CONF ||= {chrome: {name: 'chrome', page_wait: 120, element_wait: 120, full_screen: true},
                    ff: {name: 'firefox', page_wait: 120, element_wait: 120, full_screen: true}
  }

  def self.browser
    @browser ||= get_driver_browser
  end

  def self.delete_driver_browser
    @browser = nil
    @browser
  end

  def self.get_driver_browser
    browser_agent = get_browser_agent
    browser_agent_conf = BROWSER_CONF[browser_agent]
    PageObject.default_element_wait = browser_agent_conf[:element_wait]
    PageObject.default_page_wait = browser_agent_conf[:page_wait]
    prefs = {
        # :logging_prefs => {:browser => "ALL"}
    #     :download => {
    #         :prompt_for_download => false,
    #         :default_directory => DIRECTORY
        # }
    }
    case ENV['DRIVER']
      when 'selenium'
        browser = Selenium::WebDriver.for browser_agent, :prefs => prefs
      when 'watir'
        browser = Watir::Browser.new browser_agent#, :prefs => prefs
        browser.driver.manage.window.maximize if browser_agent_conf[:full_screen]
      else
        browser = Watir::Browser.new browser_agent#, :prefs => prefs
        if browser_agent_conf[:full_screen]
          # workaround for OS X Yosemite cannot maximize
          browser.driver.manage.window.resize_to(1440, 900)
          browser.driver.manage.window.maximize
        else
          browser.driver.manage.window.resize_to(1920, 1080)
        end
    end
    browser
  end

  def self.get_browser_agent
    case ENV['BROWSER_AGENT']
      when /chrome/i
        :chrome
      when /(firefox|ff)/i
        :ff
      else
        :chrome
    end
  end

end