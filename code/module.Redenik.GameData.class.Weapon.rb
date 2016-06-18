# encoding utf-8

class Redenik::Weapon < Redenik::BasicItem
	def initialize(effects,rarity,weapon_type)
		@health 		= _gen_health_by_rare(rarity)
		@mana 			= _gen_mana_by_rare(rarity)
		@dual_wield 	= _gen_wield_by_type(weapon_type)
		@start_price	= Redenik::Balance::write_here_something
		super(@health,@mana,effects,rarity,start_price,:weapon)
	end

	def use(target);end
	def equip;end

	private

	def _gen_health_by_rare(rarity)
		Redenik::Balance::WEAPON_HEALTH[rarity]
	end

	def _gen_mana_by_rare(rarity)
		Redenik::Balance::WEAPON_HEALTH[rarity]
	end

	def _gen_wield_by_type(weapon_type)
		begin
			Redenik::Balance::WEAPON_WEILDS[weapon_type.to_s.downcase.to_sym]
		rescue
			return :mono
		end
	end
end