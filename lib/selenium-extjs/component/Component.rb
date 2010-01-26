
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

    def add_event(evt)
      cmd =  "(function(_) {   _.on('#{evt}', function(e, t){  this.#{evt}_#{self.object_id} = true;}, window, {single: true} );    })(window.Ext.getCmp('#{@id}'));"
      @selenium.get_eval(cmd);
    end

    def wait_for_event(evt)
       #@selenium.get_eval("alert(window.#{evt}_#{self.object_id})");
       @selenium.wait_for_condition("(typeof window.#{evt}_#{self.object_id} != 'undefined')")
    end

    def wait_for_store_load
        cmd =  "(function(_) {  return (typeof selenium.last_events[_.getStore()] != 'undefined'); })(window.Ext.getCmp('#{@id}'));"
        @selenium.wait_for_condition(cmd)
    end

    def method_missing(method_name, *args, &block)
      cmp = "window.Ext.getCmp('#{@id}')"

      # TODO: unit for validate this :p
      # registered?
      # is_registered
      # isRegistered()

      if method_name.to_s.end_with? "="
        return nil
      end
      
      # convert method name to ext model.
      method_name = Ext::extfy(method_name.to_s)

      # build js arguments list
      arguments = Ext::arguments(args)

      # move to selenium.
      cmd = Ext::build_remote_call(@id, method_name, arguments)
      ret = @selenium.get_eval(cmd)
        ret = JSON ret.split(":", 2)[1]
      if ret.start_with? "JSON:"
      end

      if ret == "true" || ret == "false"
        ret = (ret =="true")
      end

      if ret.is_a? Hash
        if ret.has_key? "cmpid"
          p "---->"
          p ret
          return @selenium.get_cmp(ret["cmpid"], nil)
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

    def is_visible
      return @selenium.is_visible(node())  
    end

    def wait_for_visible(timeout=10)
      t0 = Time.now
      while true
        return true if is_visible
        return false if (Time.now - t0) > timeout
      end
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
