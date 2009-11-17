
module Ext
	class Grid < Component
  end

	class EditorGrid < Grid	  

    
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
        rescue RuntimeError => ex
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
