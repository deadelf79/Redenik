# encoding utf-8

class Redenik::GameManager::Screen_Base
	def initialize(timer)
		@creation_time = 0
		create___all_windows
		create___all_pictures

		@screen_offset = {x:0,y:0}
		_make_timer(timer)
	end

	def update
		update_basics
	end

	def update_basics
		update_gfx
		update_input
	end

	def update_gfx
		Graphics.update
	end

	def update_input
		Redenik.joypad_enabled? ? Input.update : Keys.update
	end

	def dispose
		dispose___all_windows
		dispose___all_pictures
	end

	def create___all_windows
		#
	end

	def create___all_pictures
		#
	end

	def dispose___all_windows
		self.instance_variables.each{|var|
			var.dispose if var.is_a? Redenik::Graphics::Window
		}
	end

	def dispose___all_pictures
		self.instance_variables.each{|var|
			var.dispose if var.is_a? Redenik::Graphics::Image
			var.dispose if var.is_a? Bitmap
			var.dispose if var.is_a? Sprite
			var.dispose if var.is_a? Plane
		}
	end

	def creation_time
		@creation_time
	end

	private

	def _make_timer(timer)
		@creation_time = Time.now.to_i - timer.to_i
	end
end