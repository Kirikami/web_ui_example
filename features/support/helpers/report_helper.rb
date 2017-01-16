require 'net/http'

module ReportHelper
  def generate_file_path_and_name(scenario)
    project_dir = File.expand_path(File.dirname(__FILE__) + '/../../..')
    time_fixed ||= Time.now.strftime('%Y-%m-%d_%H-%M-%S')
    time = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
    feature_name = scenario.name.underscore_all
    scenario_title = scenario.name.underscore_all
    report_folder = File.join("#{project_dir}/build", time_fixed, feature_name, scenario_title)
    report_file_name = "#{scenario_title.underscore_all}_#{time}"
    FileUtils.mkdir_p(report_folder)
    "#{report_folder}/#{report_file_name}"
  end

  def write_html_file(html_file_path)
    File.write("#{html_file_path}.html", @browser.html)
  end


  def write_log(file_path)
    work_log = @browser.driver.manage.logs.get(:browser)
    messages = ""
    work_log.each { | item | messages += item.message + "\n"}
    File.write( "#{file_path}.log", messages ) unless messages == ""
  end

  def get_current_cookies
    @browser.driver.manage.all_cookies
  end

  def write_current_cookies(file_path, condition)
    File.write( "#{file_path}_before.cookies", get_current_cookies ) if condition == 'before'
    File.write( "#{file_path}_after.cookies", get_current_cookies ) if condition == 'after'
  end

  def take_step_screenshot(screenshot_file_path)
    screenshot_file_path = "#{screenshot_file_path}.png"
    @browser.screenshot.save(screenshot_file_path)
    screenshot_file_path
  end
end