class DashboardPage < BasePage
  include PageObject

  page_url "#{BASE_URL}/dashboard/home"

  a :logo, class: 'kountable-logo'
  span :username_text, xpath: ".//*[@id='profileEditorForm']/ul/li[1]/div/div[1]/span[2]"
  span :address_text, css: ".k-editor-label div"
  span :edit_username, xpath: '//ul/li[1]/div/div[1]/span[1]'
  span :edit_address, xpath: '//ul/li[1]/div/div[1]/span[1]'
  span :done_with_name, xpath: ".//*[@id='k-profile-edit-name']/span"
  text_field :first_name, xpath: ".//*[@id='k-profile-edit-name']/div[1]/input"
  text_field :last_name, xpath: ".//*[@id='k-profile-edit-name']/div[2]/input"
  text_field :address, xpath: ".//*[@id='k-profile-edit-address']/div[1]/input"
  text_field :country, xpath: ".//*[@id='k-profile-edit-address']/div[2]/div/select"
  text_field :state, xpath: ".//*[@id='k-profile-edit-address']/div[3]/input"
  text_field :city, xpath: ".//*[@id='k-profile-edit-address']/div[4]/input"
  text_field :district, xpath: ".//*[@id='k-profile-edit-address']/div[5]/input"
  text_field :sector, xpath: ".//*[@id='k-profile-edit-address']/div[6]/input"
  text_field :postal_code, xpath: ".//*[@id='k-profile-edit-address']/div[7]/input"
  span :done_with_address, xpath: ".//*[@id='k-profile-edit-address']/span"
  button :sign_out, class: 'btn'


  INFORMATION_TO_UPDATE ||= Fixtures.instance[:info_to_change]
  DEFAULT_INFORMATION ||= Fixtures.instance[:default_info]

  def have_logo?
    sleep 1
    logo_element.exists? && logo_element.visible?
  end

  def edit button
    send("edit_#{button}_element").click
  end

  def update info, data
    info_to_update = DEFAULT_INFORMATION
    if data == 'new'
      info_to_update = INFORMATION_TO_UPDATE
    end

    if info == 'name'
      self.first_name = info_to_update[:first_name]
      self.last_name = info_to_update[:last_name]

    elsif info == 'address'
      self.address = info_to_update[:address]
      country.select(4)
      self.state = info_to_update[:state]
      self.city = info_to_update[:city]
      self.district = info_to_update[:district]
      self.sector = info_to_update[:sector]
      self.postal_code = info_to_update[:postal_code]
      done_with_address
    else
      $LOG.error("There is no #{info} to edit")
    end

  end

  def has_changed_information? info
    data = INFORMATION_TO_UPDATE
    compare = "#{data[:first_name]} #{data[:last_name]}"
    if info == 'address'
      compare = "#{data[:address]}, #{data[:postal_code]} Algeria #{data[:city]} #{data[:state]} #{data[:district]},#{data[:sector]}"
    end
    result = send("#{info}_text_element").value == compare
    $LOG.info(result)
    result
  end

  def log_out
    sign_out
  end

end
