#encoding utf-8
class Redenik::GameManager::Screen_Map < Redenik::GameManager::Screen_Base
	def initialize(timer)
		@creation_time = 0
		@screen_offset = {x:0,y:0}
		create___all_windows
		create___all_pictures
		create___map
		create___all_events
		_make_timer(timer)
	end

	def create___all_windows
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
		@widget_health = Redenik::Graphics::Widget_Health.new(
			4,
			Graphics.height - 114 - 4
		)
	end

	def create___widget_equipment

	end

	def create___widget_quick
		@widget_quick = Redenik::Graphics::Widget_QuickInventory.new( 
			Graphics.width/2 - 161,
			Graphics.height - 54 - 4
		)
	end

	def create___widget_mapquest

	end

	def update
		super
		Redenik::GameManager.debug_canvas.clear
		Redenik::GameManager.debug_canvas.draw_text(
			Rect.new(
				Graphics.width-128,
				0,
				128,
				24
			),
			(Graphics.frame_count/Graphics.frame_rate).to_s,
			Color.new(255,0,0)
		)
	end

	private

	def _save_changes
		@map.save_changes
	end
end