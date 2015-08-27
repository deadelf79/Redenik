# encoding utf-8

# Абстрактный модуль для хранения указателей
# на все функции встроенных в него классов
module Redenik
	class << self
		attr_reader :game_actors, :game_items, :game_weapons, :game_armors

		def start_game;end

		private
		def _gen_actors;end
		def _gen_items;end
		def _gen_weapons;end
		def _gen_armors;end
	end

	# Материнские классы, от которых наследуется большинство других

	class Basic
		attr_accessor :health, :mana, :effects
		attr_accessor :gold_modifier
	end

	class BasicItem < Basic
		attr_accessor :rarity, :price, :icon_index, :weight
		attr_reader :help_info
		def initialize(health,mana,effects,rarity,start_price,type);end
	end

	#
	class Person < Basic
		attr_reader :name, :appearance, :stats :equips
		attr_reader :exp, :level, :skills
		def initialize(name,appearance,stats,equips);end
		def update;end
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
	
	class Armor;end
	class Enemy < Person
		attr_reader :rarity, :base_creature
		def initialize(name,base_creature,stats,equips);end
	end
	class Item;end
	class Key;end
	class Skill
		attr_reader :exp, :condition_string, :level
		attr_reader :name, :help_info
	end
	class Weapon;end

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
		def prepare;end
		def make_name(min,max);end
	end

	module LevelDesign
		class Storage
			attr_accessor :items
		end

		class Trader < Storage
			def initialize(name,trade_type_of,max_rarity,max_level);end
		end

		class Trap;end
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
			def draw_line(x1,y1,x2,y2,color,rasterize=false)
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
		class Tilemap;end
		class Player < Event
			attr_accessor :controlable_now
		end
		class Window < Image
			def initialize(x,y,width,height);end
		end
	end
end

module Kernel	
	def with(instance, &block)
		instance.instance_eval(&block)
		instance
	end
end