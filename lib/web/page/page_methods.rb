module Web
module PageMethods

  def visit
    @session.driver.get "#{@session.config['environment']['url']}#{@ui_spec['url']}"
  end

end
end