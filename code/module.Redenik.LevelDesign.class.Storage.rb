# encoding utf-8

class Redenik::LevelDesign::Storage
	attr_accessor :items
	def initialize(max_rarity,max_level,types=[:weapon,:armor,:item,:key,:book])
		@items = []
		@max_level, @max_rarity = max_level, max_rarity
		@types = types
	end

	def add(item,number,user_does_this=false)
		if item.is_a?(Redenik::Weapon||Redenik::Armor||Redenik::Item||Redenik::Key)
			return false if item.is_a?(Redenik::Weapon)	&&!types.include?(:weapon)
			return false if item.is_a?(Redenik::Armor)	&&!types.include?(:armor)
			return false if item.is_a?(Redenik::Item)	&&!types.include?(:item)
			return false if item.is_a?(Redenik::Key)	&&!types.include?(:key)
			return false if item.is_a?(Redenik::Book)	&&!types.include?(:book)
			number = 0 if number<0
			for count in 0...number
				@items.push item
			end
			if user_does_this
				Redenik.message_stack.push(
					format(
						Redenik::Translation::Russian.STORAGE_MESSAGES[:push_list],
						item,
						number
					)
				)	
			end
			return true
		else
			if user_does_this
				Redenik.message_stack.push(
					Redenik::Translation::Russian.STORAGE_MESSAGES[:error]	
				)	
			end
			wr "\tThere is an error with add an '#{item.name}' to storage."
			return false
		end
	end

	def remove(item,number)
		if @items.include?(item)
			max_count = 0
			@items.each{|value|max_count+=1 if value==item}
			max_count = number if max_count>number
			for count in 0...max_count
				@items.delete item
			end
		else
			wr "\t'#{item.name}' is not in a storage."
		end
	end

	def itemlist
		hash = {}
		array = []
		@items.each do|item|
			hash[item.name] = {}
			hash[item.name][:item] = item
			hash[item.name][:count] += 1
		end
		hash.each_key {|key|array.push(hash[item.name][:item],hash[item.name][:count])}
		array
	end
end
