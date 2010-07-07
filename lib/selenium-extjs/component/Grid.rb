
module Ext
	class Grid < Component
    def click_at_cell(x,y)
      @selenium.click_at(node() + "//div[contains(@class,'x-grid3-body')]//div[#{x}]//table//td[#{y}]", "0,0")
    end

    def click_at_row(label)
      @selenium.click_at(node() + "//div[contains(@class,'x-grid3-body')]//div[contains(@class, 'x-grid3-cell-inner') and text() = '#{label}']", "0,0")
    end

    def has_row(label)
      @selenium.is_element_present(node() + "//div[contains(@class,'x-grid3-body')]//div[contains(@class, 'x-grid3-cell-inner') and text() = '#{label}']") 
    end

    #TODO: REFACTOR
    def wait_for_row_not_visible(label, timeout=10)
      exp = node() + "//div[contains(@class,'x-grid3-body')]//div[contains(@class, 'x-grid3-cell-inner') and text() = '#{label}']"
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
        exp = node() + "//div[contains(@class,'x-grid3-body')]//div[contains(@class, 'x-grid3-cell-inner') and text() = '#{label}']"
        t0 = Time.now
        while true
          begin
            return true if @selenium.is_visible(exp)
          rescue
          end
          return false if (Time.now - t0) > timeout
        end
    end

	def wait_for_row_present(index, timeout=10)	
        xpath = node() + "//div[contains(@class, 'x-grid3-row') and position() = #{index}]"	
        t0 = Time.now
        while true
          begin
            return true if @selenium.is_element_present(xpath)
          rescue
          end
          return false if (Time.now - t0) > timeout
        end
	end

	def row_lists_values(valueArray)
		row_index = 1
		row = node() + "//div[contains(@class, 'x-grid3-row') and position() = 1]"
		while (@selenium.is_element_present(row) == true)
			cell_content_index = 1
			for value in valueArray			
				cell_content = row + "//td[contains(@class,'x-grid3-cell') and position() = #{cell_content_index}]//div[contains(@class, 'x-grid3-cell-inner') and text() = '#{value}']"
				if @selenium.is_element_present(cell_content) == false and value != nil
					row_found = false
					break	
				else
					row_found = true								
				end

				cell_content_index+=1
			end		

			if row_found == true
				return row_index
			end

			row_index+=1
			row = node() + "//div[contains(@class, 'x-grid3-row') and position() = #{row_index}]"			
		end
		return false
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
    
        #check if the column is a combo
#          colHeader =  @selenium.get_eval("#{colModel}.getColumnHeader(#{col})")        

#          if /".*x-grid3-(hd)?-checker.*"/.match colHeader
#              #TODO set the checker with data[data_index]
#            data_index += 1
#            continue
#          end
#         "//div[contains(@class,'x-grid3-body')]//div[#{row}]//table//td[#{col}]//input[type]"

          edit_cell(row, col, data[data_index])
          data_index += 1
          sleep 1
        rescue RuntimeError => ex
          #IGNORE
        end
      end
    end

    def edit_cell(x, y, value)      
      columns = "(window.Ext.getCmp('#{@id}').colModel.columns || window.Ext.getCmp('#{@id}').colModel.config)"
#      if @selenium.get_eval("#{columns}[#{y}].hidden") == "true"                        
#        return false
#      end
   
      editor_id = @selenium.get_eval("#{columns}[#{y}].getCellEditor(#{x}).getId()");    
      click_at_cell(x, y + 1)

      #check if the cell is a combo
      editor_xtype = @selenium.get_eval("#{columns}[#{y}].getCellEditor(#{x}).field.getXType()");
      field_editor_id = @selenium.get_eval("#{columns}[#{y}].getCellEditor(#{x}).field.getId()");
      if  editor_xtype.downcase.include? "combobox" 
        combo = Ext::Combo.new(field_editor_id, self, @selenium)
        combo.value = value
     else
      @selenium.wait_for_component_visible(editor_id)
      @selenium.type(node() + "//*[@id='#{editor_id}']//input", value)
      @selenium.fire_event(node() + "//*[@id='#{editor_id}']", "blur")
     end
    end
  end
end
