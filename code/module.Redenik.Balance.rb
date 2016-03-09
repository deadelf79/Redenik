# encoding utf-8

module Redenik::Balance
	START___MAX_ACTORS 	= 30
	START___MAX_ITEMS	= 300
	START___MAX_ARMORS	= 900
	START___MAX_WEAPON	= 900
	START___STATS_CAN_APPORTION = 3

	STATS___CLASSES = [
		{:class_name=>:citizen,		:st=>10,	:dx=>10,	:iq=>10,	:ht=>10,	:cr=>10},
		{:class_name=>:warrior,		:st=>12,	:dx=>9,		:iq=>8,		:ht=>11,	:cr=>10},
		{:class_name=>:mage,		:st=>8,		:dx=>8,		:iq=>12,	:ht=>10,	:cr=>10},
		{:class_name=>:thief,		:st=>8,		:dx=>13,	:iq=>11,	:ht=>8,		:cr=>10},
		{:class_name=>:traider,		:st=>12,	:dx=>12,	:iq=>5,		:ht=>7,		:cr=>14}
	]
	ITEM_TYPES = [
		:heal_hp,	:heal_mp,		:poison,	:scroll, # Scroll здесь - свиток
		:spellbook, :spellscroll,	:storybook, :learnskill
	]
	ITEMS = {
		# Тип	 	=> Вес типа (чем выше, тем больше будет предметов типа в процентном соотношении)
		:heal_hp	=> 100,
		:heal_mp	=> 100,
		:poison		=> 50,
		:scroll 	=> 25,
		:spellbook	=> 50,
		:spellscroll=> 100,
		:storybook	=> 50,
		:learnskill => 25
	}
	ITEM_COSTS = {
		:heal_hp	=> 100,
		:heal_mp	=> 150,
		:poison		=> 200,
		:scroll 	=> 150,
		:spellbook	=> 300,
		:spellscroll=> 150,
		:storybook	=> 200,
		:learnskill => 400
	}
	WEAPON_HEALTH = {
		:common		=> 30,
		:uncommon	=> 80,
		:rare		=> 130,
		:unique		=> 200
	}
end