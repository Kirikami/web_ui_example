require 'page_navigation'

module PageObject

  module PageFactory
    include PageNavigation


    def visit_page(page_class, params={:using_params => {}}, &block)
      on_page page_class, params, true, &block
    end

    alias_method :visit, :visit_page

    def on_page(page_class, params={:using_params => {}}, visit=false, &block)
      page_class = Object.const_get(page_class) if page_class.is_a? String
      return super(page_class, params, visit, &block) unless page_class.ancestors.include? PageObject
      merged = page_class.params.merge(params[:using_params])
      page_class.instance_variable_set("@merged_params", merged) unless merged.empty?
      @current_page = page_class.new(@browser, visit)
      block.call @current_page if block
      # wait = ::Selenium::WebDriver::Wait.new({:timeout => 60, :message => nil})
      # wait.until {@current_page.loaded?}
      @current_page
    end

    alias_method :on, :on_page

  end
end