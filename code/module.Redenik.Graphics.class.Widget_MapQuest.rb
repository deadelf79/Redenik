#encoding utf-8
class Redenik::Graphics::Widget_MapQuest < Redenik::Graphics::UI_Component
	def initialize(x,y)
		w, h = 200,114
		@viewport = Viewport.new(x,y,w,h)
		@mapdata = Redenik::Graphics::Image.new(x+8,y+8,w-16,h-16,@viewport)
		@map = Redenik.game_maps[Redenik.current_map][:tilemap]
	end

	def refresh
		_draw_all
	end

	private

	def _draw_all
		@mapdata.clear
		for x in (0..@map.width)
			for y in (0..@map.height)
				chr = ""
				case @map[x,y]
				when 1; 	chr = "."
				when 2; 	chr = "\#"
				when 3; 	chr = "="
				when -5; 	chr = "c"
				when -11; 	chr = "■"
				when -13; 	chr = "▼"
				when -100; 	chr = "🚪"
				when -200; 	chr = "◻"
				end
				rect = Rect.new(
					x*16,
					y*16,
					16,
					16
				)
				@mapdata.font.name = "Arial"
				@mapdata.font.size = 16
				@mapdata.draw_text(rect,chr,@mapdata.white)
			end
		end
	end
end