# encoding utf-8

module Redenik
	class << self
		attr_reader :game_actors, :game_items, :game_weapons, :game_armors
		attr_reader :game_skills, :game_party, :game_maps, :current_map

		def start_game(user_actor={})
			# Подготовим переменные
			@game_actors 	= []
			@game_items 	= []
			@game_weapons 	= []
			@game_armors 	= []
			@game_skills	= []
			@game_party		= []
			@game_maps 		= []
			@player_id		= {
				:actor_id => 0,
				:party_id => 0
			}
			@player_actor	= nil
			@current_map = 0

			# Вызовем методы
			_gen_actors(_check_usac(user_actor))
			_gen_items
			_gen_weapons
			_gen_armors
			_gen_skills
			_gen_game_maps

			add_party_member(0)

			wr [
				@game_actors,
				@game_items,
				@game_weapons,
				@game_armors,
				@game_skill,
				@game_party,
				@game_maps
			]
		end

		def main_game
			end_game if party_dead?
			_change_player(next_member) if @game_party[@player_id[:party_id]].dead?
		end
		
		def end_game;end
		
		def add_party_member(id)
			unless @game_party.include?(@game_actors[id])
				@game_party << @game_actors[id]
			end
			if id==@player_id[:actor_id]
				_change_player id
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

		def joypad_enabled?
			@joypad = true if @joypad.nil?
			@joypad
		end

		def joypad(enable)
			@joypad = enable
		end

		def player
			@game_party[@player_id[:party_id]]
		end

		def next_member
			@game_party.each{|member|
				next if member.dead?
				next_id = @game_party.index(member)
			}
			next_id
		end

		private

		def _check_usac(user_actor)
			user_actor = {} unless user_actor.is_a? Hash
			user_actor[:name] = "NONAME" if user_actor[:name].nil?
			user_actor[:class_name] = "Citizen" if user_actor[:class_name].nil?
			user_actor[:st] = 10 if user_actor[:st].nil?
			user_actor[:dx] = 10 if user_actor[:dx].nil?
			user_actor[:iq] = 10 if user_actor[:iq].nil?
			user_actor[:ht] = 10 if user_actor[:ht].nil?
			user_actor[:cr] = 10 if user_actor[:cr].nil?
			user_actor
		end

		def _gen_actors(valid_user_actor)
			new_level = 0
			Redenik::Balance::START___MAX_ACTORS.times{|index|
				rand_class = Redenik::Balance::STATS___CLASSES.sample
				@game_actors << Redenik::Actor.new(
					Redenik::NameGen.make_name(3,4),													# NAME
					rand_class[:class_name],															# APPEARANCE
					[rand_class[:st],rand_class[:dx],rand_class[:iq],rand_class[:ht],rand_class[:cr]],	# STATS
					[],																					# EQUIPS
					new_level+=(index.to_f/6).to_i+1 													# LEVEL
				)
			}
		end

		def _gen_items
			sum = 0
			Redenik::Balance::ITEMS.each_value{|value|sum+=value}
			offset = 0
			Redenik::Balance::ITEMS.each{|key,value|
				for index in offset...((value.to_f/sum)*Redenik::Balance::START___MAX_ITEMS).to_i
					@game_items << Redenik::Item.new(
						Redenik::NameGen.make_name(2,3),
						[key],
						[:common,:uncommon,:rare].sample,
						[:eat,:drink,:absorb,:adopt].sample
					)
					# эта проверка нужна здесь только потому,
					# что я еще не закончил с добалением строк для всех эффектов
					if Redenik::Translation::Russian::ITEM_DESC[key]!=nil
						@game_items.last.help_info = format(
								Redenik::Translation::Russian::ITEM_DESC[key].sample,
								case @game_items.last.rarity
								when :common
									Redenik::Translation::Russian::EFFECT_STR[:low].sample
								when :uncommon
									Redenik::Translation::Russian::EFFECT_STR[:medium].sample
								when :rare
									Redenik::Translation::Russian::EFFECT_STR[:hard].sample
								end
						)
					end
					rarity = 0
					case @game_items.last.rarity
					when :uncommon
						rarity = 50
					when :rare
						rarity = 100
					end
					@game_items.last.price = Redenik::Balance::ITEM_COSTS[key] + rarity
				end
				offset = ((value.to_f/sum)*Redenik::Balance::START___MAX_ITEMS).to_i
			}
		end

		def _gen_weapons

		end

		def _gen_armors

		end

		def _gen_skills

		end

		def _gen_game_maps
			@game_maps[0] = {}
			@game_maps[0][:map] = Redenik::Graphics::Static_Map.new(0, 'testmap')
			@game_maps[0][:tilemap] = Redenik::Graphics::Tilemap.new(@game_maps[0][:map], 'walls')
			#for index in 1...100
				# gen other maps
			#end
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