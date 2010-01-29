
require 'test/unit'
require 'selenium-extjs'
require 'setup'

class ComboBoxTest < Test::Unit::TestCase

  include Setup

  def test_combobox
    @s.open '/deploy/dev/examples/form/combos.html'
    combobox = @s.find_ext(:xtype => "combo", :wait => true)
    fail if not combobox.is_a? Ext::Combo
    
    #select value
    combobox.value  = "Massachusetts"

    #get value selected
    puts combobox.value
  end
  
  def off_test_add_plant
  end
  
end
