module Ext
    class ListView < DataView
        
        def has_row(label)
            @selenium.is_element_present(node() + "//div[contains(@class, 'x-list-body-inner')]//em[text() = '#{label}']") 
        end

		def click_at_row(label)
        	@selenium.click_at(node() + "//div[contains(@class, 'x-list-body-inner')]//em[text() = '#{label}']", "0,0")
		end

        def wait_for_row_visible(label, timeout=10)
			exp = node() + "//div[contains(@class, 'x-list-body-inner')]//em[text() = '#{label}']"
			t0 = Time.now
			while true
			  begin
				return true if @selenium.is_visible(exp)
			  rescue
			  end
			  return false if (Time.now - t0) > timeout
			end
        end

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
    end
end
