# encoding utf-8

class Redenik::Graphics::Map
	attr_accessor :events, :data
	def initialize(id,width,height,type,min_level,max_level)
		@map_id = id
		@data = Table.new(width,height)
		@type, @min_level, @max_level = type, min_level, max_level
		@events = []
	end

	def width
		@data.xsize
	end

	def height
		@data.ysize
	end
	
	def is_safe?
		type==:safe
	end
	
	def is_store?
		type==:store
	end
	
	def is_inn?
		type==:inn
	end
	
	def is_pub?
		type==:pub
	end
	
	def is_floor?
		type==:floor
	end
	
	def is_dungeon?
		type==:dungeon
	end
	
	def is_town?
		type==:town
	end
	
	def is_vault?
		type==:vault
	end

	def is_basement?
		type==:basement
	end

	def save_changes;end
end