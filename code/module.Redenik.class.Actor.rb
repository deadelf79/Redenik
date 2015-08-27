# encoding utf-8

# полный код класса

#
class Redenik::Actor < Redenik::Person

	def initialize(name,appearance,stats,equips,level)
		super(name,appearance,stats,equips)
		@inv_items 	= []
		@inv_weapon = []
		@inv_armor 	= []
		@inv_keys 	= []
		@current_level = level
	end

	# Gainers/Losers
		
	def gain_item(item,value);end

	def gain_item(item,value)
		value.times{@inv_items<<item} 	if item.is_a? Redenik::Item
		value.times{@inv_weapons<<item} if item.is_a? Redenik::Weapon
		value.times{@inv_armors<<item} 	if item.is_a? Redenik::Armor
		value.times{@inv_keys<<item} 	if item.is_a? Redenik::Key
	end

	def lose_item(item,value)
		value.times{
			if inventory.inlude?(item)
				@inv_items-=[item] 		if item.is_a? Redenik::Item
				@inv_weapons-=[item] 	if item.is_a? Redenik::Weapon
				@inv_armors-=[item] 	if item.is_a? Redenik::Armor
				@inv_keys-=[item] 		if item.is_a? Redenik::Key
			else
				break
			end
		}
	end

	def gain_exp(value)

	end

	def inventory
		@inv_items + @inv_weapons + @inv_armors + @inv_keys
	end

	def got_in_inventory?(item)
		inventory.include? item
	end

	def got_key?(rarity)
		if @inv_keys.size>0
			@inv_keys.each{|item| return true if item.rarity==rarity}
		end
		return false
	end

	def got_new_level?
		if @current_level!=level
			@current_level=level
			return true
		end
		return false
	end
end