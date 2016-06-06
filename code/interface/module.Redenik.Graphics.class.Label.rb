#encoding utf-8

class Redenik::Graphics::Label < Redenik::Graphics::UI_Component
	def initialize(*args)
		super(*args)
		@canvas = Redenik::Graphics::Image.new( 0, 0, width, height, @main_viewport )
	end

	def text(value)
		@canvas.clear
		@canvas.draw_text( @canvas.rect, value, @canvas.white )
	end
end