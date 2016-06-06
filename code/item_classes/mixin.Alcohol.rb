class Redenik::GameData::Item::Alcohol < Redenik::GameData::Item
	alias original_method_initialize initialize
	def initialize(*args)
		original_method_initialize(*args)

		@alcohol_modifier = true
	end

	alias original_method_use_item _use_item
	def _use_item(actor)
		original_method_use_item

		if @alcohol_modifier
			actor.add_drunk
		end
	end
end