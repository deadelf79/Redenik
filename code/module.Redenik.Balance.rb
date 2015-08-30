# encoding utf-8

module Redenik::Balance
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
end