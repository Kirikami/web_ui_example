module CheckAjax

  def ajax_active?
    if browser.execute_script("return typeof jQuery != 'undefined'")
      browser.execute_script("return $.active != 0")
    end
  end

  def check_for_ajax(window = 1, global_timeout = 45)
    console_log = browser.driver.manage.logs.get(:browser)
    if console_log != nil
      if /\sstatus of (4|5)\d*/.match (console_log.to_s)
        error_value = /\sstatus of (4|5)\d*/.match (console_log.to_s)
        $LOG.warn ("The server responded with a#{error_value}")
        p ("The server responded with a#{error_value}")
      end
    end

    if global_timeout == 0
      raise "Timed out waiting for ajax requests to complete"
    end
    sleep window

    if ajax_active?
      check_for_ajax window, global_timeout-= 1
    else
      true
    end

  end
end
