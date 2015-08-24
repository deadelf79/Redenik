# encoding utf-8

module Redenik
	class << self
		attr_reader :game_actors, :game_items, :game_weapons, :game_armors

		def start_game
			# Подготовим переменные
			@game_actors 	= []
			@game_items 	= []
			@game_weapons 	= []
			@game_armors 	= []
			# Вызовем методы
			_gen_actors
			_gen_items
			_gen_weapons
			_gen_armors
		end

		private
		def _gen_actors;end
		def _gen_items;end
		def _gen_weapons;end
		def _gen_armors;end
	end
end