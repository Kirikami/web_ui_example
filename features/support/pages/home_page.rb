class HomePage < BasePage
  include PageObject

  page_url Fixtures.instance[:marketing_url]

  image :logo, class: 'logo-img'
  li :sign_up, id: 'menu-item-642'
  li :sign_in, id: 'menu-item-640'

  def have_logo?
    logo_element.visible?
  end

  def go_to_sign_in
    wait_until { sign_in_element.visible? }
    sign_in_element.click
  end

  def go_to_sign_up
    wait_until { logo_element.visible? }
    sign_up_element.click
  end

end