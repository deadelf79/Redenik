# encoding utf-8

class Redenik::GameManager::Screen_Title < Redenik::GameManager::Screen_Menu_Base
	def initialize(*args)
		super(*args)
		@screen_offset = {
			x:0,
			y:Graphics.height-624
		}
	end

	def create___all_pictures
		create___background
		create___game_title
	end

	def create___all_windows
		create___title_window
	end

	def create___background
		screen_heights = [
			624,
			768,
			1024,
			1080,
			1200,
			1400
		]
		current_height = 0

		screen_heights.each do |height|
			if height == Graphics.height
				current_height = height
			else
				current_height = 768
			end
		end

		backs = ["man","knight"]
		#@background = Redenik::Graphics::Cache.load_image('Gfx/Titles/',"background_#{backs.sample}_#{current_height}")
		@background = Redenik::Graphics::Cache.load_image('Gfx/Titles/',"background_#{backs.sample}")

		@background.x = Graphics.width - @background.width
		@background.y = Graphics.height - @background.height
	end

	def create___game_title
		@game_title = Redenik::Graphics::Cache.load_image('Gfx/Titles/','game_title')

		@game_title.x = @screen_offset[:x]
		@game_title.y = @screen_offset[:y]
	end

	def create___title_window
		@title_window = Redenik::Graphics::Window.new(
			@screen_offset[:x] + 32,
			@screen_offset[:y] + 375,
			208,
			108
		)
		with @title_window do
			add_button( Redenik::Translation::Russian::SCREENS[:title][:new_game],		:fire___new_game )
			add_button( Redenik::Translation::Russian::SCREENS[:title][:load_game],		:fire___load_game )
			add_button( Redenik::Translation::Russian::SCREENS[:title][:settings],		:fire___settings )
			add_button( Redenik::Translation::Russian::SCREENS[:title][:achievements],	:fire___achievements )
			add_button( Redenik::Translation::Russian::SCREENS[:title][:statistics],	:fire___statistics )
			add_button( Redenik::Translation::Russian::SCREENS[:title][:quit],			:fire___quit_game )
			activate
		end
		@title_window.z = 1
		@title_window.refresh
	end

	def update
		super
		@title_window.update
	end

	def fire___ok
		index = @title_window.index
		send(@title_window.list[index][:method]) if @title_window.list[index][:enabled]
	end

	def fire___cancel
		fire___quit_game
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

	def fire___achievements
		Redenik::GameManager::call(Redenik::GameManager::Screen_Achievements)
	end

	def fire___statistics
		Redenik::GameManager::call(Redenik::GameManager::Screen_Statistics)
	end

	def fire___quit_game
		Redenik::GameManager::call(Redenik::GameManager::Screen_Quit)
	end
end