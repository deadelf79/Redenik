#encoding utf-8
class Redenik::Graphics::Tilemap
	def initialize(map,tileset)
		@tile_data = {}
		@used_tiles = []
		@tileset = tileset
		@map = map
		@image = Redenik::Graphics::Image(@map.width, @map.height)

		_analyze_map
		_load_tileset
		_draw_map
	end

	def refresh

	end
	
	def dispose;end

	private

	def _analyze_map
		@used_tiles.clear
		for x in 0...@map.width
			for y in 0...@map.height
				if @map.data[x,y] >= 1
					@used_tiles << @map.data[x,y] unless @used_tiles.include? @map.data[x,y]
				end
			end
		end
		@used_tiles
	end

	def _resize_map
		@remap = @map.data
	end

	def _load_tileset
		tiles = Bitmap.new('gfx/tilesets/'+@tileset)
		@used_tiles.each do |tile|
			@tile_data[tile] = Bitmap.new(64,96)

			tilex = tile % 8
			tiley = ( tile.to_f / 8 ).to_i
			rect = Rect.new( tilex * 64, tiley * 96, 64, 96 )

			@tile_data[tile].blt( 0, 0, tiles, rect )
		end
		@tile_data
	end

	def _draw_map
		@image.clear
		# draw sample tiles only
		for x in 0...@remap.width
			for y in 0...@remap.height
				if @remap.data[x,y] >= 1
					id = @remap.data[x,y]
					rect = Rect.new( 0, 0, 32, 32 )
					@image.blt( x*32, y*32, @tile_data[id], rect )
				end
			end
		end
		# draw autotiles
		for x in 0...@remap.width
			for y in 0...@remap.height
				if @remap.data[x,y] >= 1
					n	 = y - 1 > 0 ? @remap.data[ x, y - 1 ] = @remap.data[ x, y ] ? true : false : false
					ne 	 = (y - 1 > 0)&&(x + 1 < @remap.width) ? @remap.data[ x + 1, y - 1 ] = @remap.data[ x, y ] ? true : false : false
					e	 = x + 1 < @remap.width ? @remap.data[ x - 1, y ] = @remap.data[ x, y ] ? true : false : false
					se 	 = (y + 1 > 0)&&(x + 1 > 0) ? @remap.data[ x + 1, y + 1 ] = @remap.data[ x, y ] ? true : false : false
					s	 = y + 1 < @remap.height ? @remap.data[ x, y + 1 ] = @remap.data[ x, y ] ? true : false : false
					sw 	 = (y + 1 > 0)&&(x - 1 > 0) ? @remap.data[ x - 1, y + 1 ] = @remap.data[ x, y ] ? true : false : false
					w	 = x - 1 > 0 ? @remap.data[ x - 1, y ] = @remap.data[ x, y ] ? true : false : false
					nw 	 = (y - 1 > 0)&&(x - 1 < @remap.width) ? @remap.data[ x - 1, y - 1 ] = @remap.data[ x, y ] ? true : false : false

					if n||ne||e||se||s||sw||w||nw
						if n&w&!nw
							@image.blt(x*32, y*32, @tile_data[id], Rect.new(32, 64, 16, 16))
						end
					else
						next
					end
				end
			end
		end
	end
end