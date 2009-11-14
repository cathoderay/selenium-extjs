
require "rubygems"
require "selenium/client"

$LOAD_PATH.unshift("../lib")
require 'selenium-extjs'

begin
  Ext::Driver.new() 

  s = Ext::Driver::instance()
  s.open 'deploy/dev/examples/grid/edit-grid.html'

  # wait for window.
  window = Ext::find(:xtype => 'window', :wait => true)
  # close the window
  window.close

  # search for editorgrid component.
  editorgrid = Ext::find(:xtype => "editorgrid")

  # set row 1 with data
  editorgrid.edit_row(1, ["Jorge", "Shade", "10.10", "24/03/06", true]);

  sleep 10

ensure
  s.close_current_browser_session    
end





