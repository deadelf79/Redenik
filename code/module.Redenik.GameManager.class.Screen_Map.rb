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
		create___ingame_messagebox
		create___ingame_hud_name
		create___ingame_hud_hp
		create___ingame_hud_mp
		create___ingame_hud_exp
		create___ingame_hud_current_weapon
		create___ingame_hud_current_armor
		create___ingame_hud_popup_list
	end

	def create___map
		@map = Redenik.game_maps[Redenik.current_map]
	end

	def create___all_events;end
	def create___ingame_messagebox;end
	def create___ingame_hud_name;end
	def create___ingame_hud_hp;end
	def create___ingame_hud_mp;end
	def create___ingame_hud_exp;end
	def create___ingame_hud_current_weapon;end
	def create___ingame_hud_current_armor;end
	def create___ingame_hud_popup_list;end

	private

	def _save_changes
		@map.save_changes
	end
end