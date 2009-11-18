

require 'test/unit'
require 'selenium-extjs'
require 'setup'

class EditGridTest < Test::Unit::TestCase

  include Setup

  def test_simple
    
    @s.open 'deploy/dev/examples/grid/property-grid.js'

    # wait for window.
    property_grid = @s.find_ext(:xtype => 'property_grid')
    
    # assert_equal property_grid.class, Ext::PropertyGrid
    # property_grid.set(:value, :value)
    
  end
  
  def test_update_source
    button = @s.find_ext(:xtype => 'button', :text => 'Update source')
    button.click
    
    # assert if changed.
    
  end
  
end