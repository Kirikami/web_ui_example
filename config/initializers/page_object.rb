module PageObject
  def page_fully_loaded?
    @browser.execute_script("/loaded|complete/.test(document.readyState)")
  end

  def wait_for_page_fully_loaded(window = 1, global_timeout = 120)
    if global_timeout == 0
      raise "Timed out waiting for ajax requests to complete"
      return false
    end
    sleep window

    if not page_fully_loaded?
      wait_for_page_fully_loaded window, global_timeout-= 1

    else
      return true
    end
  end
end
