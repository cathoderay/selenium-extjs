
require 'test/unit'
require 'selenium-extjs'
require 'setup'

class ListViewTest < Test::Unit::TestCase

  include Setup

  def test_list_view
    @s.open 'deploy/dev/examples/view/list-view.html'    
    listview = @s.find_ext(:xtype => "listview", :wait => true)
    fail if not listview.is_a? Ext::ListView
    listview.wait_for_row_visible('sara_pink.jpg')    
    p listview.has_row('sara_pink.jpg')
    listview.click_at_row('sara_pink.jpg')
  end
end
