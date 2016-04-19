# encoding utf-8

class Redenik::Graphics::Mouse
	def initialize
		@bitmap = Bitmap.new("gfx/pointersets/blackpointerset")
		@image = Sprite.new
		@image.z = 10000
		@image.bitmap = Bitmap.new(32,32)
		normal
	end

	def update
		pos = Mouse.pos
		@image.x = pos[0]
		@image.y = pos[1]
	end

	def normal
		@image.ox = 0
		@image.oy = 0
		@image.bitmap.clear
		rect = Rect.new(0,0,32,32)
		@image.bitmap.blt(0,0,@bitmap,rect)
	end

	def attack
		@image.ox = 3
		@image.oy = 3
		@image.bitmap.clear
		rect = Rect.new(32,0,32,32)
		@image.bitmap.blt(0,0,@bitmap,rect)
	end

	def look
		@image.ox = 0
		@image.oy = 0
		@image.bitmap.clear
		rect = Rect.new(64,0,32,32)
		@image.bitmap.blt(0,0,@bitmap,rect)
	end

	def talk
		@image.ox = 0
		@image.oy = 0
		@image.bitmap.clear
		rect = Rect.new(96,0,32,32)
		@image.bitmap.blt(0,0,@bitmap,rect)
	end

	def door
		@image.ox = 0
		@image.oy = 0
		@image.bitmap.clear
		rect = Rect.new(128,0,32,32)
		@image.bitmap.blt(0,0,@bitmap,rect)
	end

	def chest
		@image.ox = 0
		@image.oy = 0
		@image.bitmap.clear
		rect = Rect.new(160,0,32,32)
		@image.bitmap.blt(0,0,@bitmap,rect)
	end

	def url
		@image.ox = 0
		@image.oy = 0
		@image.bitmap.clear
		rect = Rect.new(192,0,32,32)
		@image.bitmap.blt(0,0,@bitmap,rect)
	end

	def cant
		@image.ox = 16
		@image.oy = 16
		@image.bitmap.clear
		rect = Rect.new(224,0,32,32)
		@image.bitmap.blt(0,0,@bitmap,rect)
	end

	def eat
		@image.ox = 0
		@image.oy = 0
		@image.bitmap.clear
		rect = Rect.new(256,0,32,32)
		@image.bitmap.blt(0,0,@bitmap,rect)
	end

	def drink
		@image.ox = 0
		@image.oy = 0
		@image.bitmap.clear
		rect = Rect.new(288,0,32,32)
		@image.bitmap.blt(0,0,@bitmap,rect)
	end

	def take
		@image.ox = 16
		@image.oy = 16
		@image.bitmap.clear
		rect = Rect.new(320,0,32,32)
		@image.bitmap.blt(0,0,@bitmap,rect)
	end

	def hold
		@image.ox = 16
		@image.oy = 16
		@image.bitmap.clear
		rect = Rect.new(352,0,32,32)
		@image.bitmap.blt(0,0,@bitmap,rect)
	end

	def text
		@image.ox = 2
		@image.oy = 9
		@image.bitmap.clear
		rect = Rect.new(384,0,32,32)
		@image.bitmap.blt(0,0,@bitmap,rect)
	end

	def wait
		@image.ox = 16
		@image.oy = 16
		@image.bitmap.clear
		rect = Rect.new(416,0,32,32)
		@image.bitmap.blt(0,0,@bitmap,rect)
	end
end