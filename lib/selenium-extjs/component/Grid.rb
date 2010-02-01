
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

    #TODO: REFACTOR
    def wait_for_row_not_visible(label, timeout=10)
      exp = node() + "//div[contains(@class,'x-grid3-body')]//div[contains(@class, 'x-grid3-cell-inner') and contains(text(), '#{label}')]"
      t0 = Time.now
      while true
        begin
          return true if not @selenium.is_visible(exp)
        rescue
          return true
        end
        return false if (Time.now - t0) > timeout
      end
    end

    #TODO: REFACTOR
    def wait_for_row_visible(label, timeout=10)
        exp = node() + "//div[contains(@class,'x-grid3-body')]//div[contains(@class, 'x-grid3-cell-inner') and contains(text(), '#{label}')]"
        t0 = Time.now
        while true
          begin
            return true if @selenium.is_visible(exp)
          rescue
          end
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


#    def edit_row(row, data)
#      colModel = "window.Ext.getCmp('#{@id}').colModel"
#      columns = "(window.Ext.getCmp('#{@id}').colModel.columns || window.Ext.getCmp('#{@id}').colModel.config)"
#      
#      len = @selenium.get_eval("#{columns}.length").to_i
#      data_index = 0
#      len.times().each do |idx|
#        begin
#          #if it's a hidden field pass to next
#          if @selenium.get_eval("#{columns}[#{idx}].hidden") == "true"                        
#            continue
#          end

#          #check if the column is a checkbox
#          colHeader =  @selenium.get_eval("#{colModel}.getColumnHeader(#{idx})")        
#          if /".*x-grid3-(hd)?-checker.*"/.match colHeader
#              #TODO set the checker with data[data_index]
#            data_index += 1
#            continue
#          end              

#          editable = @selenium.get_eval("#{columns}[#{idx}].getEditor().getId()");
#          click_at_cell(row, idx + 1)
#          @selenium.wait_for_component_visible(editable)
#          @selenium.type(node() + "//*[@id='#{editable}']", data[data_index])
#          @selenium.fire_event(node() + "//*[@id='#{editable}']", "blur")
#          data_index += 1
#          sleep 1
#        rescue RuntimeError => ex
#          p ex
#        end
#      end
#    end

    
    def edit_row(row, data)
      colModel = "window.Ext.getCmp('#{@id}').colModel"
      columns = "(window.Ext.getCmp('#{@id}').colModel.columns || window.Ext.getCmp('#{@id}').colModel.config)"
      
      len = @selenium.get_eval("#{columns}.length").to_i
      data_index = 0
      len.times().each do |col|
        begin

          #if it's a hidden field pass to next
          if @selenium.get_eval("#{columns}[#{col}].hidden") == "true"                        
            continue
          end

          #check if the column is a checkbox
          colHeader =  @selenium.get_eval("#{colModel}.getColumnHeader(#{col})")        
          if /".*x-grid3-(hd)?-checker.*"/.match colHeader
              #TODO set the checker with data[data_index]
            data_index += 1
            continue
          end

          edit_cell(row, col, data[data_index])
          data_index += 1
          sleep 1
        rescue RuntimeError => ex
          p ex
        end
      end
    end

    def edit_cell(x, y, value)
      columns = "(window.Ext.getCmp('#{@id}').colModel.columns || window.Ext.getCmp('#{@id}').colModel.config)"
      if @selenium.get_eval("#{columns}[#{y}].hidden") == "true"                        
        return false
      end

      editable = @selenium.get_eval("#{columns}[#{y}].getEditor().getId()");

      click_at_cell(x, y + 1)
      @selenium.wait_for_component_visible(editable)
      @selenium.type(node() + "//*[@id='#{editable}']", value)
      @selenium.fire_event(node() + "//*[@id='#{editable}']", "blur")
    end
  end
end
