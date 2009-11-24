
require 'test/unit'
require 'selenium-extjs'
require 'setup'


class Writer < Test::Unit::TestCase  

  include Setup

  def test_add_button

    @s.open 'deploy/dev/examples/writer/writer.html'

    panel = @s.find_ext(:title => "Users")

    p panel
    
    #pabel.tbar.click_at(:text => 'Add')
    #pabel.tbar.click_at(:class_has => 'add')
    #pabel.tbar.find_cmp(:text => 'add')
    

    # assert tabpanel.is_a? Ext::TabPanel
    # 
    # assert_equal tabpanel.getActiveTab().title, "Short Text"
    # 
    # tabpanel.active_tab = 2
    # 
    # assert_equal tabpanel.getActiveTab().title, "Long Text"
  end
end
