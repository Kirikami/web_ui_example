class BasePage
  include PageObject
  require_relative '../../../features/support/fixtures'

  BASE_URL = ENV['URL'] if ENV['URL']
  BASE_URL ||= Fixtures.instance[:url]
  CREDENTIALS ||= Fixtures.instance[:credentials]

end