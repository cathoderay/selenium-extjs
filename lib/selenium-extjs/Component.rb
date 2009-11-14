
module Ext
	# component.
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
	
	class Window < Component
	  def close
	    @selenium.click_at( node() + "//div[contains(@class, 'x-tool-close')]", "0,0")
    end
  end
	
	
	class Grid < Component
  end

	class EditorGrid < Grid
	  
	  def initialize(id, parent)
	    super(id, parent)
    end
    
    def edit_row(row, data)
      len = @selenium.get_eval("window.Ext.getCmp('#{@id}').colModel.columns.length").to_i
      p "> len"
      p len
      
      p "editores"
      
    
      len.times().each do |idx|
        print "window.Ext.getCmp('#{@id}').colModel.columns[#{idx}].getEditor().getId()"
        begin
          editable = @selenium.get_eval("window.Ext.getCmp('#{@id}').colModel.columns[#{idx}].getEditor().getId()");
          @selenium.click_at(node() + "//div[contains(@class,'x-grid3-body')]//div[#{row}]//table//td[#{idx+1}]", "0,0")
          @selenium.highlight(node() + "//div[contains(@class,'x-grid3-body')]//div[#{row}]//table//td[#{idx+1}]")
          @selenium.type(node() + "//*[@id='#{editable}']", data[idx])
          sleep 5
        rescue Selenium::CommandError => ex
          p ex
        end
        # print editable
        # p editor_id
        
      end
      
      # t = 1
      # data.each do |data|
      #   @selenium.get_eval("window.Ext.getCmp")
      #   
      # end
    end


    # //div[contains(@class,"x-grid3-body")]//div[2]//table//td[3]
	  # // x-grid3-viewport
	  ## x-grid3-body
	  ## x-grid3-row x-grid3-row-first
	  ## //div[contains(@class,"x-grid3-body")]//div[2]
	  ## //div[contains(@class,"x-grid3-body")]//div[2]//table//td[2]
	  
    # Ext.getCmp("ext-comp-1005").store.getAt(2).data
    # Ext.getCmp("ext-comp-1005").colModel.columns
    # Ext.getCmp("ext-comp-1005").colModel.columns[0].getEditor().getXType()
    # x-grid3-col
  end
	
end