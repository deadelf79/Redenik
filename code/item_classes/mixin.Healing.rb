module Redenik::GameData::Item::Healing
	def mixin_initialize(health,mana,hungriness,drunkenness)
		@heal_health_modifier 		= true
		@heal_mana_modifier 		= true
		@heal_hungriness_modifier 	= true
		@heal_drunkenness_modifier 	= true
		@health_add 				= [ health,		0].max
		@mana_add 					= [ mana,		0].max
		@hungriness_lose 			= [ hungriness,	0].max
		@drunkenness_lose 			= [ drunkenness,0].max
		_recheck_modifiers
	end
	
	def mixin_use_item(actor)
		_recheck_modifiers
		if @heal_health_modifier
			actor.restore_health @health_add
		end
		if @heal_mana_modifier
			actor.restore_mana @mana_add
		end
		if @heal_hungriness_modifier
			actor.lose_hungriness @hungriness_lose
		end
		if @heal_drunkenness_modifier
			actor.lose_drunkenness @drunkenness_lose
		end
	end
	
	def mixin_gen_help_info(food)
		_recheck_modifiers
		result = []
		if @heal_health_modifier
			result.push Redenik::Translation::Russian::ITEM_DESC[:heal_hp].sample
		end
		if @heal_mana_modifier
			result.push Redenik::Translation::Russian::ITEM_DESC[:heal_mp].sample
		end
		if @heal_hungriness_modifier
			if food		==	true
				result.push Redenik::Translation::Russian::ITEM_DESC[:food].sample
			elsif food	==	false
				result.push Redenik::Translation::Russian::ITEM_DESC[:drink].sample
			end
		end
		if @heal_drunkenness_modifier
			result.push Redenik::Translation::Russian::ITEM_DESC[:alcohol].sample
		end
		return result
	end
	
	private
	
	def _recheck_modifiers
		@heal_health_modifier 		= @health_add > 0 		? true : false
		@heal_mana_modifier 		= @mana_add > 0 		? true : false
		@heal_hungriness_modifier 	= @hungriness_add > 0 	? true : false
		@heal_drunkenness_modifier	= @drunkenness_add > 0 	? true : false
	end
end