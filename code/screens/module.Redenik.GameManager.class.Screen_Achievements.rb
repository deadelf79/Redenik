#encoding utf-8

class Redenik::GameManager::Screen_Achievements < Redenik::GameManager::Screen_Menu_Base
	def initialize(*args)
		super(*args)
		@achis = {}
	end

	def create___all_pictures
		create___background
		create___game_achievements
	end

	def create___all_windows
		create___game_achi_window
	end

	def create___background
		@background = Plane.new
		@background.bitmap = Bitmap.new("Gfx/Planes/retrolines")
		@background.z = 100
	end

	def create___game_achievements
		@game_achievements = Redenik::Graphics::Cache.load_image('Gfx/Titles/','game_achievements')
		@game_achievements.z = 101
	end

	def create___game_achi_window
		_load_names
		@achi_window = Redenik::Graphics::Window.new(282,244,256,194)
		@achis.each_key{|achi|
			@achi_window.add_button(@achis[achi]["view"]["name"],:fire___show_achiv_desc)
		}
		@achi_window.activate
		@achi_window.z = 110
		@achi_window.refresh
	end

	def update
		super
		@achi_window.update
	end

	def fire___change_achiv_to_show(index)

	end

	def fire___show_achiv_desc(index)

	end

	private

	def _load_names
		string = open("data/achieve.json","r").readlines.join
		@achis = JSON.decode(string)
		@achis.shift
	end

	def _load_data

	end
end