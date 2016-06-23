# encoding utf-8

module Redenik::Balance
	START___MAX_ACTORS 	= 5
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

	ACTOR_MAX_HEALTH = 999
	ACTOR_MAX_ARMOR = 999
	ITEM_MIN_WEIGHT = 0.1
	ITEM_MAX_WEIGHT = 500.0

	ITEM_TYPES = [ # TODO: вообще следует переписать, тут ведь дофига всего
		:heal_hp,	:heal_mp,		:poison,
		:spellbook, :magictome
	]

	ITEMS = {
		# Тип	 	=> Вес типа (чем выше, тем больше будет предметов типа в процентном соотношении)
		:heal_hp	=> 100,
		:heal_mp	=> 100,
		:poison		=> 50,
		:spellbook	=> 50,
		:magictome 	=> 50
	}

	ITEM_COSTS = {
		:heal_hp	=> 100,
		:heal_mp	=> 100,
		:poison		=> 150,
		:spellbook	=> 250,
		:magictome 	=> 250
	}

	# !!TODO: оставлять ли? потому что рарности у предметов нет и не будет
	ITEM_USE_FX_BY_RARITY = { # --TODO: добавить все рарности
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

	ITEM_EFFECTS = {
		food: {
			default: 	{
				health: 		0,
				mana: 			0,
				hungriness: 	0,
				drunkenness: 	0
			},
			becon: 		{
				health: 		0,
				mana: 			0,
				hungriness: 	0,
				drunkenness: 	0
			},
			bread: 		{
				health: 		0,
				mana: 			0,
				hungriness: 	0,
				drunkenness: 	0
			},
			butter: 	{
				health: 		0,
				mana: 			0,
				hungriness: 	0,
				drunkenness: 	0
			},
			cheese: 	{
				health: 		0,
				mana: 			0,
				hungriness: 	0,
				drunkenness: 	0
			},
			mushroom: 	{
				health: 		0,
				mana: 			0,
				hungriness: 	0,
				drunkenness: 	0
			},
			salt: 		{
				health: 		0,
				mana: 			0,
				hungriness: 	0,
				drunkenness: 	0
			}
		},
		drink: {
			default: 	{
				health: 		0,
				mana: 			0,
				hungriness: 	0,
				drunkenness: 	0
			},
			water: 	{
				health: 		0,
				mana: 			0,
				hungriness: 	0,
				drunkenness: 	0
			},
			seawater: 	{
				health: 		0,
				mana: 			0,
				hungriness: 	0,
				drunkenness: 	0
			},
			milk: 	{
				health: 		0,
				mana: 			0,
				hungriness: 	0,
				drunkenness: 	0
			},
			wine: 	{
				health: 		0,
				mana: 			0,
				hungriness: 	0,
				drunkenness: 	0
			},
			beer: 	{
				health: 		0,
				mana: 			0,
				hungriness: 	0,
				drunkenness: 	0
			},
			tekila: 	{
				health: 		0,
				mana: 			0,
				hungriness: 	0,
				drunkenness: 	0
			},
			vodka: 	{
				health: 		0,
				mana: 			0,
				hungriness: 	0,
				drunkenness: 	0
			}
		}
	}

	ITEM_WEIGHTS = {
		book: {
			default: 	0,
			comics: 	0,
			diary: 		0,
			historical: 0,
			magazine: 	0,
			magictome: 	0,
			skillbook: 	0
		},
		default: 0,
		drink: {
			default: 	0,
			water: 		0,
			seawater: 	0,
			milk: 		0,
			wine: 		0,
			beer: 		0,
			tekila: 	0,
			vodka: 		0
		},
		food: {
			default: 	0,
			becon: 		0,
			bread: 		0,
			butter: 	0,
			cheese: 	0,
			mushroom: 	0,
			salt: 		0
		}
	}

	WEAPON_HEALTH = {
		common:			30,
		uncommon:		80,
		intensified: 	120,
		enchanted: 		100,
		rare:			350,
		legendary: 		475,
		ultrarare: 		725,
		unique:			2000
	}

	# насколько сильно ломается оружие в зависимости от его редкости
	WEAPON_BY_ARMOR_BREAK = {
		common:			2.3,
		uncommon:		2.1,
		intensified: 	1.5,
		enchanted: 		1.5,
		rare:			1.15,
		legendary: 		1.0,
		ultrarare: 		0.88,
		unique:			0.75
	}

	WEAPON_MANA = {
		common:			0,
		uncommon:		0,
		intensified: 	0,
		enchanted: 		0,
		rare:			0,
		legendary: 		0,
		ultrarare: 		0,
		unique:			0
	}

	WEAPON_WEILDS = {
		axe: 			:dual,
		bow: 			:dual,
		claws: 			:mono,
		club: 			:dual,
		crossbow: 		:dual,
		dirk: 			:dual,
		hammer: 		:dual,
		katana: 		:mono,
		longsword: 		:dual,
		knife: 			:mono,
		morgenstern: 	:mono,
		staff: 			:dual,
		sword: 			:mono,
		wakizashi: 		:mono
	}

	WEAPON_WEIGHTS = {
		axe: 			0,
		bow: 			0,
		claws: 			0,
		club: 			0,
		crossbow: 		0,
		dirk: 			0,
		hammer: 		0,
		katana: 		0,
		longsword: 		0,
		knife: 			0,
		morgenstern: 	0,
		staff: 			0,
		sword: 			0,
		wakizashi: 		0
	}

	FOOD_HEALING = {
		default: 	[ 10, 0, 30 ],
		becon: 		[ 10, 0, 35 ],
		bread: 		[ 10, 0, 25 ]
	}

	DRINK_HEALING = {
		default: 	[],
	}
end