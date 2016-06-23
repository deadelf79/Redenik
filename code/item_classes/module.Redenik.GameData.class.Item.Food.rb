# encoding utf-8

# 
class Redenik::GameData::Item::Food < Redenik::GameData::Item
	
	include Redenik::GameData::Item::Healing
	
	def initialize(effects=[:heal_hp])
		name		= ''
		effects		= effects
		rarity		= :common
		consumable	= true
		food		= true
		super(name,effects,rarity,consumable,food)
		health		= Redenik::Balance::ITEM_EFFECTS[:food]["#{self.class.lowercase}"][health]
		mana		= Redenik::Balance::ITEM_EFFECTS[:food]["#{self.class.lowercase}"][mana]
		hungriness	= Redenik::Balance::ITEM_EFFECTS[:food]["#{self.class.lowercase}"][hungriness]
		drunkenness	= Redenik::Balance::ITEM_EFFECTS[:food]["#{self.class.lowercase}"][drunkenness]
		mixin_initialize( health, mana, hungriness, drunkenness )
	end

	private

	def _use_item(actor)
		mixin_use_item(actor)
	end

	def _load_icon_by_type
		if self.class.lowercase == "food"
			super("./gfx/icons/#{self.class.lowercase}")
		else
			super("./gfx/icons/drink/#{self.class.lowercase}")
		end
	end

	def _gen_help_info
		food = true
		info = mixin_gen_help_info(food)
		self.help_info = info.join(" ")
	end

	def _load_weight
		if self.class.lowercase == "food"
			@weight = Redenik::Balance::ITEM_WEIGHTS[:food][:default]
		else
			@weight = Redenik::Balance::ITEM_WEIGHTS[:food][self.class.lowercase.to_sym]
		end
	end
end