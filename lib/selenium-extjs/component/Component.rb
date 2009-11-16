
module Ext
	class Component
	  def initialize(id, parent = nil)
	    @id = id
	    @parent = parent
	    @selenium = Ext::Driver::instance()
	  end
	  
	  def before
	    @selenium.wait_for_condition("window.Ext.Ajax.isLoading() == false")
      # click
    end
	  
	  # common tag element for this element
	  def node
	    return "//div[@id='#{@id}']"
    end
	  
	  # xpath for this element.
	  def selector
	    p @parent
	    sel = ""
	    if @parent && @parent.getId()
  	    sel += @parent.selector()
	    end
	    sel += node()
	    return sel
    end
	  
	  def getId()
	    return @id
	  end
	  
	  def highlight
	    s = Ext::Driver::instance()
	    p selector()
	    s.highlight(selector())
    end	  
	end
end
