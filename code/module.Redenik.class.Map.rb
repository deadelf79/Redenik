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

	def _gen_room
		rect = Rect.new(
			rand(5..@data.xsize-5-@max_room_size),
			rand(5..@data.ysize-5-@max_room_size),
			rand(@max_room_size),
			rand(@max_room_size)
		)
		loop do
			if _collided?
				rect.x = rand(5..@data.xsize-5-@max_room_size),
				rect.y = rand(5..@data.ysize-5-@max_room_size),
				rect.width = rand(@max_room_size),
				rect.height = rand(@max_room_size)
			else
				break
			end
		end
		@room_array << rect
	end
	
	def _collided?(rect)
		collided = false
		@room_array.each{|room|
			if rect.x+rect.width>room.x
				if rect.y+rect.height>room.y
					collided = true
					break
				end
			end
			if rect.x>room.x and rect.x<room.x+room.width
				if rect.y>room.y and rect.y<room.y+room.height
					collided = true
					break
				end
			end
		}
		collided
	end

	def _passed_intersect_limit?(rect)

	end

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