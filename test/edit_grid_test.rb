
require 'test/unit'
require 'selenium-extjs'
require 'setup'

class EditGridTest < Test::Unit::TestCase

  include Setup

  def test_edit_grid

    @s.open '/deploy/dev/examples/grid/edit-grid.html'

    # get editorgrid'
    editorgrid = @s.find_ext(:xtype => "editorgrid", :autoExpandColumn => "common")
#    editorgrid.wait_for_store_load

    # wait for window.
    window = @s.find_ext(:xtype => 'window', :wait => true, :title => 'Store Load Callback')
    assert_equal window.class, Ext::Window
    # close the window
    window.close

    # number of rows
    assert_equal editorgrid.num_rows(), 36

    # set row 1 with data
    # we can't work with check column
    editorgrid.edit_row(1, ["Jorge", "Sunny", "10.10", "24/03/06"]);

    # get row
    line_3 = editorgrid.get_row(3)

    assert_equal line_3[:price], "$4.59"
    assert_equal line_3[:common], "Bee Balm"
    assert_equal line_3[:light], "Shade"
    assert_equal line_3[:availDate], "May 03, 2006"
    assert_equal line_3[:indoor], ""

#    # click at cell x,y
    editorgrid.click_at_cell(2, 5)
    sleep 2

#    #click at row with label
    editorgrid.click_at_row("Anemone")
    sleep 2
  end
  
  def off_test_add_plant
  end
  
end
