
require 'test/unit'
require 'selenium-extjs'
require 'setup'

class EditGridTest < Test::Unit::TestCase

  include Setup

  def test_grid  
    # TODO: add aserts.
    @s.open 'deploy/dev/examples/grid/edit-grid.html'

    # wait for window.
    window = @s.find_ext(:xtype => 'window', :wait => true, :title => 'Store Load Callback')
    
    assert_equal window.class, Ext::Window
    
    # close the window
    window.close

    # search for editorgrid component.
    editorgrid = @s.find_ext(:xtype => "editorgrid")

    # number of lines (on store?) 
    print editorgrid.num_rows()

    # set row 1 with data
    editorgrid.edit_row(1, ["Jorge", "Shade", "10.10", "24/03/06", true]);

    # get row
    print editorgrid.get_row(3)

    # clica at cell x,y
    editorgrid.click_at_cell(2, 5)
    sleep 10
  end
  
  def test_add_plant
  end
  
end