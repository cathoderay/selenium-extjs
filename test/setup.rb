
require "rubygems"
require "selenium/client"
require 'selenium-extjs'

module Setup
  def setup()
    @s = Ext::Selenium.new \
    :host              => "localhost",
    :port              => 4444,
    :browser           => "*firefox",
    :url               => "http://www.extjs.com/",
    :timeout_in_second => 60
    @s.start_new_browser_session
  end

  def teardown()
    sleep 5
    @s.close_current_browser_session 
  end
end




