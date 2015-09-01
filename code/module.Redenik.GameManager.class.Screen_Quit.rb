# encoding utf-8

class Redenik::GameManager::Screen_Quit < Redenik::GameManager::Scene_Menu_Base
	def create___all_windows
		create___quit_window
	end

	def create___quit_window
		@quit_window = Redenik::Graphics::Window.new(
			Graphics.width/2 - 96,
			Graphics.height/2 - 96,
			192,
			192
		)
	end
end