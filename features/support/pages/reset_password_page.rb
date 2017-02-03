class ResetPasswordPage < BasePage
  include PageObject

  page_url "#{BASE_URL}/forgot-password"

  text_field :email, class: 'form-control'
  button :submit, class: 'btn-primary'

  def send_reset_email
    self.email = CREDENTIALS[:reset_password_email]
    submit
  end

  def have_forgot_password_form?
    email_element.visible?
  end

end