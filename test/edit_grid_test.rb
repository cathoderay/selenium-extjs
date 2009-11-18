
require 'test/unit'
require 'selenium-extjs'
require 'setup'

class EditGridTest < Test::Unit::TestCase

  include Setup

  def test_edit_grid  
    # TODO: add aserts.

    @s.open '/deploy/dev/examples/grid/edit-grid.html'

    # wait for window.
    window = @s.find_ext(:xtype => 'window', :wait => true, :title => 'Store Load Callback')

    assert_equal window.class, Ext::Window
    
    # close the window
    window.close

    # search for editorgrid component.
    editorgrid = @s.find_ext(:xtype => "editorgrid", :autoExpandColumn => "common")

    assert editorgrid.is_a? Ext::EditorGrid

    # number of rows
    assert_equal editorgrid.num_rows(), 36

    # set row 1 with data
    # we can't work with check column
    editorgrid.edit_row(1, ["Jorge", "Sunny", "10.10", "24/03/06"]);

    # get row
    line_3 = editorgrid.get_row(3)

    assert_equal line_3[:price], "$4.59"

#"price"=>"$4.59", "common"=>"Bee Balm", "light"=>"Shade", "availDate"=>"May 03, 2006", "indoor"=>""}


    # clica at cell x,y
    #editorgrid.click_at_cell(2, 5)
  end
  
  def off_test_add_plant
  end
  
end
