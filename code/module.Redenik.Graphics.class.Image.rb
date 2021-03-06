# encoding utf-8

class Redenik::Graphics::Image < Sprite
	def initialize( x, y, w=32, h=32, viewport = nil )
		@data = Sprite.new(viewport)
		@data.x = x
		@data.y = y
		@data.bitmap = Bitmap.new( w, h )

		@dest_x, @dest_y = @data.x, @data.y
		@moving = false
		self
	end

	def self.open( x, y, bitmap )
		error = [false,false,false]
		unless x.is_a? Fixnum
			x = 0
			error[0]=true
		end
		unless y.is_a? Fixnum
			y = 0
			error[1]=true
		end
		unless bitmap.is_a? Bitmap
			bitmap = Bitmap.new( 32, 32 )
			error[2]=true
		end
		if error[0]&&error[1]&&error[2];raise "Image.open: arg.err: x, y and bitmap has classmissed. Recreated with defaults."
		elsif error[0]&&error[1];raise "Image.open: arg.err: x and y has classmissed. Recreated with defaults."
		elsif error[0]&&error[2];raise "Image.open: arg.err: x and bitmap has classmissed. Recreated with defaults."
		elsif error[1]&&error[2];raise "Image.open: arg.err: y and bitmap has classmissed. Recreated with defaults."
		elsif error[0];raise "Image.open: arg.err: x has classmissed. Recreated with defaults."
		elsif error[1];raise "Image.open: arg.err: y has classmissed. Recreated with defaults."
		elsif error[2];raise "Image.open: arg.err: bitmap has classmissed. Recreated with defaults."
		end

		self.new( x, y, bitmap.width, bitmap.height )
  		self.copy( bitmap )
  		self
  	rescue => e
  		wr e
	end

	def self.safety_open( filename, rect, default_color, viewport = nil )
		if FileTest.exist?(filename)
			self.new( rect.x, rect.y, rect.width, rect.height, viewport )
			@data.bitmap = Bitmap.new( filename )
		else
			self.new( rect.x, rect.y, rect.width, rect.height, viewport )
			@data.x = x
			@data.y = y
			@data.bitmap = Bitmap.new( rect.width, rect.height )
			@data.bitmap.fill_rect( rect, default_color )
		end
		self
	rescue => e
  		wr e
	end

	def copy( bitmap )
		@data.bitmap.dispose
		@data.bitmap = bitmap
		self
	end

	def clone
		my_clone = Redenik::Graphics::Image.new( x, y, width, height )
		my_clone.copy( @data.bitmap )
		my_clone
	end

	def x
		@data.x
	end

	def y
		@data.y
	end

	def z
		@data.z
	end

	def x=( value )
		@data.x = value
		self
	end

	def y=(value)
		@data.y = value
		self
	end

	def z=(value)
		@data.z = value
		self
	end

	def width
		@data.bitmap.width
	end

	def height
		@data.bitmap.height
	end

	def width=(value)
		bitmap = Bitmap.new(value,height)
		bitmap.blt(0,0,@data.bitmap,Rect.new(0,0,width,height))
		@data.bitmap.dispose
		@data.bitmap = bitmap
		self
	end

	def height=(value)
		bitmap = Bitmap.new(width,value)
		bitmap.blt(0,0,@data.bitmap,Rect.new(0,0,width,height))
		@data.bitmap.dispose
		@data.bitmap = bitmap
		self
	end

	def show
		self.visible = true
	end

	def hide
		self.visible = false
	end

	def marshal_dump
		data = [
			@data.bitmap.name,
			@data.x,
			@data.y,
			@data.width,
			@data.height
		]
		data
	end

	# RGSS Sprite

	def visible
		@data.visible
	end

	def visible=(value)
		@data.visible = value
	end

	def update
		# Sprite update
		@data.update
		# Move to
		# Destination X
		if (self.x - @dest_x).abs > 10
			if self.x > @dest_x
				self.x -= (self.x - @dest_x).abs / 4
			else
				self.x += (self.x - @dest_x).abs / 4
			end
		elsif (self.x - @dest_x).abs > 2
			self.x = @dest_x
		end
		# Destination Y
		if (self.y - @dest_y).abs > 10
			if self.y > @dest_y
				self.y -= (self.y - @dest_y).abs / 4
			else
				self.y += (self.y - @dest_y).abs / 4
			end
		elsif (self.y - @dest_y).abs > 2
			self.y = @dest_y
		end

		@moving = (self.x == @dest_x) && (self.y == @dest_y) ? false : true
	end

	def flash(color,duration)
		@data.flash(color,duration)
	end

	def viewport
		@data.viewport
	end

	def ox
		@data.ox
	end

	def oy
		@data.oy
	end

	def ox=(value)
		@data.ox = value
		self
	end

	def oy=(value)
		@data.oy = value
		self
	end

	def zoom_x
		@data.zoom_x
	end

	def zoom_y
		@data.zoom_y
	end

	def zoom_x=(value)
		@data.zoom_x = value
		self
	end

	def zoom_y=(value)
		@data.zoom_y = value
		self
	end

	def angle(rotation)
		@data.angle(rotation)
		self
	end

	def mirror(value=false)
		@data.mirror(value)
		self
	end

	def opacity
		@data.opacity
	end
	
	def opacity=(value)
		@data.opacity = value
		self
	end
	
	def blend_type(type)
		@data.blend_type(type)
		self
	end
	
	def color(color)
		@data.color(color)
		self
	end
	
	def tone(tone)
		@data.tone = tone
		self
	end

	# RGSS Bitmap
			
	def clear
		@data.bitmap.clear
	end

	def font
		@data.bitmap.font
	end

	def font=(value)
		@data.bitmap.font=value if value.is_a? Font
	end

	def blt(x,y,src_bitmap,src_rect,opacity=255)
		@data.bitmap.blt(x,y,src_bitmap,src_rect,opacity=255)
	end

	def stretch_blt(dest_rect,src_bitmap,src_rect,opacity=255)
		@data.bitmap.stretch_blt(dest_rect,src_bitmap,src_rect,opacity=255)
	end

	def rect
		@data.bitmap.rect
	end

	def dispose
		@data.bitmap.dispose
		@data.dispose
		self
	end

	def disposed
		@data.bitmap.disposed&&@data.disposed
		self
	end

	def hue_change(hue)
		@data.bitmap.hue_change(hue)
		self
	end

	def blur
		@data.bitmap.blur
		self
	end

	def radial_blur(angle,division)
		@data.bitmap.radial_blur(angle,division)
		self
	end

	def text_size(str)
		@data.bitmap.text_size(str)
	end

	def get_pixel(x,y)
		@data.bitmap.get_pixel(x,y)
	end

	def set_pixel(x,y,color)
		@data.bitmap.set_pixel(x,y,color)
		self
	end

	def export(filename)
		# require Zeus81's Bitmap Export
		filename.gsub!(/\.(png|bmp)$/){""}
		@data.bitmap.export("#{filename}.png")
		self
	end

	# Movement

	def move_to(x,y)
		@dest_x, @dest_y = x, y
	end

	def moving?
		@moving
	end

	# Drawers

	def clear_rect(rect)
		@data.bitmap.clear_rect(rect)
		self
	end

	def draw_rect(rect,color,fill=true)
		if fill
			@data.bitmap.fill_rect(rect,color)
		else
			# Тогда рисуем линиями
			# Верх
			draw_line(rect.x, rect.y, rect.x + rect.width,rect.y, color)
			# Низ
			draw_line(rect.x, rect.y + rect.height, rect.x + rect.width, rect.y + rect.height, color)
			# Лево
			draw_line(rect.x, rect.y, rect.x, rect.y + rect.height, color)
			# Право
			draw_line(rect.x + rect.width, rect.y, rect.x + rect.width, rect.y + rect.height, color)
		end
		self
	end

	def draw_text(rect,text,color,horizontal_align=0,vertical_align=0)
		@data.bitmap.font.color = color
		text_lines = text.is_a?(String) ? text.split(/\n/) : [text.to_s]
		text_size_height = text_size( text ).height * text_lines.size # <= Добавим немного оптимизации подсчётам
		if rect.height > text_size_height
			case vertical_align
			when 0 # Top
				# do nothing
			when 1 # Center
				rect.y = rect.height - text_size_height/2
			when 2 # Bottom
				rect.y = rect.height - text_size_height
			end
		end
		text_lines.each do |line|
			line_rect = Rect.new(
				rect.x,
				rect.y + text_lines.index(line)*text_size_height/text_lines.size,
				rect.width,
				text_size_height/text_lines.size
			)
			@data.bitmap.draw_text(line_rect,line,horizontal_align)
		end
		self
	end

	def draw_line(x1,y1,x2,y2,color,rasterize=false)
		# Проверка, одинаковы ли координаты - если да, рисуем точку
		draw_plot(x1,y1,color) if x1==x2&&y1==y2
		# Проверка, прямая ли линия - если да, то прямоугольником проще
		if y1==y2
			x1,x2 = _swap(x1,x2) if x1>x2
			draw_rect( Rect.new(x1,y1,x2-x1,1), color )
		end
		if x1==x2
			y1,y2 = _swap(y1,y2) if y1>y2
			draw_rect( Rect.new(x1,y1,1,y2-y1), color )
		end
		# Проверка, использована ли растеризация - если да,
		# то переводим с антиалиасингом (Алгоритм Ву),
		# если нет - то рисуем Алгоритмом Брезенхема
		if rasterize
			_draw_line_wu(x1,y1,x2,y2,color)
		else
			_draw_line_bresenham(x1,y1,x2,y2,color)
		end
	end

	def draw_circle(x,y,radius,color,rasterize=false)
		if rasterize
			_draw_circle_wu(x,y,radius,color)
		else
			_draw_circle_bresenham(x,y,radius,color)
		end
	end

	def draw_circle_rect(x1,y1,x2,y2,color,rasterize=false);end

	def draw_arc(center_x,center_y,start_angle,end_angle,radius,rasterize=false);end

	def draw_plot(x,y,color)
		@data.bitmap.set_pixel(x,y,color)
	end

	def flood_fill(x,y,color)
		# Код перенесен отсюда: http://rosettacode.org/wiki/Category:Ruby
		# Переписано для соответствия с RGSS и Image
		current_color = self.get_pixel(x,y)
		queue = []
		queue.push({x:x,y:y})
		until queue.empty?
			last = queue.shift
			if current_color == self.get_pixel(last[:x],last[:y])
				west = _find_border(last, current_color, :west)
				east = _find_border(last, current_color, :east)
				self.draw_line(west[:x], west[:y], east[:x], east[:y], color)
				q = west
				while q[:x] < east[:x]
					[:north, :south].each do |direction|
						n = _neighbour_pixel(q, direction)
						queue.push(n) if current_color == self.get_pixel(n[:x],n[:y])
					end
					q = _neighbour_pixel(q, :east)
				end
			end
		end
	end

	def draw_icon(icon_index)
		
	end


	# Colors

	def white(subdued=false)
		subdued ? Color.new(237,237,237) : Color.new(255,255,255)
	end

	def black(subdued=false)
		subdued ? Color.new(25,25,25) : Color.new(0,0,0)
	end

	def red(subdued=false)
		subdued ? Color.new(217,31,31) : Color.new(255,0,0)
	end

	def orange(subdued=false)
		subdued ? Color.new(217,115,31) : Color.new(255,128,0)
	end

	def yellow(subdued=false)
		subdued ? Color.new(217,217,31) : Color.new(255,255,0)
	end

	def lime(subdued=false)
		subdued ? Color.new(115,217,31) : Color.new(128,255,0)
	end

	def green(subdued=false)
		subdued ? Color.new(31,217,31) : Color.new(0,255,0)
	end

	def cyan(subdued=false)
		subdued ? Color.new(66,169,255) : Color.new(0,128,255)
	end

	def blue(subdued=false)
		subdued ? Color.new(31,51,217) : Color.new(0,0,255)
	end

	def purple(subdued=false)
		subdued ? Color.new(115,31,115) : Color.new(128,0,128)
	end

	def pink(subdued=false)
		subdued ? Color.new(217,31,169) : Color.new(255,0,128)
	end

	private

	def _swap(v1,v2)
		[v2,v1]
	end

	def _draw_line_bresenham(x1,y1,x2,y2,color)
		# За код на C#, с которого я переписывал,
		# спасибо BasmanovDaniil
		# Оригинальная статья: http://habrahabr.ru/post/185086/
		steep = (y2-y1).abs > (x2-x1).abs
		if steep
			x1,y1 = _swap(x1,y1)
			x2,y2 = _swap(x2,y2)
		end
		if x1>x2
			x1,x2 = _swap(x1,x2)
			y1,y2 = _swap(y1,y2)
		end
		deltax, deltay = x2 - x1, (y2 - y1).abs
    	error, ystep = (deltax.to_f/2).to_i, (y1 < y2) ? 1 : -1
     	y = y1
     	(x1...x2).each do |x|
        	draw_plot(steep ? y : x, steep ? x : y, color)
     		error -= deltay
        	if error < 0
				y += ystep
				error += deltax
            end
        end
	end

	def _draw_line_wu(x1,y1,x2,y2,color)
		
	end

	def _draw_circle_bresenham(x0,y0,radius,color)
		# Исходный код: http://habrahabr.ru/post/185086/
		x = radius
		y = 0
		radius_error = 1 - x
		while (x>=y)
			draw_plot( x+x0,		y+y0,	color )
			draw_plot( y+x0,		x+y0,	color )
			draw_plot( -x+x0,		y+y0,	color )
			draw_plot( -y+x0,		x+y0,	color )
			draw_plot( -x+x0,		-y+y0,	color )
			draw_plot( -y+x0,		-x+y0,	color )
			draw_plot( x+x0,		-y+y0,	color )
			draw_plot( y+x0,		-x+y0,	color )
			y+=1

			if (radius_error < 0)
				radius_error += 2 * y + 1
			else
				x-=1
				radius_error += 2 * (y - x + 1)
			end
		end
	end

	def _neighbour_pixel(pixel,direction)
		case direction
		when :north then { x:pixel[:x], y:pixel[:y] - 1 }
		when :south then { x:pixel[:x], y:pixel[:y] + 1 }
		when :east then { x:pixel[:x] + 1, y:pixel[:y] }
		when :west then { x:pixel[:x] - 1, y:pixel[:y] }
		end
	end

	def _find_border(pixel,color,direction)
		nextpixel = _neighbour_pixel(pixel, direction)
		while self.get_pixel(nextpixel[:x],nextpixel[:y]) == color
			pixel = nextpixel
			nextpixel = _neighbour_pixel(pixel,direction)
		end
		pixel
	end
end