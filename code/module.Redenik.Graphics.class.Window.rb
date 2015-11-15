# encoding utf-8

class Redenik::Graphics::Window
	def initialize(x, y, width, height)
		@main_viewport = Viewport.new(x, y, width, height)
		@main_viewport.z = 100

		@list = []
		@button_list = []
		@columns = 1
		@active = false
		@select_movement = false
		@select_x_offset = 0.0

		@select = Redenik::Graphics::Image.new(0, 0, 32, 32, @main_viewport)
		@select.copy Redenik::Graphics::Cache.load_bitmap('Gfx/Windows/', 'select')
		@select.z = 100
		@select.oy = -6

		@slider = Redenik::Graphics::Image.new(width-8, 0, 8, height, @main_viewport)
		@slider.z = 200
		@slider.opacity = 128

		select 0
	end

	def x
		@main_viewport.rect.x
	end

	def y
		@main_viewport.rect.y
	end

	def width
		@main_viewport.rect.width
	end

	def height
		@main_viewport.rect.height
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

	def show
		self.visible = true
	end

	def hide
		self.visible = false
	end

	def line_height
		Font.default_size+4
	end

	def add_button(name, method, appearance = nil, second = "", enabled = true)
		@list << {
			name:name,
			method:method,
			appearance:appearance,
			enabled:enabled,
			second:second
		}
	end

	def list
		@list
	end

	def index
		@select_index
	end

	def clear
		@button_list.each{|button|
			button.dispose
		}
	end

	def refresh
		clear
		_draw_all_buttons
		_draw_sliders
	end

	def columns=(value)
		@columns = value if value>=1
	end

	def columns
		@columns
	end

	def select(index, hide = true)
		@select.width = width/columns
		if index<0&&hide
			@select.hide
			@select_index = index
			return
		elsif index<0&&!hide
			index = @list.size - 1
		end
		index = 0 if index >= @list.size
		@select_index = index
		return if @button_list.size == 0

		@select.show
		@select.x = @button_list[index].x
		@select.y = @button_list[index].y
	end

	def update
		return unless @active
		if @select.visible
			if @select_movement
				if (16 - @select_x_offset)>0.2
					@select_x_offset += 0.2
				else
					@select_movement = !@select_movement
				end
			else
				if @select_x_offset > 0 
					@select_x_offset -= 0.2
				else
					@select_movement = !@select_movement
				end
			end
			@select.x = @select_x_offset
			@button_list[@select_index].x = @select_x_offset + 24
		end

		@button_list.each{|button|
			next if @button_list.index(button) == @select_index
			button.move_to(0,button.y)
			button.update
		}

		if Input.trigger?( :DOWN )
			select(@select_index + 1)
		end

		if Input.trigger?( :UP )
			select(@select_index - 1, false)
		end

		@button_list.each{|button|
			if Mouse.area?( button.x + x, button.y + y, button.width, button.height )
				select( @button_list.index( button ) )
			end
		}

		@slider.move_to(
			@slider.x,
			@select_index*@main_viewport.rect.height/@list.size
		)
		@slider.update
	end

	private

	def _draw_all_buttons
		y_offset=0
		@list.each do |button|
			_draw_button(button,y_offset)
			y_offset+=1 if button[:enabled]
		end
	end

	def _draw_button(button,index)
		x_offset = index%columns
		y_offset = index*line_height
		@button_list.push Redenik::Graphics::Image.new(
			x_offset,
			y_offset,
			width/columns,
			line_height,
			@main_viewport
		)

		icon_offset = 0
		if button[:appearance]!=nil
			temp = Redenik::Graphics::Cache.load_bitmap(button[:appearance][:icon])
			icon_offset = temp.width
			temp.dispose
		end

		rect_offsetted = Rect.new(
			@button_list.last.rect.x + icon_offset,
			@button_list.last.rect.y,
			@button_list.last.rect.width,
			@button_list.last.rect.height
		)

		@button_list.last.draw_text(
			rect_offsetted,
			button[:name],
		 	button[:enabled] ? @button_list.last.white : @button_list.last.white(true)
		)
	end

	def _draw_sliders
		if @list.size*line_height>height
			_draw_vertical_slider
		end
	end

	def _draw_vertical_slider
		@slider.height = @main_viewport.rect.height / @list.size
		with @slider do
			draw_rect( rect, white )
			draw_plot( 0, 		0, 			Color.new( 255, 255, 255, 128 ) )
			draw_plot( width-1,	0, 			Color.new( 255, 255, 255, 128 ) )
			draw_plot( 0, 		height-1, 	Color.new( 255, 255, 255, 128 ) )
			draw_plot( width-1, height-1, 	Color.new( 255, 255, 255, 128 ) )
		end
	end
end