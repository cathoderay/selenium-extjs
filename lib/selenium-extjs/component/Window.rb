
module Ext
	class Window < Component
	  def close
	    @selenium.click_at( node() + "//div[contains(@class, 'x-tool-close')]", "0,0")
    end
  end
end
