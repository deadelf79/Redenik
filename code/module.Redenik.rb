# = Redenik Game Engine (based on RGSS3)
# Полная документация по классам и модулям движка для игры Redenik
# Автор:: DeadElf79
# Исходный код:: https://github.com/deadelf79/Redenik

# Абстрактный модуль для хранения указателей
# на все функции встроенных в него классов
module Redenik
	class << self
		# Массив данных обо всех персонажах в игре.<br>
		# Самый первый персонаж в списке (под номером 0) - это персонаж,
		# который был создан игроком на экране создания персонажа.
		attr_reader :game_actors

		attr_reader :game_items

		attr_reader :game_weapons

		attr_reader :game_armors

		attr_reader :game_skills

		# Массив данных и команде.<br>
		# Содержит набор ссылок на персонажей из массива @game_actors, с которыми
		# были установлены дружеские отношения и которые присоединились
		# к команде игрока.
		attr_reader :game_party

		attr_reader :game_maps

		attr_reader :current_map

		# Инициирует все данные перед стартом и запускает
		# переход на первую сцену (титульное меню по умолчанию)
		def start_game;end
		def main_game;end
		def end_game;end
		def save_game;end

		def add_party_member(id);end
		def party_dead?;end
		def player;end
		def next_member;end

		def joypad_enabled?;end
		def joypad(enable);end

		private
		def _check_usac(user_actor);end
		def _gen_actors;end
		def _gen_items;end
		def _gen_weapons;end
		def _gen_armors;end
		def _gen_skills;end
		def _gen_game_maps;end
	end

	module GameManager
		class << self
			def start;end
			def main;end
			def quit;end
			def setup_first_scene;end
			def setup_scene(scene);end
			def update_scene;end
			def dispose_scene;end
			def call(scene);end
			def goto(scene);end
			def cancel;end
		end

		class Achievement
			def initialize(hash);end
			def get?;end
			def get;end
		end

		class Screen_Base
			def initialize(timer);end
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
			def _update_movement;end
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
			def create___ingame_messagebox;end
			def create___ingame_hud_name;end
			def create___ingame_hud_hp;end
			def create___ingame_hud_mp;end
			def create___ingame_hud_exp;end
			def create___ingame_hud_current_weapon;end
			def create___ingame_hud_current_armor;end
			def create___ingame_hud_popup_list;end

			private

			def _save_changes;end
		end
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
		def help_info=(new_text);end	

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

	class Key < BasicItem
		def initialize(rarity);end
	end

	class Skill
		attr_reader :exp, :condition_string, :level
		attr_reader :name, :help_info
	end

	class Weapon < BasicItem
		def initialize(effects,rarity,weapon_type);end

		private

		def _gen_health_by_rare(rarity);end

		def _gen_mana_by_rare(rarity);end

		def _gen_wield_by_type(type);end
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

	module MapGen
		class << self

		end
	end

	module LevelDesign
		class Storage
			attr_accessor :items
			def initialize(max_rarity,max_level);end
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
			def initialize(map_id,x,y);end
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
			def draw_circle_rect(x1,y1,x2,y2,color);end
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

			def _neighbour_pixel(pixel,direction);end
			def _find_border(pixel,color,direction);end
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
			def _enter;end
		end
	end

	module Translation
		module Russian;end
		module Engish;end # may be
	end

	module Balance;end

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

module Kernel
	def with(instance, &block)
		instance.instance_eval(&block)
		instance
	end
end