
module Ext
	class Button < Component
		def click
			@selenium.click_at(selector(), "0,0")
		end

		def node
			return "//table[@id='#{@id}']//button"
		end
  end
end
