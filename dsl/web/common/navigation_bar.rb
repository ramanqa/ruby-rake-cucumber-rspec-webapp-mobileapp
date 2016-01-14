require './lib/web/page'

class NavigationBar < Web::Page
  
  def initialize session
    super session, "common/navigation_bar.yaml"
  end

  def search_for term
    element("search_entry").send_keys term
    element("search_button").click
  end

end