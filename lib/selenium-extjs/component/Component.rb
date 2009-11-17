
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


    def method_missing(m, *args, &block)
      prefix = "window.Ext.getCmp('#{@id}')"
     
      # TODO: unit for validate this :p
      # registered?
      # is_registered
      # isRegistered()
      m = m.to_s

      if m.end_with? "?"
         m.chop!
         m = "is_" + m   
      end

      if m.end_with? "="
         m.chop!
         m = "get_" + m   
      end

      tokens = m.split("_")
      if ( tokens.length > 1 )
        new_name = tokens.shift()
        new_name += tokens.map{|c| c.capitalize() }.join("")
      else
        new_name = m
      end

      #TODO: tratar o erro e verificar se o method existe  
      cmd = "(function(_s) { if(typeof _s.#{new_name} == 'function') { return _s.#{new_name}("
      args.each do |p| 
        if p.is_a? String
          cmd += "'#{p}',"
        elsif p.is_a? Fixnum
          cmd += "#{p},"
        else
          cmd += "#{p},"
        end
      end
      cmd.chop! if cmd.end_with? ","
      cmd += "); } else { return _s.#{new_name}; }})(#{prefix})"

      new_cmd = "(function(_obj) { return (_obj.getId)?('\@ID:'+_obj.getId()):_obj; })(#{cmd});";

      ret = @selenium.get_eval(new_cmd);

      if ret.start_with? "@ID:"
        id = ret.split(":")[1]
        @selenium.get_cmp(id, nil)
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
