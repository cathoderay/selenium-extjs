
module Ext
	class Panel < Component
    attr_reader :items
    
    def init_component()
	    @items = []
	    total = @selenium.get_eval("(window.Ext.getCmp('#{@id}').items)?(window.Ext.getCmp('#{@id}').items.length):0").to_i
	    total.times().each do |n|
        cmp = get(n)
        cmp.parent = self
	      @items << cmp
        #Ext::build_cmp(@selenium.get_eval("window.Ext.getCmp('#{@id}').get(#{n}).getId()"), self)
      end
    end

    def title
      @selenium.get_eval("window.Ext.getCmp('#{@id}').title")
    end
  end

	class TabPanel < Panel

=begin
	  def active_tab
      tab = active_tab().getId()
#	    id = @selenium.get_eval("window.Ext.getCmp('#{@id}').getActiveTab().getId()")
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
=end
    
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
end
