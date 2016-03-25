class Redenik::Graphics::Scalable_Window < Redenik::Graphics::UI_Component
	def initialize(x,y,width,height)
		@frame_offset = 32
		super(
			x+frame_offset,
			y+frame_offset,
			width-frame_offset*2,
			height-frame_offset*2
		)

		@x, @y, @width, @height = x, y, width, height

		@corners = []
		@sides_viewport = []
		@sides = []
		@back_viewport = Viewport.new(
			x+frame_offset,
			y+frame_offset,
			width-frame_offset*2,
			height-frame_offset*2
		)
		@back = Plane.new(@back_viewport)
		@skin = "gfx/skins/classic"
		@last_skin = ""
	end

	def refresh
		# dispose all skin images
		@corners.each{|image|image.dispose}
		@sides_viewport.each{|image|image.dispose}
		@sides.each{|image|image.dispose}
		# temp load
		temp = Bitmap.new(@skin)
		# CORNERS
		arr = [
			Rect.new( 0,	0,	32,	32 ),
			Rect.new( 64,	0,	32,	32 ),
			Rect.new( 0,	64,	32,	32 ),
			Rect.new( 64,	64,	32,	32 )
		]
		(0..3).each do |index|
			@corners[index] = Redenik::Graphics::Image.new( 0, 0, 32, 32 )
			@corners[index].blt( 0, 0, temp, arr[ index ] )
			@corners.x = arr_xy[index][:x]
			@corners.y = arr_xy[index][:y]
		end
		# SIDES
		arr = [
			Rect.new( 32,	0,	32,	32 ), # up
			Rect.new( 0,	32,	32,	32 ), # left
			Rect.new( 32,	64,	32,	32 ), # down
			Rect.new( 64,	32,	32,	32 )  # right
		]
		arr_v = [
			Rect.new(@x+32,@y+32,@width-64,32), # up
			Rect.new(@x+32,@y+32,@width-64,32), # left
			Rect.new(@x+32,@y+32,@width-64,32), # down
			Rect.new(@x+32,@y+32,@width-64,32)  # right
		]
		(0..3).each do |index|
			@sides_viewport[index] = Viewport.new(arr_v[index])
			@sides[index] = Plane.new(@sides_viewport[index])
			@sides[index].bitmap = Bitmap.new(0,0,32,32)
			@sides[index].bitmap.blt( 0, 0, temp, arr[ index ] )
		end
		# temp dispose
		temp.dispose
		# accept skin
		@last_skin = @skin 
		# reposition
		_repos
	end

	def update
		refresh if @skin!=@last_skin
	end

	def frame_offset
		@frame_offset
	end

	def frame_offset=(value)
		@frame_offset = value
	end

	def width=(value)
		@width = value
		_repos
	end

	def height=(value)
		@height = value
		_repos
	end

	def skin
		@skin
	end

	def skin=(value)
		@skin = value
		refresh
	end

	private 

	def _repos
		arr_xy = [
			{ x:@x,				y:@y },
			{ x:@x+@width-32,	y:@y },
			{ x:@x,				y:@y+@height-32 },
			{ x:@x+@width-32,	y:@y+@height-32 }
		]
		(0..3).each do |index|
			@corners.x = arr_xy[index][:x]
			@corners.y = arr_xy[index][:y]
		end
		arr_v = [
			Rect.new(@x+32,@y+32,@width-64,32), # up
			Rect.new(@x+32,@y+32,@width-64,32), # left
			Rect.new(@x+32,@y+32,@width-64,32), # down
			Rect.new(@x+32,@y+32,@width-64,32)  # right
		]
		(0..3).each do |index|
			@sides_viewport[index].rect = arr_v[index]
		end
		@back_viewport.rect = Rect.new(
			x+frame_offset,
			y+frame_offset,
			width-frame_offset*2,
			height-frame_offset*2
		)
	end
end