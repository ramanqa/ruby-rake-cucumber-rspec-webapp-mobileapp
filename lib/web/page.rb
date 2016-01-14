require 'yaml'
require 'selenium-webdriver'
require './lib/web/page/page_methods'

class Web::Page
  include Web::PageMethods

  attr_accessor :session, :ui_spec

  def initialize session, spec_file_path
    @session = session
    @ui_spec = YAML.load_file "#{@session.config['ui_spec_location']}/#{spec_file_path}" 
  end


  def element name
    @session.log.debug "Find Page Element: #{self.class}.#{name}"
    timeout = @ui_spec['timeout']
    p_locator = nil
    p_find_by = nil
    p_timeout = timeout
    c_locator = nil
    c_find_by = nil
    c_timeout = timeout
    @ui_spec['elements'].each do |key, value|
      if key == "container"
        p_locator = value['locator']
        p_find_by = value['findby']
        p_timeout = value['timeout']
        value['children'].each do |childname, childvalue|
          if name == childname
            c_locator = childvalue['locator']
            c_find_by = childvalue['findby']
            c_timeout = childvalue['timeout']
          end
        end
      elsif key == name
        c_locator = value['locator']
        c_find_by = value['findby']
        c_timeout = value['timeout']
      end        
    end
    find_linked_element(p_find_by, p_locator, p_timeout, c_find_by, c_locator, c_timeout)
  end

  def find_linked_element p_find_by, p_locator, p_timeout, c_find_by, c_locator, c_timeout
    if(p_find_by == nil)
      return find_element c_timeout, c_find_by, c_locator
    else
      return find_child_element(find_element(p_timeout, p_find_by, p_locator), c_timeout, c_find_by, c_locator)
    end
  end

  def find_element timeout, find_by, locator
    if timeout == nil
      return @session.driver.find_element(find_by.to_sym => locator)  
    else
      wait = Selenium::WebDriver::Wait.new(:timeout => timeout)
      wait.until { @session.driver.find_element(find_by.to_sym => locator) }
      return @session.driver.find_element(find_by.to_sym => locator)
    end    
  end

  def find_child_element parent, timeout, find_by, locator
    parent
    if timeout == nil
      return parent.find_element(find_by.to_sym => locator)  
    else
      wait = Selenium::WebDriver::Wait.new(:timeout => timeout)
      wait.until { parent.find_element(find_by.to_sym => locator) }
      return parent.find_element(find_by.to_sym => locator)
    end
  end

end # class Page