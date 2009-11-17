
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
  s.open 'deploy/dev/examples/feed-viewer/view.html'
  appfeedgrid = s.find_ext(:xtype => "appfeedgrid")

  appfeedgrid.highlight
  sleep 5
 
  button = s.find_ext(:xtype => "button", :text => 'Open All', :xparent => appfeedgrid)
  button.click  
end




