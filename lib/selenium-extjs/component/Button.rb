
module Ext
	class Button < Component

	  def click
	    wait_for_ajax()
      @selenium.click_at(selector(), "0,0")
    end

    def node
      return "//table[@id='#{@id}']//button"
    end
  end
end
