class Redenik::Graphics::Widget_Health < Redenik::Graphics::UI_Component
	def initialize( x, y )
		super( x, y, 196, 96 )

		player = Redenik.player
		@health, @max_health = player.health, player.max_health
		@mana, @max_mana = player.mana, player.max_mana
		@hungriness = layer.hungriness

		@window = Redenik::Graphics::Image.new( 0, 0, 200, 114, @main_viewport )
		@window.copy = Bitmap.new('Gfx/Windows/Widget_Health')

		@canvas = Redenik::Graphics::Image.new( 4, 4, width, height, @main_viewport )
		refresh
	end

	def refresh
		_draw_all
	end

	private
	def _draw_all
		return if Redenik.party_dead?
		player = Redenik.player
		# health bar
		if @health != player.health
			var_max = player.max_health
			var_health = player.health / var_max * 100
			var_percent = 150 * var_health / 100

			rect = Rect.new(33, 28, var_percent, 21)
			@canvas.clear_rect(33, 28, 150, 21)
			@canvas.draw_rect( rect, @canvas.red(true) )
			@health = player.health
		end

		# mana bar
		if @mana != player.mana
			var_max = player.max_mana
			var_mana = player.mana / var_max * 100
			var_percent = 150 * var_mana / 100

			rect = Rect.new(33, 28, var_percent, 21)
			@canvas.clear_rect(33, 52, 150, 21)
			@canvas.draw_rect( rect, @canvas.red(true) )
			@health = player.health
		end

		# hungriness bar
		# if @health != player.health
		# 	var_max = player.max_health
		# 	var_health = player.health / var_max * 100
		# 	var_percent = 150 * var_health / 100

		# 	rect = Rect.new(33, 28, var_percent, 21)
		# 	@canvas.clear_rect(33, 28, 150, 21)
		# 	@canvas.draw_rect( rect, @canvas.red(true) )
		# 	@health = player.health
		# end
	end
end