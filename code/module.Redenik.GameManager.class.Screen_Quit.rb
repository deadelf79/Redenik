# encoding utf-8

class Redenik::GameManager::Screen_Quit < Redenik::GameManager::Screen_Menu_Base
	def create___all_pictures
		create___background
		create___game_quit
	end

	def create___all_windows
		create___quit_window
		create___quit_label
	end

	def create___background
		@background = Plane.new
		@background.bitmap = Bitmap.new("Gfx/Planes/retrolines")
		@background.z = 100
	end

	def create___game_quit
		@game_exit = Redenik::Graphics::Cache.load_image('Gfx/Titles/','game_exit')
		@game_exit.z = 101
	end

	def create___quit_window
		@quit_window = Redenik::Graphics::Window.new(
			310,
			312,
			192,
			64
		)
		with @quit_window do
			add_button( Redenik::Translation::Russian::SCREENS[:quit][:no],  :fire___no )
			add_button( Redenik::Translation::Russian::SCREENS[:quit][:yes], :fire___yes )
			activate
		end
		@quit_window.z = 102
		@quit_window.refresh
	end

	def create___quit_label
		@quit_label = Redenik::Graphics::Label.new(
			310,
			262,
			192,
			64
		)
		@quit_label.z = 103
		@quit_label.text( Redenik::Translation::Russian::SCREENS[:quit][:question] )
	end

	def update
		super
		@quit_window.update
	end

	def fire___ok
		index = @quit_window.index
		send(@quit_window.list[index][:method]) if @quit_window.list[index][:enabled]
	end

	def fire___yes
		Redenik::GameManager.quit
	end

	def fire___no
		Redenik::GameManager.cancel
	end
end