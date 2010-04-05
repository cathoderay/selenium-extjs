module Ext
	class Textarea < Field
		def fill_field_code_mirror(query)
			@selenium.wait_for_element_present(@id)
			@selenium.click_at(@id, "0,0")
			@selenium.wait_for_element_present("//body[@class='editbox']")
			@selenium.type_keys("//body[@class='editbox']", query)
		end
	end
end

