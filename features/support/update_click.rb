require_relative 'check_ajax'

module Watir

  #
  # Base class for HTML elements.
  # Updated method with monkey patching
  # Wait for ajax after each click
  #

  class Element
    include CheckAjax

    def click(*modifiers)
      assert_exists
      assert_enabled

      element_call do
        if modifiers.any?
          assert_has_input_devices_for "click(#{modifiers.join ', '})"

          action = driver.action
          modifiers.each { |mod| action.key_down mod }
          action.click @element
          modifiers.each { |mod| action.key_up mod }

          action.perform
        else
          @element.click
        end
      end

      check_for_ajax
      if browser.element.div(id: 'error').exists?
        error = browser.element.div(id: 'error').text
        $LOG.error error
        raise "An error has occured: #{error}"
      end
    end

  end
end

