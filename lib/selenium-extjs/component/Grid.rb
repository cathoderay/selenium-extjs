
module Ext
	class Grid < Component
    def click_at_cell(x,y)
      @selenium.click_at(node() + "//div[contains(@class,'x-grid3-body')]//div[#{x}]//table//td[#{y}]", "0,0")
    end

    def click_at_row(label)
      @selenium.click_at(node() + "//div[contains(@class,'x-grid3-body')]//div[contains(@class, 'x-grid3-cell-inner') and contains(text(), '#{label}')]", "0,0")
    end

    def has_row(label)
      @selenium.is_element_present(node() + "//div[contains(@class,'x-grid3-body')]//div[contains(@class, 'x-grid3-cell-inner') and contains(text(), '#{label}')]") 
    end

    def wait_for_row(label, timeout=30)
        exp = node() + "//div[contains(@class,'x-grid3-body')]//div[contains(@class, 'x-grid3-cell-inner') and contains(text(), '#{label}')]"
        t0 = Time.now
        while true
            return true if @selenium.is_element_present(exp)
            return false if (Time.now - t0) > timeout
        end
    end
  end

	class EditorGrid < Grid
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
          ret[data_index.to_sym] = text
        rescue Selenium::CommandError => ex
          p ex
        end
      end
      ret
    end
    
    def edit_row(row, data)
      columns = "(window.Ext.getCmp('#{@id}').colModel.columns || window.Ext.getCmp('#{@id}').colModel.config)"
      p columns
      len = @selenium.get_eval("#{columns}.length").to_i
      len.times().each do |idx|
        begin
          editable = @selenium.get_eval("#{columns}[#{idx}].getEditor().getId()");
          click_at_cell(row, idx + 1)
          @selenium.wait_for_component_visible(editable)
          @selenium.type(node() + "//*[@id='#{editable}']", data[idx])
          @selenium.fire_event(node() + "//*[@id='#{editable}']", "blur")
          sleep 1
        rescue RuntimeError => ex
          p ex
        end
      end
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
