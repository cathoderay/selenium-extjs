
module Ext
	class Button < Component
	  def click
	    before()
      s = Ext::Driver::instance()
      s.click_at(selector(), "0,0")
    end
    def node
      
      # node?
       # + "[@id='#{getId()}']"
      return "//table[@id='#{@id}']//button"
      # return @selenium.get_eval("window.Ext.getCmp('#{@id}').btnEl.dom.tagName").downcase
    end
  end
end
