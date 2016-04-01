# encoding utf-8

class Redenik::Graphics::Window < Redenik::Graphics::UI_Component
	def initialize(x, y, width, height)
		super(x, y, width, height)

		@abc=[]
		('A'..'Z').each{|a|@abc+=[a]}
		@last_abc = nil

		@list = []
		@button_list = []
		@columns = 1
		@column_width = self.width / @columns
		@select_movement = false
		@select_x_offset = 0.0

		@select = Redenik::Graphics::Image.new(0, 0, 32, 32, @main_viewport)
		@select.copy Redenik::Graphics::Cache.load_bitmap('Gfx/Windows/', 'select')
		@select.z = self.z + 10
		@select.oy = -6

		@slider = Redenik::Graphics::Image.new(width-8, 0, 8, height, @main_viewport)
		@slider.z = self.z + 10
		@slider.opacity = 128

		@button_h_offset = 0

		select 0
	end

	def z=(value)
		super
		@select.z = self.z + 10
		@slider.z = self.z + 10
	end

	def activate
		super
		@select.show
	end

	def deactivate
		super
		@select.hide
	end

	def add_button(name, method, appearance = nil, second = "", enabled = true)
		@last_abc = 'A' if @last_abc.nil?
		@list << {
			name:name,
			method:method,
			appearance:appearance,
			enabled:enabled,
			second:second,
			abc:@last_abc
		}
		@last_abc = @last_abc=='Z' ? 0 : @abc[@abc.index(@last_abc)+1]
	end

	def list
		@list
	end

	def index
		@select_index
	end

	def clear(full=false)
		@button_list.each{|button|
			button.dispose
		}
		@button_list.clear
		@list.clear if full
	end

	def refresh
		clear
		_draw_all_buttons
		_draw_sliders
	end

	def columns=(value)
		@columns = value if value>=1
		refresh
	end

	def columns
		@columns
	end

	def column_width
		@column_width
	end

	def column_width=(value)
		value = 1  if value < 1
		value = width if value > width
		@column_width = value
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

		while @button_list[index].y > height
			@button_list.each do |button|
				button.x = @button_list.index(button) % columns * column_width
				button.y -= line_height
			end
		end
		while @button_list[index].y < 0
			@button_list.each do |button|
				button.x = @button_list.index(button) % columns * column_width
				button.y += line_height
			end
		end
		@select.show
		@select.x = 0
		@select.y = @button_list[index].y
	end

	def update
		super
		_update___select_animation
		_update___button_animation
		_update___button_select_by_keys
		_update___button_select_by_mouse
		_update___button_select_by_wheel
		_update___slider_movement
	end

	private

	def _draw_all_buttons
		y_offset = 0
		@list.each do |button|
			_draw_button(button,y_offset)
			y_offset += 1 if button[:enabled]
		end
	end

	def _draw_button( button, index )
		x_offset = index % columns * column_width
		y_offset = index/ columns * line_height
		@button_list.push Redenik::Graphics::Image.new(
			x_offset,
			y_offset,
			column_width,
			line_height,
			@main_viewport
		)

		icon_offset = 0
		if button[:appearance]!=nil
			temp = Redenik::Graphics::Cache.load_bitmap( 'Gfx/Icons/', button[:appearance][:icon] )
			icon_offset = temp.width
			@button_list.last.blt( 0, 0, temp, @button_list.last.rect )
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

		# rect_letter = Rect.new(
		# 	@button_list.last.rect.x + @button_list.last.rect.width - 64,
		# 	@button_list.last.rect.y,
		# 	32,
		# 	@button_list.last.rect.height
		# )

		# @button_list.last.draw_text(
		# 	rect_letter,
		# 	@list[@button_list.index(@button_list.last)][:abc],
		# 	@button_list.last.orange(true)
		# )
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
		return if @button_list.size==0
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

		@list.each do |item|
			if eval("Keys.press?(Keys::CONTROL)&&Keys.trigger?(Keys::#{item[:abc]})")
				select( @list.index(item) )
			end
		end
	end

	def _update___button_select_by_mouse
		@button_list.each do |button|
			if Mouse.area?( x, y, width, height )
				if Mouse.area?( (button.x - @select_x_offset - 24) + x, button.y + y, button.width, button.height )
					Redenik::GameManager.debug_canvas.clear
					rect = Rect.new(
						button.x - @select_x_offset - 24 + x,
						button.y + y,
						button.width,
						button.height
					)
					color = Color.new( 255, 135, 0 )
					Redenik::GameManager.debug_canvas.draw_rect(rect, color, false)
					rect = Rect.new(
						button.x + button.width - 48 - @select_x_offset - 24 + x,
						button.y + y,
						button.width,
						button.height
					)
					text = @list[ @button_list.index(button) ][:abc]
					Redenik::GameManager.debug_canvas.draw_text(rect, text, color)

					select( @button_list.index( button ) ) if @button_list.index( button ) != @select_index
				end
			end
		end
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
		return if @list.size==0
		@slider.move_to(
			@slider.x,
			@select_index*@main_viewport.rect.height/@list.size
		)
		@slider.update
	end
end