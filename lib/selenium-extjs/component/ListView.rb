module Ext
    class ListView < Component
        def click_at_row(label)
            @selenium.click_at(node() + "//div[contains(@class, 'x-list-body-inner')]//em[text() = '#{label}']", "0,0")
        end
    end
end
