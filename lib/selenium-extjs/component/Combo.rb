
module Ext
	class Combo < Field

    def value= (v)
      container_id = @selenium.get_eval("window.Ext.getCmp('#{@id}').container.id")
      @selenium.click_at "//div[@id='#{container_id}']//img[contains(@class, 'x-form-arrow-trigger')]", "0,0"
      if wait_for_list_load
        innerList_id = @selenium.get_eval("window.Ext.getCmp('#{@id}').innerList.id")
        @selenium.click_at "//div[@id='#{innerList_id}']//div[contains(text(), '#{v}')]", "0,0"
      end
      return false
    end

    def wait_for_list_load(timeout=10)
        t0 = Time.now
        while true
          begin
            return true if @selenium.get_eval("typeof window.Ext.getCmp('#{@id}').innerList == 'object'") == "true"
          rescue
          end
          return false if (Time.now - t0) > timeout
        end
    end

    def is_editable?
      return @selenium.get_eval("window.Ext.getCmp('#{@id}').editable") == "true"
    end

    def focus
      @selenium.fire_event(@id, "focus")
   end

    def blur
      @selenium.fire_event(@id, "blur")
    end

    def value
      return @selenium.get_eval("window.Ext.getCmp('#{@id}').getValue()")
    end
  end
end
