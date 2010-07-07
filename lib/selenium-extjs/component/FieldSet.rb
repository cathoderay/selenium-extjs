
module Ext
  class FieldSet < Panel
    def init_component()
      super()
    end
    
    def collapse
        @selenium.click_at("//fieldset[@id='#{@id}']//*[contains(@class, 'x-tool-toggle')]", "0,0")
    end
  end
end
