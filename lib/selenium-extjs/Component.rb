
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
	
	
	class Panel < Component
    attr_reader :items
    
	  def initialize(id, parent)
	    super(id, parent)
	    @items = []
	    // #find sub itens
	    total = @selenium.get_eval("(window.Ext.getCmp('#{@id}').items)?(window.Ext.getCmp('#{@id}').items.length):0").to_i
	    total.times().each do |n|
	      @items << Ext::build_cmp(@selenium.get_eval("window.Ext.getCmp('#{@id}').get(#{n}).getId()"), self)
      end
    end
    
    def title
      @selenium.get_eval("window.Ext.getCmp('#{@id}').title")
    end
  end

	class TabPanel < Panel

	  def active_tab
	    id = @selenium.get_eval("window.Ext.getCmp('#{@id}').getActiveTab().getId()")
	    p "--- active tab ---"
	    p id
      p "?"
      list = @items.select do |el|
        p el.getId() 
        el.getId() == id
      end
      p list
      return list.first()
    end
    
    def active_tab=(param)
      if param.is_a? String
        if param =~ /^ext-/
          # wait!
        else
         title = param 
        end
      elsif param.is_a? Integer
        @selenium.click_at( selector() + "//ul[contains(@class, 'x-tab-strip')]//li[#{param}]//span[contains(@class, 'x-tab-strip-text')]", "0,0")
      end
    end
    
    
  end
  
	class Grid < Component
  end

	class EditorGrid < Grid
	  
	  def initialize(id, parent)
	    super(id, parent)
    end
    
    def click_at_cell(x,y)
      @selenium.click_at(node() + "//div[contains(@class,'x-grid3-body')]//div[#{x}]//table//td[#{y}]", "0,0")
    end
    
    # number of lines of Grid (store!)
    def num_rows()
      @selenium.get_eval("window.Ext.getCmp('#{@id}').getStore().getCount()").to_i
    end
    
    def get_row(row)
      len = @selenium.get_eval("window.Ext.getCmp('#{@id}').colModel.columns.length").to_i
      ret = {}
      len.times().each do |idx|
        begin
          data_index = @selenium.get_eval("window.Ext.getCmp('#{@id}').colModel.columns[#{idx}].dataIndex");
          text = @selenium.get_text(node() + "//div[contains(@class,'x-grid3-body')]//div[#{row}]//table//td[#{idx+1}]")
          p data_index 
          p text
          ret[data_index] = text
          sleep 1
        rescue Selenium::CommandError => ex
          p ex
        end
      end
      p ret
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
          click_at_cell(row, idx + 1)
          @selenium.highlight(node() + "//div[contains(@class,'x-grid3-body')]//div[#{row}]//table//td[#{idx+1}]")
          @selenium.type(node() + "//*[@id='#{editable}']", data[idx])
          @selenium.fire_event(node() + "//*[@id='#{editable}']", "blur")
          sleep 1
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
  
  class Form < Component
    attr_reader :fields 
    
	  def initialize(id, parent)
	    super(id, parent)
	    
	    # load all fields.
	    fields = @selenium.get_eval("window.Ext.getCmp('#{id}').findBy(function(el) { return el.getXTypes().indexOf('/field/') != -1 }).map(function(el) { return el.getId() })");
      
      @fields = {}
      fields.split(",").each do |field_id|
        field = Ext::build_cmp(field_id, self);
        @fields[field.name.to_sym] = field
        p field_id
      end
      print @fields
      
    end

    # component/box/field/textfield
    # window.Ext.ComponentMgr.all.find(function(el){ return el.getXType() == 'form' }).findBy(function(el) { console.debug(el.getXType()); })
    
    
  end
  
	
end