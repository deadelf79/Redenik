# encoding utf-8

class Redenik::Map
	attr_accessor :events, :tileset, :autotiles
	def initialize(id,width,height,type,min_level,max_level,max_rooms=100)
		@map_id = id
		@data = Table.new(width,height,3)
		@type, @max_rooms = type, max_rooms
		@min_level, @max_level = min_level, max_level
		@room_array, @passage_array = [],[]
		_gen_room
		_gen_passage
		_render_map
		_save_map
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


	private

	def _gen_room;end
	def _gen_passage;end
	def _render_map;end
	def _save_map(full_mode=false)
		if full_mode
			content = {
				:data => @data,
				:type => @type,
				:events => @events,
				:tileset => @tileset,
				:autotiles => @autotiles,
				:max_rooms => @max_rooms,
				:room_array => @room_array,
				:passage_array => @passage_array
			}
		else
			content = {
				:data => @data,
				:type => @type,
				:events => @events,
				:tileset => @tileset,
				:autotiles => @autotiles
			}
		end
		save_data(content,"")
	end
end