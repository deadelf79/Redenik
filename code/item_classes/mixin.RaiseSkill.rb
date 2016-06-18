module Redenik::GameData::Item::RaiseSkill
	def mixin_initialize(skill_id)
		@skill_id = skill_id
	end
	
	def mixin_use_item(actor)
		actor.raise_skill_level @skill_id 
	end

	def mixin_gen_help_info
		result = []
		result.push format(
			Redenik::Translation::Russian::ITEM_DESC[:skillbook].sample,
			actor.skill(@skill_id).name
		)
		return result
	end
end