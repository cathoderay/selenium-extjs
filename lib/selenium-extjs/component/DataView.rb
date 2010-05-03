module Ext
	class DataView < Component
		def click_at_item(label)
			#TODO: generalize this (h4)
        	#@selenium.click_at(node() + "//div[contains(@class, 'x-list-body-inner')]//h4[contains(text(), '" + label + "')]", "0,0")
		end

        def get_item_selector()
            selector  = @selenium.get_eval("window.Ext.getCmp('#{@id}').itemSelector") 
            return node() + "//" + selector.split(".")[0]
        end

        def is_text_present(path, text)
            return @selenium.is_visible(path + "//*[contains(text(), '#{text}')]")
        end
	end
end
