# encoding utf-8

class Redenik::GameManager::Screen_Base
	def initialize(timer)
		timer
		create___all_windows
		create___all_pictures
		return Time.now - timer
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
		Input.update
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
		}
	end
end