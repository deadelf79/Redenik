# encoding utf-8

class Redenik::GameManager::Screen_Title < Redenik::GameManager::Screen_Menu_Base
	def create___all_pictures
		create___background
		create___game_title
	end

	def create___all_windows
		create___title_window
	end

	def create___background
		@background = Redenik::Graphics::Cache.load_bitmap('Gfx/Titles/','background')
	end

	def create___game_title
		@game_title = Redenik::Graphics::Cache.load_bitmap('Gfx/Titles/','game_title')
	end

	def create___title_window
		@title_window = Redenik::Graphics::Window.new(
			Graphics.width/2 - 96,
			Graphics.height - 200,
			192,
			192
		)
		with @title_window do
			add_button("New game",:fire___new_game)
		end
		@title_window.refresh
	end

	def fire___new_game
		Redenik::GameManager::call(Redenik::GameManager::Screen_New)
	end

	def fire___load_game
		Redenik::GameManager::call(Redenik::GameManager::Screen_Load)
	end

	def fire___settings
		Redenik::GameManager::call(Redenik::GameManager::Screen_Settings)
	end

	def fire___achivements
		Redenik::GameManager::call(Redenik::GameManager::Screen_Achievements)
	end

	def fire___statistics
		Redenik::GameManager::call(Redenik::GameManager::Screen_Statistics)
	end

	def fire___quit_game
		Redenik::GameManager::call(Redenik::GameManager::Screen_Quit)
	end
end