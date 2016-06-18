module Redenik::GameData::Item::Alcohol
	def mixin_initialize(value)
		@drunkenness_modifier 	= true
		@drunkenness_add 		= value
	end
	
	def mixin_use_item(actor)
		if @drunkenness_modifier
			actor.raise_drunkenness @drunkenness_add
		end
	end

	def mixin_gen_help_info
		result = []
		result.push Redenik::Translation::Russian::ITEM_DESC[:alcohol].sample
		return result
	end
end