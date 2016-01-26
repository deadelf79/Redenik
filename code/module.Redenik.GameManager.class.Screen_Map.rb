#encoding utf-8
class Redenik::GameManager::Screen_Map < Redenik::GameManager::Screen_Base
	def initialize(timer)
		@creation_time = 0
		create___all_windows
		create___all_pictures
		create___map
		create___all_events
		_make_timer(timer)
	end

	def create__all_windows
		create___widget_popup
		create___widget_health
		create___widget_equipment
		create___widget_quick
		create___widget_mapquest
	end

	def create___map
		@map = Redenik.game_maps[Redenik.current_map][:tilemap]
	end

	def create___widget_popup
		#
	end

	def create___widget_health

	end

	def create___widget_equipment

	end

	def create___widget_quick

	end

	def create___widget_mapquest

	end

	def update
		super
	end

	private

	def _save_changes
		@map.save_changes
	end
end