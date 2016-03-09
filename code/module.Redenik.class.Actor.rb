# encoding utf-8

# полный код класса

#
class Redenik::Actor < Redenik::DressingPerson

	def initialize(name,appearance,stats,equips,level)
		super(name,appearance,stats,equips)
		@inv_items 		= []
		@inv_weapon 	= []
		@inv_armor 		= []
		@inv_keys 		= []
		@inv_quick		= []
		@current_level 	= level
		@biography 		= ""
	end

	# Gainers/Losers

	def gain_item( item, value = 1 )
		value.times{ @inv_items<<item } 	if item.is_a? Redenik::Item
		value.times{ @inv_weapons<<item } 	if item.is_a? Redenik::Weapon
		value.times{ @inv_armors<<item } 	if item.is_a? Redenik::Armor
		value.times{ @inv_keys<<item } 		if item.is_a? Redenik::Key
	end

	def lose_item( item, value = 1 )
		value.times do
			if inventory.inlude?( item )
				@inv_items 		-= [ item ] 	if item.is_a? Redenik::Item
				@inv_weapons 	-= [ item ] 	if item.is_a? Redenik::Weapon
				@inv_armors 	-= [ item ] 	if item.is_a? Redenik::Armor
				@inv_keys 		-= [ item ] 	if item.is_a? Redenik::Key
			else
				break
			end
		end
	end

	def gain_exp( value )
		if value > 0
			@exp += value
			if @exp > exp_curve(level).last
				level += 1
			end
		end
	end

	def set_quick_item( item, slot )
		new_slot = [ 0, slot ].max
		new_slot = [ 9, slot ].min
		if item.is_a? Redenik::Item
			@inv_items -= [ item ]
			if @inv_quick[ new_slot ].nil?
				@inv_quick[ new_slot ] = item
			else
				@inv_items += [ @inv_quick[ new_slot ] ]
				@inv_quick[ new_slot ] = item
			end
		end
	end

	def remove_quick_item( slot )
		new_slot = [ 0, slot ].max
		new_slot = [ 9, slot ].min
		unless @inv_quick[new_slot].nil?
			@inv_items += [ @inv_quick[ new_slot ] ]
			@inv_quick[ new_slot ] = nil
		end
	end

	def inventory
		@inv_items + @inv_weapons + @inv_armors + @inv_keys
	end

	def quick_inventory
		arr = []
		@inv_quick.each{ |item| arr.push item }
		arr
	end

	def medkits
		arr = []
		@inv_items.each{ |item| arr.push item if item.medkit? }
		arr
	end

	def biography=(value)
		@biography = value
	end

	def got_in_inventory?( item )
		inventory.include? item
	end

	def got_key?( rarity )
		if @inv_keys.size > 0
			@inv_keys.each{ |item| return true if item.rarity == rarity }
		end
		return false
	end

	def got_new_level?
		if @current_level != level
			@current_level = level
			return true
		end
		return false
	end
end