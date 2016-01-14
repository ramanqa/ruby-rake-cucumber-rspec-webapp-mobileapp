require './dsl/web/home'
require './lib/web/session'

describe "first_spec" do

  before(:all) do
    @session = Web::Session.new
  end

  after(:all) do
    @session.quit
  end

  context "firstly" do
    it "should run" do
      home = Home.new @session
      home.visit
      home.navigation_bar.search_for "Inception"
    end
  end
end