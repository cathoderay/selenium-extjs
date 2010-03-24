
require 'test/unit'
require 'selenium-extjs'
require 'setup'

class ComboBoxTest < Test::Unit::TestCase

  include Setup

  def test_list_view
    @s.open 'deploy/dev/examples/view/list-view.html'
    sleep 3
    listview = @s.find_ext(:xtype => "listview", :wait => true)
    fail if not listview.is_a? Ext::ListView
    
    listview.click_at_row('sara_pink.jpg')
  end
end
