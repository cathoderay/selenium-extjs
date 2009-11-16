
module Ext
	class Field < Component
	  attr_reader :name
	  
	  def initialize(id, parent)
	    super(id, parent)
  	  @name = @selenium.get_eval("window.Ext.getCmp('#{@id}').getName()");
    end
    
    def value= (v)
      @selenium.type(@id, v)
      @selenium.fire_event(@id, "blur")
    end
    
    def has_error?
      # using Ext.JS
      @selenium.get_eval("window.Ext.getCmp('#{@id}').isValid()") != "true"
    end
    
    def value
      # xpath or Ext?
      # TODO: get more information from field (textarea or input[type=text])
      @selenium.get_value(@id) #{}"//div[@id='#{@id}']//input")
      # return @selenium.get_eval("window.Ext.getCmp('#{@id}').getValue()");
    end
  end
end
