# encoding utf-8

class Redenik::Graphics::UI_Component
	def initialize(x,y,width,height)
		@main_viewport = Viewport.new(x, y, width, height)
		@line_height = DEFAULT_FONT_SIZE
		@active = false
	end

	def x
		@main_viewport.rect.x
	end

	def y
		@main_viewport.rect.y
	end

	def z
		@main_viewport.z
	end

	def x=(value)
		@main_viewport.rect.x = value
	end

	def y=(value)
		@main_viewport.rect.y = value
	end

	def z=(value)
		@main_viewport.z = value
	end

	def width
		@main_viewport.rect.width
	end

	def height
		@main_viewport.rect.height
	end

	def show
		@main_viewport.visible = true
	end

	def hide
		@main_viewport.visible = false
	end

	def visible
		@main_viewport.visible
	end

	def line_height
		@line_height
	end

	def line_height=(value)
		@line_height = (value == :default) ? DEFAULT_FONT_SIZE : value
	end

	def update
		return unless @active
	end

	def activate
		@active = true
	end

	def deactivate
		@active = false
	end

	def is_active?
		@active
	end

	def rect
		Rect.new( x, y, width, height )
	end
end