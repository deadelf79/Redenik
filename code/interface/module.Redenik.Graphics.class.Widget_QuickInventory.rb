# encoding utf-8

class Redenik::Graphics::Widget_QuickInventory < Redenik::Graphics::UI_Component
	def initialize( x, y )
		super( x, y, 322, 74 )

		@player = Redenik.player
		@items = []
		(0...10).each{|index| @items[index] = nil }

		@window = Redenik::Graphics::Image.new( 0, 0, 322, 74, @main_viewport )
		@window.copy Bitmap.new('Gfx/Windows/Widget_QuickInventory')

		@canvas = Redenik::Graphics::Image.new( 4, 4, width - 8, height - 8, @main_viewport )
		refresh
	end

	def reset_x
		self.x = Graphics.width/2 - self.width/2
	end

	def refresh
		@player = Redenik.player
		_draw_all
	end
	
	private
	
	def _draw_all
		return if Redenik.party_dead?
		return if @player.nil?

		quick = @player.quick_inventory
		items = []
		(0...10).each{|index| items[index] = quick[index] }

		(0...10).each do |index|
			unless @items[index] == items
				@canvas.clear_rect( Rect.new( 13 + index * 30, 13, 24, 24 ) )
				next if @items[index].nil?
				next if @items[index].icon.nil?

				rect = Rect.new( 0, 0, 24, 24 )
				@canvas.blt( 13 + index * 30, 13, @items.icon, rect)
			end
		end
	end
end