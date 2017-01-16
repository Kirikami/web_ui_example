class ResetPasswordPage < BasePage
  include PageObject

  page_url "#{BASE_URL}/forgot-password"

  text_field :email, class: 'form-control'
  button :submit, class: 'btn-primary'
  h3 :success_message, css: 'h3'

  def send_reset_email
    self.email = CREDENTIALS[:reset_password_email]
    submit
  end

  def have_forgot_password_form?
    email_element.visible?
  end

  def have_success_message?
    success_message_text = 'An email regarding your password change has been sent to your email address.'
    success_message_element.value == success_message_text
  end

end