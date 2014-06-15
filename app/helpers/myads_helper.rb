module MyadsHelper
	def state_bool(array)
		array.map{|value| [value,"can_#{value}?".to_sym] }  
	end
end
