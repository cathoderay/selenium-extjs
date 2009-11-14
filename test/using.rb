
require "rubygems"
require "selenium/client"

$LOAD_PATH.unshift("../lib")
require 'selenium-extjs'

begin
  Ext::Driver.new() 

  s = Ext::Driver::instance()
  s.open 'deploy/dev/examples/feed-viewer/view.html'

  # search for appfeedgrid component.
  appfeedgrid = Ext::find(:xtype => "appfeedgrid")

  print " >>> "
  p appfeedgrid

  appfeedgrid.highlight

  # return button.
  button = Ext::find(:xtype => "button", :text => 'Open All', :xparent => appfeedgrid)
  button.click

  sleep 10

ensure
  s.close_current_browser_session    
end





