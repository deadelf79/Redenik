#encoding utf-8
class Redenik::Graphics::Tilemap
	def initialize(map,tileset)
		@tile_data = {}
		@used_tiles = []
		@tileset = tileset
		@map = map
		@image = nil

		refresh
	end

	def refresh
		_analyze_map
		_resize_map
		_load_tileset
		_draw_map
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
		@image = Redenik::Graphics::Image.new( 0, 0, @remap.xsize*32, @remap.ysize*32 )
	end

	def _load_tileset
		wr "\tLoad tileset...",0
		tiles = Bitmap.new( 'gfx/tilesets/' + @tileset )
		@used_tiles.each do |tile|
			@tile_data[tile] = Bitmap.new( 64, 96 )

			tilex = tile % 8
			tiley = ( tile.to_f / 8 ).to_i
			rect = Rect.new( tilex * 64, tiley * 96, 64, 96 )

			@tile_data[tile].blt( 0, 0, tiles, rect )
		end
		@tile_data
		wr "Complete"
	end

	def _draw_map
		@image.clear
		@image.draw_rect(@image.rect,@image.white)
		_draw_normal_tiles
		_draw_auto_tiles
	end

	def _draw_normal_tiles
		wr "\tDraw normal tiles...",0
		for x in 0...@remap.xsize
			for y in 0...@remap.ysize
				if @remap[x,y] >= 1
					id = @remap[x,y]
					rect = Rect.new( 0, 0, 32, 32 )
					@image.blt( x*32, y*32, @tile_data[id], rect )
				end
			end
		end
		wr "Complete"
	end

	def _draw_auto_tiles
		for x in 0...@remap.xsize
			for y in 0...@remap.ysize
				if @remap[x,y] >= 1
					n	 = y - 1 > 0 ? @remap[ x, y - 1 ] == @remap[ x, y ] ? true : false : false
					ne 	 = (y - 1 > 0)&&(x + 1 < @remap.xsize) ? @remap[ x + 1, y - 1 ] == @remap[ x, y ] ? true : false : false
					e	 = x + 1 < @remap.xsize ? @remap[ x + 1, y ] == @remap[ x, y ] ? true : false : false
					se 	 = (y + 1 > 0)&&(x + 1 > 0) ? @remap[ x + 1, y + 1 ] == @remap[ x, y ] ? true : false : false
					s	 = y + 1 < @remap.ysize ? @remap[ x, y + 1 ] == @remap[ x, y ] ? true : false : false
					sw 	 = (y + 1 > 0)&&(x - 1 > 0) ? @remap[ x - 1, y + 1 ] == @remap[ x, y ] ? true : false : false
					w	 = x - 1 > 0 ? @remap[ x - 1, y ] == @remap[ x, y ] ? true : false : false
					nw 	 = (y - 1 > 0)&&(x - 1 < @remap.xsize) ? @remap[ x - 1, y - 1 ] == @remap[ x, y ] ? true : false : false

					id = @remap[ x, y ]

					if n||ne||e||se||s||sw||w||nw
						# outer corners
						@image.blt(x*32, 		y*32, 		@tile_data[id], Rect.new(0, 	32, 	16, 	16)) 	if !n&!w
						@image.blt(x*32+16, 	y*32, 		@tile_data[id], Rect.new(48, 	32, 	16, 	16)) 	if !n&!e
						@image.blt(x*32, 		y*32+16, 	@tile_data[id], Rect.new(0, 	80, 	16, 	16)) 	if !s&!w
						@image.blt(x*32+16, 	y*32+16, 	@tile_data[id], Rect.new(48, 	80, 	16, 	16)) 	if !s&!e
							
						# inner corners
						@image.blt(x*32, 		y*32, 		@tile_data[id], Rect.new(32, 	64, 	16, 	16)) 	if n&w&!nw
						@image.blt(x*32+16, 	y*32, 		@tile_data[id], Rect.new(16, 	64, 	16, 	16)) 	if n&e&!ne
						@image.blt(x*32, 		y*32+16, 	@tile_data[id], Rect.new(32, 	48, 	16, 	16)) 	if s&w&!sw
						@image.blt(x*32+16, 	y*32+16, 	@tile_data[id], Rect.new(16, 	48, 	16, 	16)) 	if s&e&!se
						
						# plain walls - horizontal
						@image.blt(x*32, 		y*32, 		@tile_data[id], Rect.new(16, 	32, 	16, 	16)) 	if !n&w
						@image.blt(x*32+16, 	y*32, 		@tile_data[id], Rect.new(32, 	32, 	16, 	16)) 	if !n&e
						@image.blt(x*32, 		y*32+16, 	@tile_data[id], Rect.new(16, 	80, 	16, 	16)) 	if !s&w
						@image.blt(x*32+16, 	y*32+16, 	@tile_data[id], Rect.new(32, 	80, 	16, 	16)) 	if !s&e

						# plain walls - vertical
						@image.blt(x*32, 		y*32, 		@tile_data[id], Rect.new(0, 	48, 	16, 	16)) 	if n&!w
						@image.blt(x*32+16, 	y*32, 		@tile_data[id], Rect.new(48, 	48, 	16, 	16)) 	if n&!e
						@image.blt(x*32, 		y*32+16, 	@tile_data[id], Rect.new(0, 	64, 	16, 	16)) 	if s&!w
						@image.blt(x*32+16, 	y*32+16, 	@tile_data[id], Rect.new(48, 	64, 	16, 	16)) 	if s&!e
					else
						@image.blt(x*32, 		y*32,	 	@tile_data[id], Rect.new(32, 	0, 		32, 	32))
					end
				end
			end
		end
	end
end