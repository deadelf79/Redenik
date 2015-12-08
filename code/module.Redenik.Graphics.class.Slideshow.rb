# encoding utf-8
class Redenik::Graphics::Slideshow < Redenik::Graphics::UI_Component
	def initialize(x, y, width, height)
		super(x, y, width, height)
		@list 		 = []
		@slides_list = []
		@arrow_left  = Redenik::Graphics::Image.new( x-24, y+height/2-8, 16, 16 )
		@arrow_right = Redenik::Graphics::Image.new( x+width+12, y+height/2-8, 16, 16 )
		@arrow_left.z = self.z + 1
		@arrow_right.z = self.z + 1
		@arrow_orig_left, @arrow_orig_right = @arrow_left.x, @arrow_right.x
		@arrow_offset_left, @arrow_offset_right, @arrow_anim = 0.0, 0.0, false
		@arrow_block_left, @arrow_block_right = false, false

		@index = 0
		@control = true
		@show_arrows = true
		select 0
	end

	def deactivate
		super
		@arrow_left.x  = @arrow_orig_left
		@arrow_right.x = @arrow_orig_right
	end

	def z=(value)
		super
		@arrow_left.z = self.z + 1
		@arrow_right.z = self.z + 1
	end

	def add_slide(name, filename, appearance=nil)
		appearance = {background:Color.new(0,0,0,128),color:Color.new(0,255,0)} if appearance.nil?
		@list.push({
			name:name,
			filename:filename,
			appearance:appearance
		})
	end

	def list
		@list
	end

	def index
		@index
	end

	def refresh
		clear
		_draw_all_slides
		_draw_arrow_left
		_draw_arrow_right
	end

	def clear
		@slides_list.each{ | slide | slide.dispose }
		@slides_list.clear
	end

	def show_arrows=(enabled)
		@show_arrows = enabled
		@arrow_left.visible = enabled
		@arrow_right.visible = enabled
	end

	def select(index)
		@index = index
		@index = 0 if @index > @list.size - 1
		@index = @list.size - 1 if @index < 0
		
		@slides_list.each do |slide|
			slide.move_to( ( @slides_list.index( slide )-@index ) * self.width, 0 )
		end
	end

	def control=(enabled)
		@control = enabled
	end

	def block_left?
		@arrow_block_left
	end

	def block_right?
		@arrow_block_right
	end

	def block_left
		@arrow_block_left = true
	end

	def unblock_left
		@arrow_block_left = false
	end

	def block_right
		@arrow_block_right = true
	end

	def unblock_right
		@arrow_block_right = false
	end

	def update
		super
		if @control
			if Input.trigger?( :LEFT )&&!@arrow_block_left
				select(@index - 1)
			end
			if Input.trigger?( :RIGHT )&&!@arrow_block_right
				select(@index + 1)
			end
		end
		@slides_list.each{ | slide | slide.update }
		_update_arrow_movement
		_update_arrow_block
	end

	private

	def _draw_all_slides
		for index in 0...@list.size
			_draw_slide( index )
		end
	end

	def _draw_slide(slide_index)
		x_offset = @slides_list.size * self.width
		@slides_list.push Redenik::Graphics::Image.new(
			x_offset,
			0,
			self.width,
			self.height,
			@main_viewport
		)
		if @list[ slide_index ][ :filename ] != "" && !@list[ slide_index ][ :filename ].nil?
			@slides_list.last.copy(
				Redenik::Graphics::Cache.load_bitmap( "Gfx/Slides/", @list[ slide_index ][ :filename ] )
			)
		end
		name_rect = Rect.new( 4, self.height - 20, self.width, 20 )
		@slides_list.last.font.name = "Tahoma"
		@slides_list.last.font.size = 16
		@slides_list.last.draw_rect( name_rect, @list[ slide_index ][ :appearance ][ :background ] )
		@slides_list.last.draw_text( name_rect, @list[ slide_index ][ :name ], @list[ slide_index ][ :appearance ][ :color ], 1 )
	end

	def _draw_arrow_left
		with @arrow_left do
			clear
			# брезенхэм!
			draw_line( width/2, 	0, 			width, 		0, 			white )
			draw_line( width/2, 	0, 			0, 			height/2, 	white )
			draw_line( width, 		0, 			width/2, 	height/2, 	white )
			draw_line( width/2, 	height, 	0, 			height/2, 	white )
			draw_line( width, 		height, 	width/2, 	height/2, 	white )
			draw_line( width/2, 	height-1, 	width, 		height-1, 	white )
			flood_fill( width/2+1, 1, white)
		end
	end

	def _draw_arrow_right
		with @arrow_right do
			clear
			# брезенхэм!
			draw_line( 0, 			0, 			width/2-1, 	0, 			white )
			draw_line( 0, 			0, 			width/2, 	height/2, 	white )
			draw_line( width/2-1, 	0, 			width-1, 	height/2, 	white )
			draw_line( 0, 			height-1, 	width/2, 	height/2-1, white )
			draw_line( width/2-1, 	height-1, 	width-1, 	height/2-1, white )
			draw_line( 0, 			height-1, 	width/2-1, 	height-1, 	white )
			flood_fill( width/2-1, 1, white)
		end
	end

	def _update_arrow_movement
		if @arrow_anim
			if @arrow_offset_left < 8 || @arrow_offset_right < 8
				@arrow_offset_left 	+= 0.2 if @arrow_offset_left  < 8
			 	@arrow_offset_right += 0.2 if @arrow_offset_right < 8
			else
				@arrow_anim = false
			end
		else
			if @arrow_offset_left > 0 || @arrow_offset_right > 0
				@arrow_offset_left 	-= 0.2 if @arrow_offset_left  > 0
			 	@arrow_offset_right -= 0.2 if @arrow_offset_right > 0
			else
				@arrow_anim = true
			end
		end
		@arrow_left.x 	= @arrow_orig_left 	+ @arrow_offset_left
		@arrow_right.x 	= @arrow_orig_right - @arrow_offset_right
	end

	def _update_arrow_block
		if @arrow_block_left
			@arrow_left.visible = false
		else
			@arrow_left.visible = true if @show_arrows
		end

		if @arrow_block_right
			@arrow_right.visible = false
		else
			@arrow_right.visible = true if @show_arrows
		end
	end 
end