# encoding utf-8

class Redenik::Graphics::Image < Sprite
	def initialize(x,y,w,h)
		@data = Sprite.new
		@data.x = x
		@data.y = y
		@data.bitmap = Bitmap.new(w,h)
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
	end

	def height=(value)
		bitmap = Bitmap.new(width,value)
		bitmap.blt(0,0,@data.bitmap,Rect.new(0,0,width,height))
		@data.bitmap.dispose
		@data.bitmap = bitmap
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
	end

	def disposed
		@data.bitmap.disposed&&@data.disposed
	end

	def hue_change(hue)
		@data.bitmap.hue_change(hue)
	end

	def blur
		@data.bitmap.blur
	end

	def radial_blur(angle,division)
		@data.bitmap.radial_blur(angle,division)
	end

	def text_size(str)
		@data.bitmap.text_size(str)
	end

	def get_pixel(x,y)
		@data.bitmap.get_pixel(x,y)
	end

	def set_pixel(x,y,color)
		@data.bitmap.set_pixel(x,y,color)
	end

	# Drawers

	def clear_rect(rect)
		@data.bitmap.clear_rect(rect)
	end

	def draw_rect(rect,color,fill=true)
		if fill
			@data.bitmap.draw_rect(rect,color)
		else
			# Тогда рисуем линиями
			# Верх
			draw_line(rect.x,rect.y,rect.x + rect.width,rect.y)
			# Низ
			draw_line(rect.x,rect.height,rect.x + rect.width,rect.height)
			# Лево
			draw_line(rect.x,rect.y,rect.x,rect.y + rect.height)
			# Право
			draw_line(rect.x + rect.width,rect.y,rect.x + rect.width,rect.height)
		end
	end

	def draw_text(rect,text,color,horizontal_align=0,vertical_align=0)
		@data.bitmap.font.color = color
		text_size_height = text_size(text).height # <= Добавим немного оптимизации подсчётам
		if rect.height>text_size_height
			case vertical_align
			when 0 # Top
				rect.y = 0
			when 1 # Center
				rect.y = rect.height - text_size_height/2
			when 2 # Bottom
				rect.y = rect.height - text_size_height
			end
		end
		@data.bitmap.draw_text(rect,text,horizontal_align)
	end

	def draw_line(x1,y1,x2,y2,color,rasterize=false)
		# Проверка, одинаковы ли координаты - если да, рисуем точку
		draw_plot(x1,y1,color) if x1==x2&&y1==y2
		# Проверка, прямая ли линия - если да, то прямоугольником проще
		if y1==y2
			x1,x2 = _swap(x1,x2) if x1>x2
			draw_rect(Rect.new(x1,y1,x2-x1,1))
		end
		if x1==x2
			y1,y2 = _swap(y1,y2) if y1>y2
			draw_rect(Rect.new(x1,y1,1,y2-y1))
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

	def draw_circle(x,y,radius,color);end
	def draw_circle_rect(x1,y1,x2,y2,color);end

	def draw_plot(x,y,color)
		@data.bitmap.set_pixel(x,y,color)
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
		subdued ? Color.new(255,255,51) : Color.new(255,255,0)
	end

	def lime(subdued=false)
		subdued ? Color.new(217,115,31) : Color.new(128,255,0)
	end

	def green(subdued=false)
		subdued ? Color.new(217,115,31) : Color.new(0,255,0)
	end

	def cyan(subdued=false)
		subdued ? Color.new(66,169,255) : Color.new(0,128,255)
	end

	def blue(subdued=false)
		subdued ? Color.new(217,115,31) : Color.new(0,0,255)
	end

	def purple(subdued=false)
		subdued ? Color.new(217,115,31) : Color.new(128,0,128)
	end

	def pink(subdued=false)
		subdued ? Color.new(217,115,31) : Color.new(255,128,0)
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
		steep ? (x1,y1 = _swap(x1,y1)) : (x2,y2 = _swap(x2,y2))
		if x1>x2
			x1,x2 = _swap(x1,x2)
			y1,y2 = _swap(y1,y2)
		end
		deltax, deltay = x2 - x1, (y2 - y1).abs
    	error, ystep = (deltax.to_f/2).to_i, (y1 < y2) ? 1 : -1
     	y = y1
     	(x1..x2).each{|x|
        	draw_plot(steep ? y : x, steep ? x : y)
     		error -= deltay
        	if 2 * error >= deltax
				y += ystep
				error += deltax
            end
        }
	end

	def _draw_line_wu(x1,y1,x2,y2,color);end
end