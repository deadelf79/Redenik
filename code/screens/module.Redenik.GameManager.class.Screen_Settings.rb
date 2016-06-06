# encoding utf-8

class Redenik::GameManager::Screen_Settings < Redenik::GameManager::Screen_Menu_Base
	def initialize(*args)
		super(*args)
		@screen_offset = {
			x:Graphics.width/2,
			y:Graphics.height/2
		}
	end

	def create___all_pictures
		create___background
	end

	def create___background
		@background = Plane.new
		@background.bitmap = Bitmap.new("Gfx/Planes/retrolines")
		@background.z = 100
	end

	def create___all_windows
		create___setup_tab
		create___setup_graphics
		create___setup_audio
		create___setup_controls
		create___setup_game
	end

	def create___setup_tab
		width = 200
		height = 400
		x = @screen_offset[:x] - width/2
		y = @screen_offset[:y] - height/2
		@setup_tab = Redenik::Graphics::Window.new( x, y, width, height )
		with @setup_tab do
			add_button( Redenik::Translation::Russian::SCREENS[:settings][:graphics][:name],	:fire___setup_graphics )
			add_button( Redenik::Translation::Russian::SCREENS[:settings][:audio][:name],		:fire___setup_audio )
			add_button( Redenik::Translation::Russian::SCREENS[:settings][:controls][:name],	:fire___setup_controls )
			add_button( Redenik::Translation::Russian::SCREENS[:settings][:game][:name],		:fire___setup_game )
			self.columns = 4
			self.z = 110
			activate
			refresh
		end
	end

	def create___setup_graphics;end
	def create___setup_audio;end
	def create___setup_controls;end
	def create___setup_game;end

	def update
		super
		@setup_tab.update if @setup_tab.is_active?
	end

	def fire___setup_graphics
		@setup_tab.deactivate
	end

	def fire___setup_audio
		@setup_tab.deactivate
	end

	def fire___setup_controls
		@setup_tab.deactivate
	end

	def fire___setup_game
		@setup_tab.deactivate
	end

end