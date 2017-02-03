class ForgotPasswordSuccess < BasePage
  include PageObject

  page_url "#{BASE_URL}/forgot-password-success"

  h3 :success_message, css: 'h3'

  def have_success_message?
    wait_until{ success_message_element.visible? && success_message_element.text != '' }
    success_message_text = 'An email regarding your password change has been sent to your email address.'
    p success_message_element.text
    success_message_element.text == success_message_text
  end
end