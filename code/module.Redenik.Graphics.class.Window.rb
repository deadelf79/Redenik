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

		@button_h_offset = 0

		select 0
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
		@main_viewport.visible = true
	end

	def hide
		@main_viewport.visible = false
	end

	def visible
		@main_viewport.visible
	end

	def line_height
		DEFAULT_FONT_SIZE
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

		while @button_list[index].y>height
			@button_list.each{ |button| button.y-=line_height }
		end
		while @button_list[index].y<0
			@button_list.each{ |button| button.y+=line_height }
		end
		@select.show
		@select.x = 0
		@select.y = @button_list[index].y
	end

	def update
		return unless @active
		_update___select_animation
		_update___button_animation
		_update___button_select_by_keys
		_update___button_select_by_mouse
		_update___button_select_by_wheel
		_update___slider_movement
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

	def _update___select_animation
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
	end

	def _update___button_animation
		@button_list.each{|button|
			next if @button_list.index(button) == @select_index
			button.move_to(0,button.y)
			button.update
		}
	end

	def _update___button_select_by_keys
		if Input.trigger?( :DOWN )
			select(@select_index + 1)
		end

		if Input.trigger?( :UP )
			select(@select_index - 1, false)
		end
	end

	def _update___button_select_by_mouse
		@button_list.each{|button|
			if Mouse.area?( x, y, width, height )
				if Mouse.area?( (button.x - @select_x_offset) + x, button.y + y, button.width, button.height )
					select( @button_list.index( button ) ) if @button_list.index( button ) != @select_index
				end
			end
		}
	end

	def _update___button_select_by_wheel
		if Mouse.area?( x, y, width, height )
			f = Mouse.scroll
			if !f.nil?
				if f[2] < 0
					select(@select_index + 1)
					Mouse.set_pos( Mouse.pos[0], y + @button_list[@select_index].y + 5 )
				else
					select(@select_index - 1, false)
					Mouse.set_pos( Mouse.pos[0], y + @button_list[@select_index].y + 5 )
				end
			end
		end
	end

	def _update___slider_movement
		@slider.move_to(
			@slider.x,
			@select_index*@main_viewport.rect.height/@list.size
		)
		@slider.update
	end
end