
module Ext
	class Field < Component

#	  attr_reader :name
#	  def init_component()
#  	  @name = @selenium.get_eval("window.Ext.getCmp('#{@id}').getName()");
#    end
    
    def value= (v)
      @selenium.type(@id, v)
      blur
    end
    
    def blur
      @selenium.fire_event(@id, "blur")
    end

    def is_disabled
      return @selenium.get_eval("window.Ext.getCmp('#{@id}').disabled") == "true"
    end

    # user valid?
    #def has_error?
    #  # using Ext.JS
    #  @selenium.get_eval("window.Ext.getCmp('#{@id}').isValid()") != "true"
    #end
    
    def value
      # xpath or Ext?
      # TODO: get more information from field (textarea or input[type=text])
      @selenium.get_value(@id) #{}"//div[@id='#{@id}']//input")
      # return @selenium.get_eval("window.Ext.getCmp('#{@id}').getValue()");
    end
  end
end
