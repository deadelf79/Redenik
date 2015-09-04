# encoding utf-8

class Redenik::Graphics::Window < Redenik::Graphics::Image
	def initialize(x,y,width,height)
		super(x,y,width,height)
		@list = []
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

	private

	def _draw_all_buttons
		@list.each{|index|_draw_button(index)}
	end

	def _draw_button(index)
		icon_offset = 0
		if @list[index][:appearance]!=nil
			temp = Cache.load_bitmap(@list[index][:appearance][:icon])
			icon_offset = temp.width
			temp.dispose
		end
		self.draw_text(Rect.new(0,index*line_height,width,line_height),@list[index][:name],@list[index][:enabled] ? white : white(true))
	end
end