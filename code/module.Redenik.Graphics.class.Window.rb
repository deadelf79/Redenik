# encoding utf-8

class Redenik::Graphics::Window < Redenik::Graphics::Image
	def initialize(x,y,width,height)
		super(x,y,width,height)
		@list = []
		@columns = 1
	end

	def show
		self.visible = true
	end

	def hide
		self.visible = false
	end

	def line_height
		Font.default_size+4
	end

	def add_button(name, method, appearance = nil, enabled = true)
		@list << {
			:name => name,
			:method => method,
			:appearance => appearance,
			:enabled => enabled
		}
	end

	def refresh
		self.clear
		_draw_all_buttons
	end

	def columns=(value)
		@columns = value if value>=1
	end

	def columns
		@columns
	end

	private

	def _draw_all_buttons
		@list.each{|button|_draw_button(button,@list.index(button))}
	end

	def _draw_button(button,index)
		icon_offset = 0
		if button[:appearance]!=nil
			temp = Redenik::Graphics::Cache.load_bitmap(button[:appearance][:icon])
			icon_offset = temp.width
			temp.dispose
		end
		x_offset = index%columns
		self.draw_text(
			Rect.new(x_offset+icon_offset,index*line_height,width/columns-icon_offset,line_height),
			button[:name],
			button[:enabled] ? white : white(true)
		)
	end
end