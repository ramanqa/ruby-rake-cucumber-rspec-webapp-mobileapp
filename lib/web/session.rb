require 'yaml'
require 'selenium-webdriver'
require 'logger'

class Web::Session

  attr_accessor :config, :driver, :log

  def initialize config=YAML.load_file("./config.yaml")
    @config = config    
    @log = Logger.new(@config['log_file'])
    launch
  end

  def launch
    @log.info "Launching Browser..."
    @log.info "Test Configuration: #{@config['test_configuration']['web']}"
    if(@config['test_configuration']['web']['mode']=='remote')      
    else
      @driver = Selenium::WebDriver.for @config['test_configuration']['web']['browser'].to_sym
      @driver.manage.window.maximize
    end
    @log.info "."
  end

  def quit
    @log.info "Closing session."
    @driver.quit
  end
end