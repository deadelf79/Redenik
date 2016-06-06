#encoding utf-8

class Redenik::GameData::Armor < Redenik::BasicItem
	def initialize(effects,rarity,equip_type)
		super(1,0,effects,rarity,0,:none)
	end

	def use
		#
	end
end