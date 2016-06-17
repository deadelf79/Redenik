# encoding utf-8

class Redenik::GameData::Item::Book::Magictome < Redenik::GameData::Item::Book
	def initialize(skill_id)
		super('')
		@skill_id = skill_id
		@consumable = true
	end

	private

	def _load_icon_by_type
		super("./gfx/icons/book/#{self.class}")
	end

	def _gen_help_info
		
	end
	
	def _use_item(actor)
		cant_use = false
		cause = []
		if actor.magic_level(@skill_id)==0
			actor.learn_magic(@skill_id)
			cause.push format(Redenik::Translation::Russian::USE_ITEM[:message_learn_magic],@name)
			if @consumable
				dispose
			end
		else
			cause.push format(Redenik::Translation::Russian::USE_ITEM[:message_magic_already_learned],@name)
			cant_use = true
		end
		return [cant_use,cause]
	end
end