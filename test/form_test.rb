
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
  s.open 'deploy/dev/examples/form/dynamic.html'

  # search for editorgrid component.
  form = s.find_ext(:xtype => "form", :title_has => 'Simple')
  
  form.fields.each do |name, field|
    p name
    p field.value
    p field.value = "Loren Ipsun"
  end
  
  p form.fields[:email].valid?
  
  form.fields[:email].value = 'myemail@domain.br'
  p form.fields[:email].valid?
  
  
  # search for editorgrid component.
  form = s.find_ext(:xtype => "form", :title_has => 'FieldSet')
  
  form.fields.each do |name, field|
    p name
    p field.value
  end
  
  sleep 10

ensure
  s.close_current_browser_session    
end





