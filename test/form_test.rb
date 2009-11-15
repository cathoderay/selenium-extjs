
require "rubygems"
require "selenium/client"

$LOAD_PATH.unshift("../lib")
require 'selenium-extjs'

begin
  Ext::Driver.new() 

  s = Ext::Driver::instance()
  s.open 'deploy/dev/examples/form/dynamic.html'

  # search for editorgrid component.
  form = Ext::find(:xtype => "form", :title_has => 'Simple')
  
  form.fields.each do |name, field|
    p name
    p field.value
    p field.value = "Loren Ipsun"
  end
  
  p form.fields[:email].has_error?
  
  form.fields[:email].value = 'myemail@domain.br'
  p form.fields[:email].has_error?
  
  
  # search for editorgrid component.
  form = Ext::find(:xtype => "form", :title_has => 'FieldSet')
  
  form.fields.each do |name, field|
    p name
    p field.value
  end
  
  sleep 10

ensure
  s.close_current_browser_session    
end





