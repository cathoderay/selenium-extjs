module Ext
	class DataView < Component
		def click_at_item(label)
        	@selenium.click_at(node() + "//div[contains(@class, 'x-list-body-inner')]//h4[contains(text(), '" + label + "')]", "0,0")
		end
	end
end
