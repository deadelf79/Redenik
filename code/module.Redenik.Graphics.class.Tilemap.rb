#encoding utf-8
class Tilemap
	def initialize(map,tileset)
		@tile_data = []
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
	end

	def _load_tileset
		tiles = Bitmap.new(@tileset)
		@used_tiles.each do |tile|
			@tile_data.push Bitmap.new(64,96)

			tilex = tile % 8
			tiley = ( tile.to_f / 8 ).to_i
			rect = Rect.new( tilex * 64, tiley * 96, 64, 96 )

			@tile_data.last.blt( 0, 0, tiles, rect )
		end
		@tile_data
	end

	def _draw_map;end
end