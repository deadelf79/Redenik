# encoding utf-8

# 
class Redenik::GameData::Item::Drink < Redenik::GameData::Item
	
	include Redenik::GameData::Item::Healing
	
	def initialize
		name		= ''
		effects		= [:heal_hp]
		rarity		= :common
		consumable	= true
		food		= true
		super(name,effects,rarity,consumable,food)
		health		= Redenik::Balance::ITEM_EFFECTS[:drink]["#{self.class.lowercase}"][health]
		mana		= Redenik::Balance::ITEM_EFFECTS[:drink]["#{self.class.lowercase}"][mana]
		hungriness	= Redenik::Balance::ITEM_EFFECTS[:drink]["#{self.class.lowercase}"][hungriness]
		drunkenness	= Redenik::Balance::ITEM_EFFECTS[:drink]["#{self.class.lowercase}"][drunkenness]
		mixin_initialize( health, mana, hungriness, drunkenness )
	end

	private

	def _use_item(actor)
		cant_use = false
		cause = []
		if @effects.include?(:heal_hp)
			actor.recover_health(@heal_hp)
		elsif @effects.include?(:heal_mp)
			actor.recover_mana(@heal_mp)
		end
		return [cant_use,cause]
	end

	def _load_icon_by_type
		if self.class.lowercase == "drink"
			super("./gfx/icons/#{self.class.lowercase}")
		else
			super("./gfx/icons/drink/#{self.class.lowercase}")
		end
	end

	def _gen_help_info
		food = false
		info = mixin_gen_help_info(food)
		self.help_info = info.join(" ")
	end

	def _load_weight
		if self.class.lowercase == "drink"
			@weight = Redenik::Balance::ITEM_WEIGHTS[:drink][:default]
		else
			@weight = Redenik::Balance::ITEM_WEIGHTS[:drink][self.class.lowercase.to_sym]
		end
	end
end