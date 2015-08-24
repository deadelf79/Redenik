# encoding utf-8

# полный код класса

#
class Redenik::Actor < Redenik::Person
	def gain_item(item,value)
		value.times{@inv_items<<item} if item.is_a? Redenik::Item
		value.times{@inv_weapons<<item} if item.is_a? Redenik::Weapon
		value.times{@inv_armors<<item} if item.is_a? Redenik::Armor
		value.times{@inv_keys<<item} if item.is_a? Redenik::Key
	end

	def inventory
		@inv_items + @inv_weapons + @inv_armors + @inv_keys
	end

	def got_in_inventory?(item)
		inventory.include? item
	end
end