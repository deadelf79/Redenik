# encoding utf-8

class Redenik::GameManager::Screen_New < Redenik::GameManager::Screen_Menu_Base
	def create___all_pictures
		create___background
		create___game_start
		create___classes
		create___buttons
	end

	def create___all_windows
		create___game_new_window
		create___game_input_name
		create___game_start_window
	end

	def create___background
		@background = Plane.new
		@background.bitmap = Bitmap.new("Gfx/Planes/retrolines")
		@background.z = 100
	end

	def create___game_start
		@game_start = Redenik::Graphics::Cache.load_image('Gfx/Titles/','game_start')
		@game_start.z = 101
	end

	def create___classes

	end

	def create___buttons

	end

	def create___game_new_window
		# основное окно с классами, статами и прочим
	end

	def create___game_input_name
		Redenik::NameGen.prepare
		@input_name = Redenik::Graphics::InputBox.new( 352, 196, 216, 24, Redenik::NameGen.make_name( 3, 4 ) )
		@input_name.z = 110
	end

	def create___game_start_window
		# окно с выбором "начать новую / отмена"
	end

	def update
		super
		if @input_name.is_active?
			Redenik.joypad(false)
			@input_name.update
		else
			Redenik.joypad(true)
		end
	end

	def fire___ok
		Input.update
		if !@input_name.edit_now?
			@input_name.activate
			@input_name.begin_edit
		else
			@input_name.end_edit
			@input_name.deactivate
		end
	end

	def fire___cancel
		if !@input_name.edit_now?
			super
		else
			@input_name.end_edit
			@input_name.deactivate
		end
	end

	def fire___change_name;end
	def fire___change_class;end
	def fire___change_stat(stat);end
	def fire___start_game;end
end