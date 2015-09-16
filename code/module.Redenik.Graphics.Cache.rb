# encoding utf-8

module Redenik::Graphics::Cache
	# Текст модуля скопирован с модуля Cache
	# из состава скриптов по умолчанию
	# в проектах, создаваемых на VX Ace

	def self.load_image(folder_name, filename, hue =0)
		temp = Redenik::Graphics::Image.new 0,0
		temp.copy load_bitmap(folder_name, filename, hue = 0)
		temp
	end

	def self.load_bitmap(folder_name, filename, hue = 0)
		@cache ||= {}
		if filename.empty?
			empty_bitmap
		elsif hue == 0
			normal_bitmap(folder_name + filename)
		else
			hue_changed_bitmap(folder_name + filename, hue)
		end
	end
	
	def self.empty_bitmap
		Bitmap.new(32, 32)
	end
	
	def self.normal_bitmap(path)
		@cache[path] = Bitmap.new(path) unless include?(path)
		@cache[path]
	end
	
	def self.hue_changed_bitmap(path, hue)
		key = [path, hue]
		unless include?(key)
			@cache[key] = normal_bitmap(path).clone
			@cache[key].hue_change(hue)
		end
		@cache[key]
	end
	
	def self.include?(key)
		@cache[key] && !@cache[key].disposed?
	end
	
	def self.clear
		@cache ||= {}
		@cache.clear
		GC.start
	end
end