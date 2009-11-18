
require 'test/unit'
require 'selenium-extjs'
require 'setup'

class SimpleTest < Test::Unit::TestCase  
  
  include Setup
  
  def test_simple
    
    @s.open 'deploy/dev/examples/feed-viewer/view.html'
    appfeedgrid = @s.find_ext(:xtype => "appfeedgrid")

    appfeedgrid.highlight
    sleep 5

    button = @s.find_ext(:xtype => "button", :text => 'Open All', :xparent => appfeedgrid)
    button.click  
  end
end




