# encoding utf-8

class Redenik::Graphics::Window < Redenik::Graphics::Image
	def initialize(x,y,width,height)
		super(x,y,width,height)
		@list = []
		@columns = 1
		puts x
		puts y

		@select = Redenik::Graphics::Image.new(0,0)
		@select.width = width/columns
		@select.copy Redenik::Graphics::Cache.load_bitmap('Gfx/Windows/','select')
		@select.z = self.z + 1
		@select.opacity = 158
		@select.ox, @select.oy = @select.width/2, @select.height/2

		@select_alpha = false
		
		select 0

		@active = false
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
		font.size+4
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
		_show_sliders
	end

	def columns=(value)
		@columns = value if value>=1
	end

	def columns
		@columns
	end

	def select(index, hide = true)
		@select.width = width/columns
		@select_index = index
		if index<0&&hide
			@select.hide 
			return
		else
			index = @list.size - 1
		end

		@select.show
		x_offset = index%columns
		y_offset = 0
		@list.each{|button|
			y_offset+=1 if button[:enabled]
		}

		@select.x = x_offset + x + @select.width/2
		@select.y = y_offset*line_height + y + @select.height/2
	end

	def update
		return unless @active
		if @select.visible
			if @select_alpha
				if @select.opacity < 158
					@select.opacity += 1
					@select.zoom_x -= 0.001
					@select.zoom_y -= 0.001
				else
					@select_alpha = false
				end
			else
				if @select.opacity > 64
					@select.opacity -= 1
					@select.zoom_x += 0.001
					@select.zoom_y += 0.001
				else
					@select_alpha = true
				end
			end
		end

		if Input.trigger?(:DOWN)
			select(@select_index+1)
		end

		if Input.trigger?(:UP)
			select(@select_index-1,false)
		end
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

	def _show_sliders
		# проверяем по вертикали
		# если общая высота элементов больше высоты окна, то...
		if @list.size*line_height>width

		end
	end
end