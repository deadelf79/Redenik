# encoding utf-8

module Redenik
	class << self
		START___MAX_ACTORS = 30
		STATS___CLASSES = [
			{:class_name=>:citizen,		:st=>10,	:dx=>10,	:iq=>10,	:ht=>10},
			{:class_name=>:warrior,		:st=>12,	:dx=>9,		:iq=>8,		:ht=>11},
			{:class_name=>:mage,		:st=>8,		:dx=>8,		:iq=>12,	:ht=>10},
			{:class_name=>:thief,		:st=>8,		:dx=>13,	:iq=>11,	:ht=>8}
		]

		attr_reader :game_actors, :game_items, :game_weapons, :game_armors
		attr_reader :game_skills

		def start_game
			# Подготовим переменные
			@game_actors 	= []
			@game_items 	= []
			@game_weapons 	= []
			@game_armors 	= []
			@game_skills	= []
			# Вызовем методы
			_gen_actors
			_gen_items
			_gen_weapons
			_gen_armors
			_gen_skills
		end

		private
		def _gen_actors
			new_level = 0
			START___MAX_ACTORS.times{|index|
				rand_class = STATS___CLASSES[STATS___CLASSES.keys.sample]
				@game_actors << Redenik::Actor.new(
					Redenik::NameGen.make_name(3,4),									# NAME
					rand_class[:class_name],											# APPEARANCE
					[rand_class[:st],rand_class[:dx],rand_class[:iq],rand_class[:ht]],	# STATS
					[],																	# EQUIPS
					new_level+=(index.to_f/6).to_i+1 									# LEVEL
				)
			}
		end

		def _gen_items

		end

		def _gen_weapons

		end

		def _gen_armors

		end

		def _gen_skills

		end
	end
end