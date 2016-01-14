require 'yaml'

module Web
module Page
class Element

  attr_accessor :name, :timeout, :locator, :findby, :container

  def initialize name
    @page_spec = YAML.load_file spec_file

    p @driver
  end

end
end
end