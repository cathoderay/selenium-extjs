
module Ext
	# component.
	class Grid extend Component
	  def initialize(id)
	    @id = id
	  end
	  def getId()
	    return @id
	  end
	end
end