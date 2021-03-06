# = Redenik Game Engine (based on RGSS3)
# Полная документация по классам и модулям движка для игры Redenik
# Автор:: DeadElf79
# Исходный код:: https://github.com/deadelf79/Redenik

# Абстрактный модуль для хранения указателей
# на все функции встроенных в него классов
module Redenik
	class << self
		# [Массив данных обо всех персонажах в игре]
		# Самый первый персонаж в списке (под номером 0) - это персонаж,
		# который был создан игроком на экране создания персонажа.
		attr_reader :game_actors

		# [Массив данных обо всех предметах в игре]
		# Предметы генерируются по типам:
		# * Redenik::GameData::Item::Book
		# Только зелья имеют редкость и генерируются в соответствии с Redenik::Balance
		attr_reader :game_items

		# [Массив данных обо всем оружии в игре]
		# 
		attr_reader :game_weapons

		# [Массив данных обо всей броне в игре]
		# 
		attr_reader :game_armors

		# [Массив данных о команде]
		# Содержит набор ссылок на персонажей из массива @game_actors, с которыми
		# были установлены дружеские отношения и которые присоединились
		# к команде игрока.
		attr_reader :game_party

		# [Массив данных обо всех картах в игре]
		# 
		attr_reader :game_maps

		# Возвращает индекс текущей карты.
		attr_reader :current_map

		# [Стек сообщений]
		# В него записываются результаты всех произведенных игроком действий:
		# атаки противника, принятия пищи или зелий, покупки и продажи
		# предметов, получения и сдачи квестов и много другое.<br>
		# Все эти сообщения можно почитать в виджете стека сообщений на основном
		# внутриигровом экране.
		attr_accessor :message_stack

		# [Список имен книг]
		# Содержит список имен для всех книг, которые есть в игре. Список используется
		# при генерации новых книг из числа тех, у которых не оказалось собственного
		# имени (классы Redenik::GameData::Item::Book::Skillbook и Redenik::GameData::Item::Book::Magictome).
		attr_accessor :nameslist_books

		# Инициирует все данные перед стартом и запускает
		# переход на первую сцену (титульное меню по умолчанию)
		def start_game(user_actor={});end

		def main_game;end

		def end_game;end

		def save_game;end

		# 
		def change_statistics(type,value);end

		def add_party_member(id);end
		def party_dead?;end
		def player;end
		def next_member;end

		def joypad_enabled?;end
		def joypad(enable);end

		def game_seed;end
		def game_seed=(actor_name);end
		def game_start_generics;end

		private
		def _check_usac(user_actor);end
		def _gen_actors;end
		def _gen_items;end
		def _gen_weapons;end
		def _gen_armors;end
		def _gen_skills;end
		def _gen_game_maps;end
		def _change_player(new_id);end
		def _make_setup_dir;end
		def _make_save_dir;end
		def _make_mod_dir;end
		def _make_default_settings;end
	end

	module GameManager
		class << self
			# [Отладочный холст]
			# Необходим для отрисовки отладочной информации поверх всего остального
			attr_accessor :debug_canvas

			attr_accessor :pointer

			# 
			def start;end

			# 
			def main;end

			# 
			def quit;end

			# 
			def setup_first_scene;end

			# 
			def setup_scene(scene,*args);end

			# 
			def update_scene;end

			# 
			def dispose_scene;end

			# 
			def call(scene,*args);end

			# 
			def goto(scene,*args);end

			# 
			def cancel;end
		end

		module FlowStack
			def prepare;end
			def push(type,target,value);end
			def pop;end
			def update;end
		end

		module MapManager
			class << self
				def make_tutorial_map(player_class,stat);end

				private

				def _tutorial___warrior_st;end
				def _tutorial___warrior_dx;end
				def _tutorial___warrior_iq;end
				def _tutorial___warrior_ht;end
				def _tutorial___warrior_cr;end

				def _tutorial___mage_st;end
				def _tutorial___mage_dx;end
				def _tutorial___mage_iq;end
				def _tutorial___mage_ht;end
				def _tutorial___mage_cr;end

				def _tutorial___thief_st;end
				def _tutorial___thief_dx;end
				def _tutorial___thief_iq;end
				def _tutorial___thief_ht;end
				def _tutorial___thief_cr;end

				def _tutorial___trader_st;end
				def _tutorial___trader_dx;end
				def _tutorial___trader_iq;end
				def _tutorial___trader_ht;end
				def _tutorial___trader_cr;end

				def _tutorial___citizen_st;end
				def _tutorial___citizen_dx;end
				def _tutorial___citizen_iq;end
				def _tutorial___citizen_ht;end
				def _tutorial___citizen_cr;end
			end
		end

		class Screen_Base
			def initialize(timer,*args);end
			def update;end
			def update_basics;end
			def update_gfx;end
			def update_input;end
			def dispose;end
			def create___all_windows;end
			def create___all_pictures;end
			def dispose___all_windows;end
			def dispose___all_pictures;end
			def creation_time;end
			private
			def _make_timer(timer);end
		end

		class Screen_Menu_Base < Screen_Base
			def update;end
			def fire___ok;end
			def fire___cancel;end
		end

		class Screen_Title < Screen_Menu_Base
			def create___background;end
			def create___game_title;end
			def create___title_window;end
			def update;end
			def fire___new_game;end
			def fire___load_game;end
			def fire___settings;end
			def fire___achievements;end
			def fire___statistics;end
			def fire___quit_game;end
		end

		class Screen_New < Screen_Menu_Base
			def create___background;end
			def create___game_start;end
			def create___classes;end
			def create___buttons;end
			def create___select;end
			def create___game_choose_class;end
			def create___game_stat_st;end
			def create___game_stat_dx;end
			def create___game_stat_iq;end
			def create___game_stat_ht;end
			def create___game_stat_cr;end
			def create___game_start_window;end
			def create___game_input_name;end
			def create___game_help_window;end
			def create___game_stats_apportion;end
			def update;end
			def fire___start_game;end
			private
			def _set_stat(class_id_in_balance);end
			def _select_apportion(approtion_to_stats);end
			def _update_select;end
			def _update_apportion;end
			def _update_stats;end
			def _update_stats_complete?;end
			def _update_movement;end
		end

		class Screen_Load < Screen_Menu_Base
			def fire___check_load_file;end
			def fire___start_loaded_game;end
		end

		class Screen_Settings < Screen_Menu_Base
			def fire___change_sound_volume;end
			def fire___change_music_volume;end
			def fire___change_language;end
		end

		class Screen_Achievements < Screen_Menu_Base
			def create___background;end
			def create___game_achievements;end
			def create___game_achi_window;end
			def fire___change_achiv_to_show(index);end
			def fire___show_achiv_desc(index);end
		end

		class Screen_Statistics < Screen_Menu_Base
			#
		end

		class Screen_Quit < Screen_Menu_Base
			def create___background;end
			def create___game_quit;end
			def create___quit_window;end
			def create___quit_label;end
			def fire___yes;end
			def fire___no;end
		end

		class Screen_Map < Screen_Base
			def create___map;end
			def create___all_events;end
			def create___widget_history;end
			def create___widget_health;end
			def create___widget_equipment;end
			def create___widget_quick;end
			def create___widget_mapquest;end
			def create___dialog_background;end
			def create___dialog_window;end

			private

			def _save_changes;end
		end
	end

	module Time
		class << self
			def start;end
			def step;end
			def now;end

			def second;end
			def minute;end
			def hour;end
			def day;end
			def week;end
			def month;end
			def year;end
			def age;end
			def era;end
		end
	end

	module SteamManager
		class Achievement
			def initialize(hash);end
			def get?;end
			def get;end
		end
	end

	# Материнские классы, от которых наследуется большинство других
	module GameData
		class Basic
			attr_reader :name, :health, :mana, :effects, :max_health, :max_mana
			attr_reader :gold_modifier
			def initialize(health,mana,effects,gold_modifier);end
			
			# Проверка на смерть объекта
			def dead?;end
			
			# Првоерка, жив ли еще объект (здоровье должно
			# быть выше нуля)
			def alive?;end
			
			# Запускает постепенное восстановление здоровья 
			# => value - значение, на которое будет восстановлено текущее здоровье по прошествии времени
			def restore_health(value);end
			
			# Полностью восстанавливает здоровье единоразово
			def full_restore;end
			
			# Запускает постепенное восстановление маны
			# => value - значение, на которое будет восстановлено текущее количество маны по прошествии времени
			def restore_mana(value);end
			
			# Расходует ману, единоразово отнимая от текущего количество необходимое
			def use_mana(value);end

			# Проверяет, хватает ли маны на использование
			def enough_mana?(value);end
			
			# Обновляет объект
			def update;end
		end

		class BasicItem < Basic
			attr_accessor :rarity, :price, :icon, :weight
			attr_reader :help_info
			def initialize(health,mana,effects,rarity,start_price,type);end
			def help_info=(new_text);end	
			def icon;end
			def dispose;end
			def disposed?;end
			def use;end

			private

			def _load_icon_by_type;end
			def _gen_help_info;end
		end

		#
		class Person < Basic
			attr_reader :appearance, :stats
			attr_reader :exp, :level, :skills, :sex, :gender
			attr_reader :surname, :secondname
			attr_reader :hungriness, :feel_monsters, :feel_traps
			attr_reader :can_carry_weight
			def initialize(name,appearance,stats);end
			def reset_exp;end
			def exp_curve(level);end
			def recover;end

			# Сильный?
			def strong?;end
			
			# Слабый?
			def weak?;end
			
			# Умный?
			def smart?;end
			
			# Глупый?
			def stupid?;end
			
			# Проворный?
			def agile?;end
			
			# Неуклюжий?
			def clumsy?;end
			
			# Живучий?
			def survivable?;end

			# Нежизнеспособный?
			def unviable?;end

			# Очаровательный?
			def charming?;end
			
			# Грубый?
			def rough?;end

			private 

			def _check_hungry;end
			def _gen_actor_by_stats(stats);end
			def _reset_exp;end
			def _generate_exp_curve;end
		end

		# Специальный класс-прослойка для людей

		class DressingPerson < Person
			def initialize(name,appearance,stats,equips);end

			def torso;end
			def head;end
			def left_hand;end
			def right_hand;end
			def left_shoulder;end
			def right_shoulder;end
			def neck;end
			def left_greave;end # наголенник
			def right_greave;end
			def left_shoe;end
			def right_shoe;end

			def torso=(value);end
			def head=(value);end
			def left_hand=(value);end
			def right_hand=(value);end
			def left_shoulder=(value);end
			def right_shoulder=(value);end
			def neck=(value);end
			def left_greave=(value);end
			def right_greave=(value);end
			def left_shoe=(value);end
			def right_shoe=(value);end
		end

		# Игровые классы

		class Actor < DressingPerson
			def initialize(name,appearance,stats,equips,level);end
			
			# Gainers/Losers

			def gain_item(item,value);end
			def lose_item(item,value);end
			def gain_exp(value);end
			def set_quick_item(item,slot);end
			def remove_quick_item(slot);end

			# Skills & Magic

			def learn_skill(skill_id);end
			def forget_skill(skill_id);end
			def learn_magic(skill_id);end
			def forget_magic(skill_id);end
			def skill_level(skill_id);end
			def magic_level(skill_id);end
			def raise_skill_exp;end
			def raise_magic_exp;end
			def raise_skill_level(skill_id);end
			def raise_magic_level(skill_id);end
			def skill(skill_id);end
			def magic(skill_id);end

			# Возвращает массив из всех предметов, находящихся
			# в инвентаре
			def inventory;end
			# Возвращает массив предметов, которые были
			# помещены в ячейки быстрого доступа
			def quick_inventory;end

			def medkits;end

			def equip(item);end

			def biography=(value);end
			# Сумма параметров брони
			def armor;end

			# Проверяет, присутствует ли предмет в инвентаре
			# => item - объект класса Redenik::Item, ::Weapon или ::Armor
			def got_in_inventory?(item);end
			def got_key?(rarity);end
			def got_new_level?;end

			def recover_health(amount);end
			def recover_mana(amount);end
			def raise_hungriness(amount);end		
			def raise_drunkenness(amount);end
			def raise_poison(amount);end
			def lose_drunkenness(amount);end
			def lose_hungriness(amount);end
			def lose_health(amount);end
			def lose_mana(amount);end

			private 

			def _check_level;end
			def _gain_stat(type);end
			def _gain_skill(skill_id);end
		end

		# TODO: заменить на менеджер отношений...
		class Enemy < DressingPerson
			# dummy now
			attr_reader :rarity, :base_creature
			def initialize(name,base_creature,stats,equips);end
		end

		class Animal < Person
			# dummy now
		end

		class Soulless < Person
			# dummy now
		end
		
		class Armor < BasicItem
			def initialize(effects,rarity,equip_type);end
			def use;end
			def equip;end

			private

			def _load_weight;end

			# mixins
			module ArmorWeight
				def mixin_initialize(weight);end
			end

			# subclasses

		end

		class Cloth < BasicItem
			def initialize(rarity,start_price);end
			def use;end
			def equip;end

			private

			def _load_weight;end

			# mixins
			module ClothWeight
				def mixin_initialize(weight);end
			end

			module UnderLayer;end
			module MidLayer;end
			module OuterLayer;end
			module Colors;end

			# subclasses
			class Accessories
				class Belt;end
			end

			class Footwear
				class Footwrap;end
				class Puttee;end
				class Sock;end
				class Stockings;end
				# See there: https://en.wikipedia.org/wiki/Tabi
				class Tabi;end
			end

			class Outerwear;end

			class Shorts
				class Jeggings;end
				class Leggings;end
				class Sweatpants;end
				class YogaPants;end
			end

			class Skirt
				class Miniskirt;end
			end

			class Swimwear
				class Bikini;end
				class Monokini;end
				class OnePiece;end
				class TwoPiece;end
				class Trunks;end
			end

			class Tops
				class TShirt;end
			end

			class Underwear
				# for women
				class Bloomers;end
				class Bra
					class FullCup;end
					class Plunge;end
					class Balconette;end
				end
				class Bustier;end
				class Camiknicker;end
				class Corset;end
				class Panties
					class Bikini;end
					class Boyshorts;end
					class Briefs
						class Classic;end
						class HighCut;end
						class Control;end
					end
					class Hipsters;end
					class Pantalettes;end
					class Tanga
						class Thongs;end
						class GString;end
					end
				end
				# for men
				class Underpants
					class BoxerShorts;end
					class BoxerBriefs;end
					class MidwayBriefs;end
					class Trunks;end
					class Briefs;end
					class Thong;end
				end
			end
		end

		class Item < BasicItem
			def initialize(name,effects,rarity,consumable,food=false);end
			def eatable?;end
			def medkit?;end
			def consumable?;end

			private

			def _use_item;end
			def _load_icon_by_type(dir);end
			def _gen_help_info;end
			def _load_weight;end

			# mixins
			module Alcohol
				def mixin_initialize(value);end
				def mixin_use_item(actor);end
				def mixin_gen_help_info;end 
			end
			
			module Healing
				def mixin_initialize(health,mana,hungriness,drunkenness);end
				def mixin_use_item(actor);end
				def mixin_gen_help_info(food);end
				private
				def _recheck_modifiers;end
			end
			
			module RaiseStats
				def mixin_initialize(stat,value,time);end
				def mixin_use_item(actor);end
			end
			
			module RaiseSkill
				def mixin_initialize(skill_id);end
				def mixin_use_item(actor);end
				def mixin_gen_help_info;end
			end

			# subclasses
			class Book < Item
				def initialize(filename);end

				private

				def _load_icon_by_type;end
				def _load_book_name;end
				def _load_book_icon;end

				class Comics < Book;end
				class Historical < Book;end
				class Skillbook < Book;end
				class Diary < Book;end
				class Magazine < Book;end
				class Magictome < Book;end
			end

			class Food < Item
				def initialize;end

				private

				def _load_icon_by_type;end

				class Becon < Food;end
				class Bread < Food;end
				class Butter < Food;end
				class Cheese < Food;end
				class Mushroom < Food;end
				class Salt < Food;end
			end

			class Drink < Item
				def initialize;end

				private

				def _load_icon_by_type;end

				class Water < Drink;end
				class SeaWater < Drink;end
				class Milk < Drink;end
				class Wine < Drink;end
				class Beer < Drink;end
				class Tekila < Drink;end
				class Vodka < Drink;end
			end
		end

		class Key < BasicItem
			def initialize(rarity);end
		end

		class Skill
			attr_reader :exp, :level
			attr_reader :name, :help_info
			def initialize(name,help_info,max_level);end
			def raise_exp(value);end
			def raise_level;end
			def use;end
		end

		class Weapon < BasicItem
			attr_reader :dual_wield

			def initialize(effects,rarity,weapon_type);end

			def use(actor,target);end

			def throw(actor,target);end

			def equip(hand);end

			def dual_wield?;end

			def can_use?;end
			def can_throw?;end
			def can_cook?;end

			private

			def _use_weapon(actor,target);end

			def _gen_health_by_rare(rarity);end

			def _gen_mana_by_rare(rarity);end

			def _gen_wield_by_type(weapon_type);end

			def _load_weight;end

			def _show_message_after_use(results_of_use);end
			def _show_message_cant_use(actor);end
			def _show_message_cant_throw(actor);end

			# примесь для русского языка: Род и Число
			# Weapon name is male
			module WeaponM;end
			# Weapon name is female
			module WeaponF;end
			# Weapon name is neuter
			module WeaponN;end
			# Weapon name is plural
			module WeaponP;end
			# mixins
			module ForHunters;end
			module ForSports;end
			module ForThrowing;end
			module ForCooking;end
			# Колющее
			module Stabbing;end
			# Рубящее
			module Slashing;end
			# Ударно-раздробляющее
			module ShockFragmenting;end
			# Стрелковое оружие
			#--
			# честно, так и есть, сам хохотал
			#++
			module SmallArms;end

			# subclasses
			
			# == Топор
			# [Тип владения:] Двуручное оружие
			# [Тип оружия:] Рубящее
			# [Описание:] 
			class Axe
				include WeaponM
				include Slashing
			end

			# == Лук
			# [Тип владения:] Двуручное оружие
			# [Тип оружия:] Стрелковое
			# [Описание:] 
			class Bow
				include WeaponM
			end

			# == Цепной хлыст
			# [Тип владения:] Одноручное оружие
			# [Тип оружия:] 
			# [Описание:] 
			class Chainwhip;end

			# == Когти
			# [Тип владения:] Одноручное оружие
			# [Тип оружия:] 
			# [Описание:] 
			class Claws;end

			# == Дубина
			# [Тип владения:] Двуручное оружие
			# [Тип оружия:] Ударное
			# [Описание:] 
			class Club;end

			# == Арбалет
			# [Тип владения:] Двуручное оружие
			# [Тип оружия:] Стрелковое
			# [Описание:] 
			class Crossbow;end

			# == Кортик
			# [Тип владения:] Двуручное оружие
			# [Тип оружия:] 
			# [Описание:] 
			class Dirk;end

			# == Молот
			# [Тип владения:] Двуручное оружие
			# [Тип оружия:] Ударно-раздробляющее
			# [Описание:] 
			class Hammer;end

			# == Катана
			# [Тип владения:] Одноручное оружие
			# [Тип оружия:] 
			# [Описание:] 
			class Katana;end

			# == Длинный меч
			# [Тип владения:] Двуручное оружие
			# [Тип оружия:] 
			# [Описание:] 
			class LongSword;end

			# == Нож
			# [Тип владения:] Одноручное оружие
			# [Тип оружия:] 
			# [Описание:] 
			class Knife;end

			# == Кусаригама
			# [Тип владения:] Одноручное оружие
			# [Тип оружия:] 
			# [Описание:] 
			# [Wiki:] link(https://ru.wikipedia.org/wiki/Кусаригама)
			class Kusarigama;end

			# == Моргенштерн
			# [Тип владения:] Одноручное оружие
			# [Тип оружия:] Ударно-раздробляющее
			# [Описание:] 
			class Morgenstern;end

			# == Посох
			# [Тип владения:] Двуручное оружие
			# [Тип оружия:] 
			# [Описание:] 
			class Staff;end

			# == Меч
			# [Тип владения:] Одноручное оружие
			# [Тип оружия:] 
			# [Описание:] 
			class Sword;end

			# == Вакидзаси
			# [Тип владения:] Одноручное оружие
			# [Тип оружия:] 
			# [Описание:] 
			class Wakizashi;end

			# == Хлыст-клинок
			# [Тип владения:] Одноручное оружие
			# [Тип оружия:] 
			# [Описание:] 
			class Whipblade;end
		end
	end

	# МОДУЛИ

	module SkillManager
		class << self
			def prepare;end
			def learn_skill(id);end
			def unlearn_skill(id);end
			def learned?(id);end
			def block_skill(id);end
			def unblock_skill(id);end
			def blocked?(id);end
		end
	end

	module RelationshipManager
		class << self
			def enemies?(actor1,actor2);end
			def friends?(actor1,actor2);end
		end
	end

	module Alchemy
		class Ingredient
			def initialize(name,appearance,weight,effects);end
			def effect_known?(id);end
			def any_effect_known?(id);end
		end
		class Recepy
			def initialize(require_ingredients,skill,skill_level,result_item);end
		end
	end

	module NameGen
		class << self
			def prepare;end
			def make_name(min,max);end
			def make_info(type);end

			private 

			def _clear_banned_couples;end
		end
	end

	module MapGen
		class << self

		end
	end

	module BiographyGen
		class << self
			def prepare;end
			def actor=(value);end
			def orphan=(value);end
			def widower=(value);end
			def childrens=(value);end
			def generate;end
		end
	end

	module LevelDesign
		class Storage
			attr_accessor :items
			def initialize(max_rarity,max_level);end
			def add(item,number);end
			def remove(item,number);end
			# Возвращает список предметов в виде массива вида
			# [index] = { item, count }
			# для отображение в меню хранилища
			def itemlist;end
		end

		class BookShelf < Storage
			def initialize;end
		end

		class Crate < Storage
			def initialize(name,appearance);end
		end

		class Trader < Storage
			def initialize(name,trade_type_of);end
		end

		class Trap
			def initialize(map_id,x,y);end
			def update;end
			def detected?;end
			def touch_comer;end
			def triggered?;end
		end

		class Door
			def initialize(map_id,x,y,hidden=false);end
			def opened?;end
			def closed?;end
			def trapped;end
			def locked?;end
			def hidden?;end
			def lock(key_rarity);end
			def trap(trap_event);end
		end
	end

	# Отдельный модуль для графики - специально для проекта

	module Graphics
		module Cache
			# Текст модуля скопирован с модуля Cache
			# из состава скриптов по умолчанию
			# в проектах, создаваемых на VX Ace

			# Загрузка сразу в класс Image
			def self.load_image(folder_name, filename, hue = 0);end
			def self.load_bitmap(folder_name, filename, hue = 0);end
			def self.empty_bitmap;end
			def self.normal_bitmap(path);end
			def self.hue_changed_bitmap(path, hue);end
			def self.include?(key);end
			def self.clear;end
		end

		class Event
			attr_accessor :x, :y, :display_x, :display_y
			attr_accessor :controlable_now
			def initialize;end#(map_id,x,y);end
			def associate_with_player;end
			def associate_with_actor(actor);end
			def associate_with_enemy(enemy);end
			def associate_with_npc(npc);end
			def associate_with_trap(trap);end
			def associate_with_door(door);end
			def agressive?;end
			def frightened?;end
			def notice_enemy?;end
			def notice_trap?;end
			def can_carry_loot?;end
			def take_loot(from_xy);end
			def check_for_a_trap(x,y);end
		end

		class Image < Sprite
			def initialize(x,y,w=32,h=32);end
			def self.open(x,y,bitmap);end
			# Открывает изображение из файла. При невозможности открытия
			# создает новый файл по размерам, заданных rect, помещает его
			# в заданные в rect координаты и заливает цветом default_color.<br>
			# Параметр viewport имеет такое же значение, как и в self.open 
			def self.safety_open(filename,rect,default_color,viewport=nil);end
			def copy(bitmap);end
			def clone;end
			def x;end
			def y;end
			def z;end
			def x=(value);end
			def y=(value);end
			def z=(value);end
			def width;end
			def height;end
			def width=(value);end
			def height=(value);end
			def show;end
			def hide;end
			def marshal_dump;end

			# RGSS Sprite

			def visible;end
			def visible=(value);end
			def update;end
			def flash(color,duration);end
			def viewport;end
			def ox;end
			def oy;end
			def ox=(value);end
			def oy=(value);end
			def zoom_x;end
			def zoom_y;end
			def zoom_x=(value);end
			def zoom_y=(value);end
			def angle(rotation);end
			def mirror(value=false);end
			def opacity;end
			def opacity=(value);end
			def blend_type(type);end
			def color(color);end
			def tone(tone);end

			# RGSS Bitmap
			
			def clear;end
			def font;end
			def font=(value);end
			def blt(x,y,src_bitmap,src_rect,opacity=255);end
			def stretch_blt(dest_rect,src_bitmap,src_rect,opacity=255);end
			def rect;end
			def dispose;end
			def disposed;end
			def hue_change(hue);end
			def blur;end
			def radial_blur(angle,division);end
			def text_size(str);end
			def get_pixel(x,y);end
			def set_pixel(x,y,color);end
			def export(filename);end

			# Movement

			def move_to(x,y);end
			def moving?;end

			# Drawers

			def clear_rect(rect);end
			def draw_rect(rect,color,fill=true);end
			def draw_text(rect,text,color,horizontal_align=0,vertical_alig=0);end
			def draw_line(x1,y1,x2,y2,color,rasterize=false);end
			def draw_circle(x,y,radius,color,rasterize=false);end
			def draw_circle_rect(x1,y1,x2,y2,color,rasterize=false);end
			def draw_arc(center_x,center_y,start_angle,end_angle,radius,rasterize=false);end
			def draw_plot(x,y,color);end

			def flood_fill(x,y,color);end
			def draw_icon(icon_index);end

			# Colors

			def white(subdued=false);end
			def black(subdued=false);end
			def red(subdued=false);end
			def orange(subdued=false);end
			def yellow(subdued=false);end
			def lime(subdued=false);end
			def green(subdued=false);end
			def cyan(subdued=false);end
			def blue(subdued=false);end
			def purple(subdued=false);end
			def pink(subdued=false);end

			private

			def _swap(v1,v2);end

			# Построение линии по алгоритму Брезенхема
			def _draw_line_bresenham(x1,y1,x2,y2,color);end
			def _draw_circle_bresenham(x,y,radius,color);end

			# Построение линии по алгоритму Ву
			# (алгоритм Брезенхема + сглаживание)
			def _draw_line_wu(x1,y1,x2,y2,color);end

			def _draw_circle_bresenham(x,y,radius,color);end
			def _draw_circle_wu(x,y,radius,color);end

			def _neighbour_pixel(pixel,direction);end
			def _find_border(pixel,color,direction);end
		end

		class Mouse
			def initialize;end
			def update;end
			def normal;end
			def attack;end
			def look;end
			def talk;end
			def door;end
			def chest;end
			def url;end
			def cant;end
			def eat;end
			def drink;end
			def take;end
			# Специальный курсор для перетаскивания предметов (он как бы держит предмет)
			def hold;end
			def text;end
			def wait;end
		end

		class Map
			attr_accessor :events, :data
			def initialize(id,width,height,type,min_level,max_level);end

			def width;end

			def height;end
			
			# На карте безопасно?
			def is_safe?;end
			
			# Является ли карта - магазином?
			def is_store?;end
			
			# Является ли карта - гостиницей?
			def is_inn?;end
			
			# Является ли карта баром/рестораном/кафе?
			def is_pub?;end
			
			# Карта - это этаж Цитадели Испытаний?
			def is_floor?;end
			
			# Карта - это пещера?
			def is_dungeon?;end
			
			# Эта карта является городом?
			def is_town?;end
			
			# Эта карта является убежищем?
			def is_vault?;end
			
			# Эта карта является этажом подвала
			# в Цитадели Испытаний?
			def is_basement?;end

			def save_changes;end
		end

		class StaticMap < Map
			def initialize(id,filename);end
		end

		class Tilemap
			def initialize(map,tileset);end
			def refresh;end
			def dispose;end

			private

			def _analyze_map;end
			def _resize_map;end
			def _load_tileset;end
			def _draw_map;end
			def _draw_normal_tiles;end
			def _draw_auto_tiles;end
		end

		class UI_Component
			def initialize(x,y,width,height);end

			def x;end

			def y;end

			def z;end

			def x=(value);end

			def y=(value);end

			def z=(value);end

			def width;end

			def height;end

			def show;end

			def hide;end

			def visible;end

			def line_height;end

			def line_height=(value);end

			def update;end

			def activate;end

			def deactivate;end

			def is_active?;end

			def rect;end
		end

		class Window < UI_Component
			def add_button(name, method, appearance = nil, second = "", enabled = true);end

			def list;end

			def index;end

			def refresh;end

			def clear;end

			def columns=(value);end

			def columns;end

			def select(index);end

			private

			def _draw_all_buttons;end

			def _draw_button(button,index);end

			def _draw_sliders;end

			def _draw_vertical_slider;end
		end

		class Slideshow < UI_Component
			def add_slide(name, filename, appearance=nil);end
			def list;end
			def index;end
			def refresh;end
			def clear;end
			def show_arrows=(enabled);end
			def select(index);end
			def control=(enabled);end
			def block_left?;end
			def block_right?;end
			def block_left;end
			def unblock_left;end
			def block_right;end
			def unblock_right;end
			def update_complete?;end
			private
			def _draw_all_slides;end
			def _draw_slide(slide_index);end
			def _draw_arrow_left;end
			def _draw_arrow_right;end
		end

		# Компонент для простого отображения текста
		class Label < UI_Component
			# Задает текст, который будет выведен на компонент
			def text(value);end
		end

		class InputBox < UI_Component
			attr_reader :text
			def initialize(x, y, width, height, initial_text="", max_chars=nil);end
			def clear;end
			def refresh;end
			def begin_edit;end
			def end_edit;end
			def edit_now?;end
			private
			def _repos_pointer;end
			def _show_keyboard;end
			def _hide_keyboard;end
			def _draw_pointer;end
			def _input_update;end
			def _mouse_update;end
			def _enter;end
		end

		class Scalable_Window < UI_Component
			def refresh;end
			def frame_offset;end
			def frame_offset=(value);end
			def width=(value);end
			def height=(value);end 
			def skin;end
			def skin=(value);end
			private 
			def _repos;end
		end

		class Dialog < Scalable_Window
			def initialize;end
			def set_text(value);end
			def set_bust(filename,position);end
			def rem_bust(position);end
			def nobust;end
			def choice(left,right);end
			def multichoice(array);end
		end

		# WIDGETS

		class Widget_Health < UI_Component
			def initialize(x,y);end
			def refresh;end
			private
			def _draw_all;end
		end

		class Widget_History < UI_Component
			def initialize(x,y);end
			def refresh;end
			private
			def _draw_all;end
		end

		class Widget_QuickInventory < UI_Component
			def initialize(x,y);end
			def refresh;end
			private
			def reset_x;end
			def _draw_all;end
		end

		class Widget_Equipment < UI_Component
			def initialize(x,y);end
			def refresh;end
			private
			def _draw_all;end
		end

		class Widget_MapQuest < UI_Component
			def initialize(x,y);end
			def refresh;end
			private
			def _draw_all;end
		end
	end

	module Translation
		module Russian;end
		module Engish;end # may be
	end

	module Balance;end
	module SystemData;end

	module PluginManager
		class << self
			def enabled?;end
			def read_list;end
			def check_for_errors;end
			def load;end
			private
			def _convert(code);end
			def _exclude_tabs;end
			def _exclude_comments;end
			def _exclude_lines;end
			def _clean_code;end
			def _convert_conditions;end
			def _convert_variables;end
		end
	end
end