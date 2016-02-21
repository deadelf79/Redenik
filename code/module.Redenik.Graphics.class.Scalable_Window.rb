class Redenik::Graphics::Scalable_Window < Redenik::Graphics::UI_Component
	def initialize(x,y,width,height)
		@frame_offset = 16
		super(
			x+frame_offset,
			y+frame_offset,
			width-frame_offset*2,
			height-frame_offset*2
		)

		@x, @y, @width, @height = x, y, width, height

		@corners = []
		@skin = "gfx/skins/classic"
	end

	def refresh
		temp = Bitmap.new(@skin)
		# left up
		rect = Rect.new(0,0,frame_offset,frame_offset)
		@corners[0] = Redenik::Graphics::Image.new(0,0,frame_offset,frame_offset)
		@corners[0].blt(0,0,temp,rect)
		# right up
		rect = Rect.new(64,0,frame_offset,frame_offset)
		@corners[1] = Redenik::Graphics::Image.new(0,0,frame_offset,frame_offset)
		@corners[1].blt(0,0,temp,rect)
	end

	def frame_offset
		@frame_offset
	end

	def frame_offset=(value)
		@frame_offset = value
	end

	def width=(value)
		width = value
	end

	def height=(value)
		height = value
	end

	def skin
		@skin
	end

	def skin=(value)
		@skin = value
		refresh
	end
end