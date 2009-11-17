
require "rubygems"
require "selenium/client"

$LOAD_PATH.unshift("../lib")
require 'selenium-extjs'

begin

  s = Ext::Selenium.new \
  :host              => "localhost",
  :port              => 4444,
  :browser           => "*firefox",
  :url               => "http://www.extjs.com/",
  :timeout_in_second => 60

  s.start_new_browser_session
  s.open 'deploy/dev/examples/tabs/tabs.html'

  tabpanel = s.find_ext(:xtype => "tabpanel")

  
  p "active panel:" + tabpanel.getActiveTab().title

  # work with position
  p tabpanel.active_tab = 2

  p tabpanel.getActiveTab().title
  p tabpanel.getActiveTab().title == "Long Text"
  
  sleep 10

ensure
  s.close_current_browser_session    
end





