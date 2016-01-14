require './lib/web/page'
require './dsl/web/common/navigation_bar'

class Home < Web::Page
  
  attr_accessor :navigation_bar
  def initialize session
    super session, "home.yaml"
    @navigation_bar = NavigationBar.new session
  end

end