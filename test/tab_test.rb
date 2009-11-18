
require 'test/unit'
require 'selenium-extjs'
require 'setup'


class TabTest < Test::Unit::TestCase  

  include Setup

  def test_active_panel

    s.open 'deploy/dev/examples/tabs/tabs.html'

    tabpanel = s.find_ext(:xtype => "tabpanel")

    assert_equal tabpanel.class, TabPanel

    assert_equal tabpanel.getActiveTab().title, "Short Text"

    tabpanel.active_tab = 2

    assert_equal tabpanel.getActiveTab().title, "Long Text"
  end
end




