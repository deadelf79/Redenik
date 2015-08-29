# encoding utf-8

module Redenik
	class << self
		START___MAX_ACTORS 	= 30
		START___MAX_ITEMS	= 300
		START___MAX_ARMORS	= 900
		START___MAX_WEAPON	= 900

		STATS___CLASSES = [
			{:class_name=>:citizen,		:st=>10,	:dx=>10,	:iq=>10,	:ht=>10},
			{:class_name=>:warrior,		:st=>12,	:dx=>9,		:iq=>8,		:ht=>11},
			{:class_name=>:mage,		:st=>8,		:dx=>8,		:iq=>12,	:ht=>10},
			{:class_name=>:thief,		:st=>8,		:dx=>13,	:iq=>11,	:ht=>8}
		]

		attr_reader :game_actors, :game_items, :game_weapons, :game_armors
		attr_reader :game_skills, :game_party

		def start_game
			# Подготовим переменные
			@game_actors 	= []
			@game_items 	= []
			@game_weapons 	= []
			@game_armors 	= []
			@game_skills	= []
			@game_party		= []
			# Вызовем методы
			_gen_actors
			_gen_items
			_gen_weapons
			_gen_armors
			_gen_skills

			add_party_member(0)
		end

		def main_game
			end_game if party_dead?
			
		end
		
		def end_game;end
		
		def add_party_member(id)
			unless @game_party.inlcude?(@game_actors[id])
				@game_party << @game_actors[id]
			end
		end

		def party_dead?
			all = true
			@game_party.each{|actor|
				if !actor.dead?
					all=false
					break
				end
			}
			all
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
			sum = 0
			Redenik::Balance.ITEMS.each_value{|value|sum+=value}
			offset = 0
			Redenik::Balance.ITEMS.each{|key,value|
				for index in offset...((value.to_f/sum)*START___MAX_ITEMS).to_i
					@game_items << Redenik::Actor.new(
						Redenik::NameGen.make_name(2,3),
						[key],
						[:common,:uncommon,:rare].sample,
						[:eat,:drink,:absorb,:adopt].sample
					)
					if Redenik::Translation::Russian.ITEM_DESC[key]!=nil
						@game_items.last.help_info = format(Redenik::Translation::Russian.ITEM_DESC[key].sample,
							case @game_items.last.rarity
							when :common
								Redenik::Translation::Russian.EFFECT_STR[:low].sample
							when :uncommon
								Redenik::Translation::Russian.EFFECT_STR[:medium].sample
							when :rare
								Redenik::Translation::Russian.EFFECT_STR[:hard].sample
							end)
					end
				end
				offset = ((value.to_f/sum)*START___MAX_ITEMS).to_i
			}
		end

		def _gen_weapons

		end

		def _gen_armors

		end

		def _gen_skills

		end
	end
end