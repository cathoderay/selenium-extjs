
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
  window.close
  
  sleep 2

  # search for appfeedgrid component.
  editorgrid = Ext::find(:xtype => "editorgrid")

  
  # window.Ext.ComponentMgr.all.find(function(el){ return el.getXType() == 'window' })

  print " >>> "
  p editorgrid
  editorgrid.highlight

  editorgrid.edit_row(1, ["Jorge", "Shade", "10.10", "24/03/06", true]);

  sleep 10
# Ext.getCmp("ext-comp-1005").store.reload()

  # return button.
  # button = Ext::find(:xtype => "button", :text => 'Open All', :xparent => appfeedgrid)
  # button.click
  # 
  # sleep 10

ensure
  s.close_current_browser_session    
end





