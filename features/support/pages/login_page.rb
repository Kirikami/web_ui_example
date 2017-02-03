class LoginPage < BasePage
  include PageObject

  page_url "#{BASE_URL}/login"

  div :logo, class: 'kountable-logo'
  text_field :email, xpath: '//div[2]/div[1]/div/input'
  text_field :password, xpath: '//div[3]/div[1]/div/input'
  link :forgot_password, css: '.form-group a'
  button :login, class: 'btn-primary'
  div :error_message, class: 'alert'
  divs :input_error_message, class: 'input-error'
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

  def have_error_message? type
    if type == 'credentials'
      error_message_element.visible?
    elsif type == 'input'
      input_error_message_elements.each {|element| result = element.visible?; return result if !result}
    end
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