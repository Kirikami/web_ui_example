class LoginPage < BasePage
  include PageObject

  page_url "#{BASE_URL}/login"

  div :logo, class: 'kountable-logo'
  text_field :email, xpath: '//div[2]/div[1]/div/input'
  text_field :password, xpath: '//div[3]/div[1]/div/input'
  link :forgot_password, css: '.form-group a'
  button :login, class: 'btn-primary'
  div :error_message, class: 'alert'
  link :sign_up, css: 'em a'

  def sign_in (type)
    if type != 'empty'
      creds = CREDENTIALS[type.to_sym]
      self.email = creds[:email]
      self.password = creds[:password]
    else
      self.email = ''
      self.password = ''
    end
    login
  end

  def have_error_message?
    error_message_element.visible?
  end

  def go_to_sign_up
    sign_up
  end

  def open_forgot_password_form
    forgot_password
  end

  def has_logo?
    logo_element.visible?
  end
end