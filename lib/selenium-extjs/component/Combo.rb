
module Ext
	class Combo < Field

    def value= (v)
      @selenium.type(@id, v)
      blur
    end

    def focus
      @selenium.fire_event(@id, "focus")
    end

    def blur
      @selenium.fire_event(@id, "blur")
    end

    def value
      # xpath or Ext?
      # TODO: get more information from field (textarea or input[type=text])
      @selenium.get_value(@id) #{}"//div[@id='#{@id}']//input")
      # return @selenium.get_eval("window.Ext.getCmp('#{@id}').getValue()");
    end
  end
end
