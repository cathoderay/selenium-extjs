

require 'test/unit'
require 'selenium-extjs'
require 'setup'

class EditGridTest < Test::Unit::TestCase

  include Setup

  def test_simple
    
    @s.open 'deploy/dev/examples/grid/property-grid.html'

    # wait for window.
    property_grid = @s.find_ext(:xtype => 'propertygrid')
    
    assert property_grid.is_a? Ext::EditorGrid

    # assert_equal property_grid.class, Ext::PropertyGrid
    # property_grid.set(:value, :value)
    
  end
  
  def off_test_update_source

    button = @s.find_ext(:xtype => 'button', :text => 'Update source')
    
    assert button.is_a? Ext::Button

    button.click
    
    # assert if changed.
      
  end
  
end
