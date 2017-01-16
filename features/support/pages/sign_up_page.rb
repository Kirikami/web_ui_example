class SignUpPage < BasePage
  include PageObject

  page_url "#{BASE_URL}/register"

  text_field :email, xpath: '//div[2]/div[1]/div/input'
  text_field :password, id: 'password'
  link :password_retype, id: 'passwordRetype'
  button :sign_up, class: 'btn-primary'
  div :error_message, class: 'alert'
  link :sign_in, xpath: '//div[4]/div/em/a'


  CREDENTIALS ||= Fixtures.instance[:credentials]

  def sign_up (type)
    creds = CREDENTIALS[type.to_sym]
    self.email = creds[:username]
    self.password = creds[:password]
    self.password_retype = creds[:password]
    login
  end

  def have_error_message?
    error_message_element.visible?
  end

  def go_to_sign_in
    sign_in
  end

end