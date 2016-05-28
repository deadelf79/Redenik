# encoding utf-8

module Redenik
	class << self
		attr_reader :game_actors, :game_items, :game_weapons, :game_armors
		attr_reader :game_skills, :game_party, :game_maps, :current_map
		attr_accessor :message_stack

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

			@seed_is_valera = false
			@game_seed = 0x1E240 #dec: 123456
			@game_random = Random.new(@game_seed)
			self.game_seed = user_actor[:name] unless user_actor[:name].nil?
			@name_of_the_game = user_actor[:name]

			@message_stack = []
			@statistics = {
				total_gold_collected: 			0,
				total_alchemy_recepy_found: 	0,
				total_books_readed: 			0,
				deepest_gate: 					:a,
				deepest_floor: 					1,
				total_friend_count:				0,
				total_sex_actions: 				0,
				total_sex_partners: 			0,
				total_gametime_played: 			0,
				most_played_actor: 				"",
				most_played_actor_time: 		0,
				most_lovely_weapon: 			"",
				best_guild_rank: 				:none
			}

			@user_setup_directory	= "./"
			@user_save_directory 	= "./_SaveGameData"
			@user_mod_directory 	= "./_UserMods"

			# Вызовем методы
			Redenik::NameGen.prepare
			_make_setup_dir
			_make_save_dir
			_make_mod_dir
			_make_default_settings
			_gen_actors(_check_usac(user_actor))
			_gen_items
			_gen_weapons
			_gen_armors
			_gen_skills
			_gen_game_maps

			add_party_member(0)
			save_game
		end

		def main_game
			end_game if party_dead?
			_change_player(next_member) if @game_party[@player_id[:party_id]].dead?
		end
		
		def end_game	
			dump = {
				dead:true,
				name_of_the_game:@name_of_the_game,
				game_party:@game_party
			}
			@statistics.each_key{ |key|
				dump[key] = @statistics[key]
			}

			player_dir_name = ""
			temp_string = @game_seed.to_s
			for index in 0...[256,temp_string.size].min
				player_dir_name += temp_string[index]
			end
			save_data(
				dump,
				"#{@user_save_directory}/#{player_dir_name}/world.dump"
			)
			wr "Dead game data was saved to '#{@user_save_directory}/#{player_dir_name}'"
		end

		def save_game
			dump = {
				dead:false,
				name_of_the_game:@name_of_the_game,
				game_actors:@game_actors,
				game_items:@game_items,
				game_weapons:@game_weapons,
				game_armors:@game_armors,
				game_skill:@game_skill,
				game_party:@game_party,
				game_maps:@game_maps
			}
			Dir.mkdir("#{@user_save_directory}") unless Dir.exist?("#{@user_save_directory}")
			player_dir_name = ""
			temp_string = @game_seed.to_s
			for index in 0...[256,temp_string.size].min
				player_dir_name += temp_string[index]
			end

			Dir.mkdir("#{@user_save_directory}/#{player_dir_name}") unless Dir.exist?("#{@user_save_directory}/#{player_dir_name}")
			save_data(
				dump,
				"#{@user_save_directory}/#{player_dir_name}/world.dump"
			)
			wr "Current game data was saved to '#{@user_save_directory}/#{player_dir_name}'"
		end

		def change_statistics(type,value)
			@statistics[type]+=[value,0].max
		end
		
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
			wr "Joypad is now #{enable ? "enabled" : "disabled"}"
			@joypad = enable
		end

		def game_seed
			return :valera if @seed_is_valera
			return @game_seed
		end

		def game_seed=(actor_name)
			if actor_name=~/Валер(?:а|ий)|Valer(?:a|i[yi])/i
				@seed_is_valera = true
				@game_seed = rand(12345)
				@game_random = Random.new(@game_seed)
			else
				@seed_is_valera = false
				@game_seed = actor_name.bytes.join.to_i
				@game_random = Random.new(@game_seed)
			end
			wr "Valera, why?.." unless @seed_is_valera
			wr "New game seed is #{@game_seed}"
		end

		def player
			@game_party[@player_id[:party_id]]
		end

		def next_member
			next_id = -1
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
			# мне нужно генерировать актёров при помощи списка карт
			# а здесь генерируются только первые встречаемые нами неписи,
			# которые будут использованы для предыстории персонажа
			# в генераторе биографии

			string = open("Data/Names/ru.json","r").readlines.join
			json = JSON.decode(string)

			Redenik::Balance::START___MAX_ACTORS.times{|index|
				name = json["man"].sample
				rand_class = Redenik::Balance::STATS___CLASSES[
					@game_random.rand(Redenik::Balance::STATS___CLASSES.size)
				]
				@game_actors << Redenik::GameData::Actor.new(
					name,					# NAME
					rand_class[:class_name],# APPEARANCE
					{						# STATS
						st:rand_class[:st],
						dx:rand_class[:dx],
						iq:rand_class[:iq],
						ht:rand_class[:ht],
						cr:rand_class[:cr]
					},
					1						# LEVEL
				)
			}
		end

		def _gen_items
			sum = 0
			Redenik::Balance::ITEMS.each_value{|value|sum+=value}
			offset = 0
			Redenik::Balance::ITEMS.each{|key,value|
				for index in offset...((value.to_f/sum)*Redenik::Balance::START___MAX_ITEMS).to_i
					@game_items << Redenik::GameData::Item.new(
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
			@game_maps[0][:map] = Redenik::Graphics::Static_Map.new(0, 'weapon_trader')
			@game_maps[0][:tilemap] = Redenik::Graphics::Tilemap.new(@game_maps[0][:map], 'walls')
			
			# вначале - туториалы

			#for index in 1...100
				# gen other maps
			#end
		end

		def _change_player(new_id)
			if new_id==-1
				wr ""
				return
			end
			if !@game_party[new_id].nil?
				@player_actor = @game_party[new_id]
				@player_id[:party_id]=new_id
				@player_id[:actor_id]=@game_actors.index(@game_party[new_id])
			else

			end
		end

		def _make_setup_dir
			if ($TEST||$DEBUG)
				@user_setup_directory = "./"
			else
				if RUBY_PLATFORM =~ /mingw/
					Dir.mkdir("#{ENV["HOME"]}/AppData/Roaming/DeadElf79")
					Dir.mkdir("#{ENV["HOME"]}/AppData/Roaming/DeadElf79/Redenik")
					@user_setup_directory = "#{ENV["HOME"]}/AppData/Roaming/DeadElf79/Redenik"
				elsif RUBY_PLATFORM =~ /linux/
					Dir.mkdir("./config/DeadElf79")
					Dir.mkdir("./config/DeadElf79/Redenik")
					@user_setup_directory = "./config/DeadElf79/Redenik"
				else
					raise 'Cannot read current OS!'
				end
			end
		end

		def _make_save_dir
			if ($TEST||$DEBUG)
				@user_save_directory = "./_SaveGameData"
			else
				if RUBY_PLATFORM =~ /mingw/
					Dir.mkdir("#{ENV["HOME"]}/AppData/Roaming/DeadElf79/Redenik/SaveGameData")
					@user_save_directory = "#{ENV["HOME"]}/AppData/Roaming/DeadElf79/Redenik/SaveGameData"
				elsif RUBY_PLATFORM =~ /linux/
					Dir.mkdir("./config/DeadElf79/Redenik/SaveGameData")
					@user_save_directory = "./config/DeadElf79/Redenik/SaveGameData"
				else
					raise 'Cannot read current OS!'
				end
			end
		end

		def _make_mod_dir
			if ($TEST||$DEBUG)
				@user_mod_directory = "./_UserMods"
			else
				if RUBY_PLATFORM =~ /mingw/
					Dir.mkdir("#{ENV["HOME"]}/AppData/Roaming/DeadElf79/Redenik/UserMods")
					@user_save_directory = "#{ENV["HOME"]}/AppData/Roaming/DeadElf79/Redenik/UserMods"
				elsif RUBY_PLATFORM =~ /linux/
					Dir.mkdir("./config/DeadElf79/Redenik/UserMods")
					@user_save_directory = "./config/DeadElf79/Redenik/UserMods"
				else
					raise 'Cannot read current OS!'
				end
			end
		end

		def _make_default_settings
			ini = IniFile.open("#{@user_setup_directory}/Redenik.ini")
			# GAME
			ini["Game","RTP"] 							= ""
			ini["Game","Library"] 						= "System\\RGSS301.dll"
			ini["Game","Scripts"] 						= "Data\\Scripts.rvdata2"
			ini["Game","Title"] 						= "Redenik"
			# GRAPHICS
			ini["Graphics","intWidth"] 					= "816"
			ini["Graphics","intHeight"] 				= "624"
			ini["Graphics","boolFullscreenStart"] 		= "false"
			# CONTROLS
			# keys
			ini["Controls", "boolEnableLetterHotkeys"] 	= "true"
			ini["Controls", "boolEnableMouseControl"] 	= "true"
			# menus
			ini["Controls", "MapMenu"] 					= "M"
			ini["Controls", "QuestMenu"] 				= "U"
			ini["Controls", "InventoryMenu"] 			= "I"
			ini["Controls", "StatusMenu"] 				= "J"
			ini["Controls", "EquipmentMenu"] 			= "O"
			ini["Controls", "MagicMenu"] 				= "K"
			ini["Controls", "AlchemyMenu"] 				= "L"
			# quick inventory
			ini["Controls", "QuickInventoryItem1" ] 	= "N0"
			ini["Controls", "QuickInventoryItem2" ] 	= "N1"
			ini["Controls", "QuickInventoryItem3" ] 	= "N2"
			ini["Controls", "QuickInventoryItem4" ] 	= "N3"
			ini["Controls", "QuickInventoryItem5" ] 	= "N4"
			ini["Controls", "QuickInventoryItem6" ] 	= "N5"
			ini["Controls", "QuickInventoryItem7" ] 	= "N6"
			ini["Controls", "QuickInventoryItem8" ] 	= "N7"
			ini["Controls", "QuickInventoryItem9" ] 	= "N8"
			ini["Controls", "QuickInventoryItem10"] 	= "N9"
			ini.save
		end
	end
end