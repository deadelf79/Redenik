# encoding utf-8

# Абстрактный модуль для хранения указателей
# на все функции встроенных в него классов
module Redenik
	class << self
		attr_reader :game_actors, :game_items, :game_weapons, :game_armors
		attr_reader :game_skills, :game_party
		# Начало игры
		# Инициирует все данные перед стартом и запускает
		# переход на первую сцену (титульное меню по умолчанию)
		def start_game;end
		def main_game;end
		def end_game;end

		def add_party_member(id);end
		def party_dead?;end

		private
		def _gen_actors;end
		def _gen_items;end
		def _gen_weapons;end
		def _gen_armors;end
	end

	module GameManager
		class << self
			def start;end
			def main;end
			def quit;end
			def setup_scene(scene);end
			def update_scene;end
			def dispose_scene;end
			def call(scene);end
			def goto(scene);end
		end

		class Screen_Base
			def initialize(timer);end
			def update;end
			def update_basics;end
			def update_gfx;end
			def update_input;end
			def dispose;end
		end

		class Screen_Menu_Base < Screen_Base
			def create___all_windows;end
			def create___all_pictures;end
			def dispose___all_windows;end
			def dispose___all_pictures;end
			def fire___ok;end
			def fire___cancel;end
		end

		class Screen_Title < Screen_Menu_Base
			def create___background;end
			def create___game_title;end
			def create___title_window;end
			def fire___new_game;end
			def fire___load_game;end
			def fire___settings;end
			def fire___achivements;end
			def fire___statistics;end
			def fire___quit_game;end
		end

		class Screen_New < Screen_Menu_Base
			def fire___change_name;end
			def fire___change_class;end
			def fire___change_stat(stat);end
		end

		class Screen_Name < Screen_Menu_Base
			def update_keyboard;end
			def fire___enter_char(char);end
			def fire___delete_char(char);end
			def fire___change_pointer_pos(pos);end
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

		class Screen_Achievements
			def fire___change_achiv_to_show(index);end
			def fire___show_achiv_desc(index);end
		end

		class Screen_Statistics;end
		class Screen_Quit;end
	end

	# Материнские классы, от которых наследуется большинство других

	class Basic
		attr_reader :name, :health, :mana, :effects
		attr_accessor :gold_modifier
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
		attr_accessor :rarity, :price, :icon_index, :weight
		attr_reader :help_info
		def initialize(health,mana,effects,rarity,start_price,type);end

		private

		def _gen_help_info;end
	end

	#
	class Person < Basic
		attr_reader :appearance, :stats, :equips
		attr_reader :exp, :level, :skills
		def initialize(name,appearance,stats,equips);end
		def update;end
		def reset_exp;end
		def exp_curve(level);end

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

		private 

		def _check_hungry;end
		def _gen_actor_by_stats(stats);end
		def _reset_exp;end
		def _generate_exp_curve;end
	end

	# Игровые классы

	class Actor < Person
		attr_reader :hungriness, :feel_monsters, :feel_traps
		attr_reader :can_carry_weight
		def initialize(name,appearance,stats,equips,level);end
		
		# Gainers/Losers

		def gain_item(item,value);end
		def lose_item(item,value);end
		def gain_exp(value);end

		# Возвращает массив из всех предметов, находящихся
		# в инвентаре
		def inventory;end

		# Проверяет, присутствует ли предмет в инвентаре
		# => item - объект класса Redenik::Item, ::Weapon или ::Armor
		def got_in_inventory?(item);end
		def got_key?(rarity);end
		def got_new_level?;end

		private 

		def _check_level;end
		def _gain_stat(type);end
	end
	
	class Armor < BasicItem
		def initialize(effects,rarity,equip_type);end
	end

	class Enemy < Person
		attr_reader :rarity, :base_creature
		def initialize(name,base_creature,stats,equips);end
	end

	class Item < BasicItem
		def initialize(name,effects,rarity,food);end
		def eatable?;end
	end

	class Key
		def initialize(rarity);end
	end

	class Skill
		attr_reader :exp, :condition_string, :level
		attr_reader :name, :help_info
	end

	class Weapon < BasicItem
		def initialize(effects,rarity,two_handed);end
	end

	# МОДУЛИ

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

	module LevelDesign
		class Storage
			attr_accessor :items
		end

		class Trader < Storage
			def initialize(name,trade_type_of,max_rarity,max_level);end
		end

		class Trap
			def initialize(map_id,x,y);end
			def update;end
			def detected?;end
			def touch_comer;end
			def triggered?;end
		end
	end

	# Отдельный модуль для графики - специально для проекта

	module Graphics
		module Cache
			# Текст модуля скопирован с модуля Cache
			# из состава скриптов по умолчанию
			# в проектах, создаваемых на VX Ace

			def self.load_bitmap(folder_name, filename, hue = 0);end
			def self.empty_bitmap;end
			def self.normal_bitmap(path);end
			def self.hue_changed_bitmap(path, hue);end
			def self.include?(key);end
			def self.clear;end
		end

		class Event
			attr_accessor :x, :y, :display_x, :display_y
			def initialize(map_id,x,y);end
			def associate_with_actor(actor);end
			def associate_with_enemy(enemy);end
			def associate_with_npc(npc);end
			def agressive?;end
			def frightened?;end
			def notice_enemy?;end
			def notice_trap?;end
			def can_carry_loot?;end
			def take_loot(from_xy);end
			def check_for_a_trap(x,y);end
		end

		class Image < Sprite
			def initialize(*args);end
			def width;end
			def height;end
			def width=(value);end
			def height=(value);end

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

			# Drawers

			def clear_rect(rect);end
			def draw_rect(rect,color,fill=true);end
			def draw_text(rect,text,color,horizontal_align=0,vertical_alig=0);end
			def draw_line(x1,y1,x2,y2,color,rasterize=false);end
			def draw_circle(x,y,radius,color,rasterize=false);end
			def draw_circle_rect(x1,y1,x2,y2,color);end
			def draw_plot(x,y,color);end

			private

			def _swap(v1,v2);end

			# Построение линии по алгоритму Брезенхема
			def _draw_line_bresenham(x1,y1,x2,y2,color);end
			def _draw_circle_bresenham(x,y,radius,color);end

			# Построение линии по алгоритму Ву
			# (алгоритм Брезенхема + сглаживание)
			def _draw_line_wu(x1,y1,x2,y2,color);end
		end

		class Map
			attr_accessor :events, :tileset, :autotiles
			def initialize(id,width,height,type,max_rooms=100);end
			
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

			private

			def _gen_room;end
			def _gen_passage;end
			def _render_map;end
			def _save_map(full_mode=false);end
		end

		class Tilemap
			def initialize(map);end

			private

			def _draw_map;end
		end

		class Player < Event
			attr_accessor :controlable_now
			def manual_detect_traps;end
		end

		class Window < Image
			def initialize(x,y,width,height);end
			def skin=(image);end

			private

			def _redraw_skin(image);end
		end
	end

	module Translation
		module Russian;end
	end

	module Balance;end
end

module Kernel	
	def with(instance, &block)
		instance.instance_eval(&block)
		instance
	end
end