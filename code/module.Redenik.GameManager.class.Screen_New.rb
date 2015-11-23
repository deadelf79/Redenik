# encoding utf-8

class Redenik::GameManager::Screen_New < Redenik::GameManager::Screen_Menu_Base
	def create___all_pictures
		create___background
		create___classes
		create___buttons
	end

	def create___all_windows
		create___game_new_window
		create___game_start_window
	end

	def create___background
		@background = Plane.new
		@background.bitmap = Bitmap.new("Gfx/Planes/retrolines")
		@background.z = 100
	end

	def create___classes

	end

	def create___buttons

	end

	def create___game_new_window
		# основное окно с классами, статами и прочим
	end

	def create___game_start_window
		# окно с выбором "начать новую / отмена"
	end

	def update
		super
	end

	def fire___change_name;end
	def fire___change_class;end
	def fire___change_stat(stat);end
	def fire___start_game;end
end