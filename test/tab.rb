
require "rubygems"
require "selenium/client"

$LOAD_PATH.unshift("../lib")
require 'selenium-extjs'

begin
  Ext::Driver.new() 

  s = Ext::Driver::instance()
  s.open 'deploy/dev/examples/tabs/tabs.html'

  tabpanel = Ext::find(:xtype => "tabpanel")

  p "active panel:" + tabpanel.active_tab.title

  # work with position
  p tabpanel.active_tab = 2
  
  sleep 10

ensure
  s.close_current_browser_session    
end





