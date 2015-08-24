# encoding utf-8

class Redenik::Graphics::Image < Sprite
	def initialize(*args)

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
			draw_line(rect.x,rect.y,rect.width,rect.y)
			# Низ
			draw_line(rect.x,rect.height,rect.width,rect.height)
			# Лево
			draw_line(rect.x,rect.y,rect.width,rect.y)
			# Право
			draw_line(rect.x,rect.y,rect.width,rect.y)
		end
	end

	def draw_text(rect,text,color,horizontal_align=0,vertical_align=0)
		@data.bitmap.
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

	private

	def _swap(v1,v2)
		[v2,v1]
	end

	def _draw_line_bresenham(x1,y1,x2,y2,color)
		# За код на C#, с которого я переписывал,
		# спасибо BasmanovDaniil
		# Оригинальная статья: http://habrahabr.ru/post/185086/
		steep = (y2-y1).abs > (x2-x1).abs
		steep ? x1,y1 = _swap(x1,y1) : x2,y2 = _swap(x2,y2)
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