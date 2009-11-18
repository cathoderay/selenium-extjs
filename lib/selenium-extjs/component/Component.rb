
require 'json'

module Ext
	class Component
    attr_accessor :parent


	  def initialize(id, parent = nil, selenium = nil)
	    @id = id
	    @parent = parent
	    @selenium = selenium
      init_component()
	  end
	  
    def init_component()
    end

    # algumas ideias...
    # obj.items_component_array -> serializar o retorno em uma lista
    # tratar obj.store

    def method_missing(method_name, *args, &block)

      #
      cmp = "window.Ext.getCmp('#{@id}')"
     
      # TODO: unit for validate this :p
      # registered?
      # is_registered
      # isRegistered()

      if m.end_with? "="
        # set value?
      end
      
      # convert method name to ext model.
      method_name = Ext::extfy(method_name.to_s)

      # build js arguments list
      arguments = Ext::arguments(args)

      # move to selenium.
      cmd = Ext::build_remote_call(@id, method_name, arguments)
      ret = @selenium.get_eval(cmd)

      if ret.is_a? Hash
        if ret.has_key? 'id'
          return @selenium.get_cmp(id, nil)
        else
          return ret
        end
      else
        return ret
      end
    end  

	  def wait_for_ajax
	    @selenium.wait_for_condition("window.Ext.Ajax.isLoading() == false")
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
	    @selenium.highlight(selector())
    end	  
	end
end
