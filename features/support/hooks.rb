require 'watir'

include ReportHelper

Before do
    if @browser == nil || @browser.instance_variable_get('@closed')
      begin
        @browser = BrowserHandler.browser
      rescue Net::ReadTimeout
        if @browser != nil
          @browser.close
          @browser = BrowserHandler.browser
          sleep 1 unless @browser.ready_state == "complete"
        else
          @browser = BrowserHandler.browser
          sleep 1 unless @browser.ready_state == "complete"
        end
      end
    end
    at_exit do
      if @browser != nil || BrowserHandler.browser != nil
        @browser.close
        BrowserHandler.delete_driver_browser
        @browser = nil
      end
    end
  @browser.cookies.clear
end

After do |scenario|
  if scenario.failed?
    file_path = generate_file_path_and_name(scenario)
    write_html_file(file_path)
    write_log(file_path)
    write_current_cookies(file_path, 'after')
    screenshot_file_path = take_step_screenshot(file_path)
    embed screenshot_file_path, 'image/png'
    browser_url = @browser.url
    puts browser_url


    #allure reporting attachments
    #this workaround is for to not use allure cucumber formatter if it is not enabled through --format
    if AllureCucumber::FeatureTracker.tracker != nil
      attach_file('screenshot', File.new(screenshot_file_path))
      page_url_file_path = "#{file_path}.txt"
      File.open(page_url_file_path, 'w') { |f| f.write(browser_url) }
      attach_file('url', File.new(page_url_file_path)) if File.exist?(page_url_file_path)
      attach_file('html', File.new("#{file_path}.html")) if File.exist?("#{file_path}.html")
      attach_file('log', File.new("#{file_path}.log")) if File.exist?("#{file_path}.log")
      attach_file('test_log', File.new($LOG_FILE)) if File.exist?($LOG_FILE)
      attach_file('cookies', File.new("#{file_path}_after.cookies")) if File.exist?("#{file_path}_after.cookies")
    end

    # if @browser != nil
    #   @browser.close
    #   BrowserHandler.delete_driver_browser
    #   Cucumber.wants_to_quit = true
    # else
    #   Cucumber.wants_to_quit = true
    # end
  else
    $LOG.info("#{scenario.name} passed")
    if @browser != nil
      @browser.close
      BrowserHandler.delete_driver_browser
    end
  end
end
