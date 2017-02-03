class BasePage
  include PageObject
  require_relative '../../../features/support/fixtures'

  BASE_URL = ENV['URL'] if ENV['URL']
  BASE_URL ||= Fixtures.instance[:url]
  CREDENTIALS ||= Fixtures.instance[:credentials]

  def switch_to_last_tab
    @browser.driver.switch_to.window( @browser.driver.window_handles.last )
  end

end