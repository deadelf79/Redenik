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
		create___widget_history
		create___widget_health
		create___widget_equipment
		create___widget_quick
		create___widget_mapquest
	end

	def create___map
		@map = Redenik.game_maps[Redenik.current_map][:tilemap]

		Redenik.message_stack.push "Приветствуем вас в мире Рэдэник!"
	end

	def create___all_events
		# вообще, их нужно бы загружать, но так как я ленивая задница,
		# то пока что расставлю всё как могу
		@events = []
		@player_event_id = -1
		@events.push Redenik::Graphics::Event.new
		@events.last.associate_with_actor Redenik.player
	end

	def create___widget_history
		@widget_history = Redenik::Graphics::Widget_History.new(
			4, 4
		)
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
			Graphics.height - 74 - 4
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