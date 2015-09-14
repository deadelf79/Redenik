# encoding utf-8

module Redenik
	class << self
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
			@player_id		= {
				:actor_id => 0,
				:party_id => 0
			}
			@player_actor	= nil
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
			_change_player(next_member) if @game_party[@player_id[:party_id]].dead?
		end
		
		def end_game;end
		
		def add_party_member(id)
			unless @game_party.inlcude?(@game_actors[id])
				@game_party << @game_actors[id]
			end
			if id==@player_id[:actor_id]
				_change_player
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
			Redenik::Balance::START___MAX_ACTORS.times{|index|
				rand_class = Redenik::Balance::STATS___CLASSES[
					Redenik::Balance::STATS___CLASSES.keys.sample
				]
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
				for index in offset...((value.to_f/sum)*Redenik::Balance::START___MAX_ITEMS).to_i
					@game_items << Redenik::Actor.new(
						Redenik::NameGen.make_name(2,3),
						[key],
						[:common,:uncommon,:rare].sample,
						[:eat,:drink,:absorb,:adopt].sample
					)
					# эта проверка нужна здесь только потому,
					# что я еще не закончил с добалением строк для всех эффектов
					if Redenik::Translation::Russian.ITEM_DESC[key]!=nil
						@game_items.last.help_info =
						format(
								Redenik::Translation::Russian.ITEM_DESC[key].sample,
								case @game_items.last.rarity
								when :common
									Redenik::Translation::Russian.EFFECT_STR[:low].sample
								when :uncommon
									Redenik::Translation::Russian.EFFECT_STR[:medium].sample
								when :rare
									Redenik::Translation::Russian.EFFECT_STR[:hard].sample
								end
						)
					end
					@game_items.last.price = Redenik::Balance.ITEM_COSTS[key]+
					(@game_items.last.rarity)
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

		def _change_player(new_id)
			if !@game_party[new_id].nil?
				@player_actor = @game_party[new_id]
				@player_id[:party_id]=new_id
				@player_id[:actor_id]=@game_actors.index(@game_party[new_id])
			end
		end
	end
end