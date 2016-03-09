# encoding utf-8

class Redenik::Graphics::Widget_Health < Redenik::Graphics::UI_Component
	def initialize( x, y )
		super( x, y, 200, 114 )

		@player = Redenik.player
		@health, @max_health = 0, 0 #@player.health, @player.max_health
		@mana, @max_mana = 0, 0 #@player.mana, @player.max_mana
		@hungriness = -1 #@player.hungriness
		@medkits = -1 #@player.medkits.size

		@window = Redenik::Graphics::Image.new( 0, 0, 200, 114, @main_viewport )
		@window.copy Bitmap.new('Gfx/Windows/Widget_Health')

		@canvas = Redenik::Graphics::Image.new( 4, 4, width, height, @main_viewport )
		refresh
	end

	def refresh
		@player = Redenik.player
		_draw_all
	end

	private
	def _draw_all
		return if Redenik.party_dead?
		return if @player.nil?

		#wrt @player

		@canvas.font.size = 26
		@canvas.font.name = [ "Viner Hand ITC" ]
		@canvas.font.outline = true
		@canvas.font.out_color = Color.new(0,0,0,200)

		# health bar
		if @health != @player.health
			var_max = @player.max_health
			var_health = @player.health / var_max * 100
			var_percent = 150 * var_health / 100

			rect = Rect.new(33, 28, var_percent, 21)
			@canvas.clear_rect(Rect.new(33, 28, 150, 21))
			@canvas.draw_rect( rect, @canvas.red( true ) )
			rect = Rect.new(35, 30, var_percent-4, 17)
			@canvas.draw_rect( rect, @canvas.red( false ), false )

			rect = Rect.new(33, 28, 150, 21)
			@canvas.draw_text( rect, "#{@player.health}/#{@player.max_health}", @canvas.white, 1 )

			@health = @player.health
		end

		# mana bar
		if @mana != @player.mana
			var_max = @player.max_mana
			var_mana = @player.mana / var_max * 100
			var_percent = 150 * var_mana / 100

			rect = Rect.new(33, 52, var_percent, 21)
			@canvas.clear_rect(Rect.new(33, 52, 150, 21))
			@canvas.draw_rect( rect, @canvas.blue( true ) )
			rect = Rect.new(35, 54, var_percent-4, 17)
			@canvas.draw_rect( rect, @canvas.blue( false ), false )

			rect = Rect.new(33, 52, 150, 21)
			@canvas.draw_text( rect, "#{@player.mana}/#{@player.max_mana}", @canvas.white, 1 )

			@mana = @player.mana
		end

		# hungriness bar
		if @hungriness != @player.hungriness
			wrt @player.hungriness
			var_max = @player.max_hungriness
			var_hungriness = @player.hungriness / var_max * 100
			var_percent = 150 * var_hungriness / 100

			rect = Rect.new(33, 76, var_percent, 21)
			@canvas.clear_rect(Rect.new(33, 76, 150, 21))
			@canvas.draw_rect( rect, @canvas.green( true ) )

			rect = Rect.new(33, 76, 150, 21)
			@canvas.draw_text( rect, "#{@player.hungriness}/#{@player.max_hungriness}", @canvas.white, 1 )

			@hungriness = @player.hungriness
		end

		# med kit bar
		if @medkits != @player.medkits.size
			if @medkits < @player.medkits.size
				@medkits += 1
			else
				@medkits -= 1
			end

			@canvas.font.size = 24
			rect = Rect.new(40,0,41,16)
			@canvas.clear_rect(Rect.new(44,4,41,16))
			@canvas.draw_text( rect, @medkits, @canvas.white, 1 )
		end
	end
end