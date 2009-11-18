
module Ext
  class FieldSet < Panel
    def init_component()
      super()
    end
    
    def collapsed=(flag)
      if collapsed != flag
        @selenium.click_at("//fieldset[@id='#{@id}']//*[contains(@class, 'x-tool-toggle') or @type='checkbox']", "0,0")
      end
    end
    
  end
end