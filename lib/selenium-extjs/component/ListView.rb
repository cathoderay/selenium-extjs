module Ext
    class ListView < Component
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

    end
end
