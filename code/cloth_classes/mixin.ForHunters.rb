module Redenik::GameData::Weapon::ForHunters
	def mixin_initialize
	end
	
	def mixin_use_item(actor)
		
	end
	
	def mixin_equip_item(actor)
	
	end

	def mixin_gen_help_info
		result = []
		# result.push Redenik::Translation::Russian::ITEM_DESC[:alcohol].sample
		return result
	end
end