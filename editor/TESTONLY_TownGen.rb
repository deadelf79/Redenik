# encoding utf-8

class HotelHall
	def initialize
	
	end
end

class HotelFloor
	def initialize
	
	end
	
	def place_ladder
	
	end
end

class Hotel
	def initialize
		@hall = HotelHall.new
		@floors = []
		3.times{
			@floors.push HotelFloor.new
		}
	end
end