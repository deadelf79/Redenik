# encoding utf-8

module Redenik::Balance
	START___MAX_ACTORS 	= 30
	START___MAX_ITEMS	= 300
	START___MAX_ARMORS	= 900
	START___MAX_WEAPON	= 900
	START___STATS_CAN_APPORTION = 3

	STATS___CLASSES = [
		{
			:class_name=>:citizen,
			:st=>10,
			:dx=>10,
			:iq=>10,
			:ht=>10,
			:cr=>10
		},
		{
			:class_name=>:warrior,
			:st=>12,
			:dx=>9,
			:iq=>8,
			:ht=>11,
			:cr=>10
		},
		{
			:class_name=>:mage,
			:st=>8,
			:dx=>8,
			:iq=>12,
			:ht=>10,
			:cr=>10
		},
		{
			:class_name=>:thief,
			:st=>8,
			:dx=>13,
			:iq=>11,
			:ht=>8,
			:cr=>10
		},
		{
			:class_name=>:traider,
			:st=>12,
			:dx=>12,
			:iq=>5,
			:ht=>7,
			:cr=>14
		}
	]
	GAME___COMPLEXITY = [
		:tourist, 	# турист - (-1/3) меньше хп у врагов
		:mercenary, # наемник - средний уровень
		:marauder, 	# мародер - (+1/3) больше хп у врагов, (+1/6) золота
		:conqueror 	# завоеватель - (+2/3) больше хп у врагов, враги используют укрытия и атакуют из них
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
	ITEM_USE_FX_BY_RARITY = {
		:common		=> {
			:heal_hp =>	(15..25),
			:heal_mp =>	(15..25)
		},
		:uncommon	=> {
			:heal_hp =>	(25..50),
			:heal_mp =>	(25..50)
		},
		:rare		=> {
			:heal_hp =>	(50..90),
			:heal_mp =>	(50..90)
		},
		:unique		=> {
			:heal_hp =>	(90..150),
			:heal_mp =>	(90..150)
		}
	}
	WEAPON_HEALTH = {
		:common		=> 30,
		:uncommon	=> 80,
		:rare		=> 130,
		:unique		=> 200
	}
end