# encoding utf-8

class Redenik::Weapon < Redenik::BasicItem
	def initialize(effects,rarity,weapon_type)
		@health 		= _gen_health_by_rare(rarity)
		@mana 			= _gen_mana_by_rare(rarity)
		@dual_wield 	= _gen_wield_by_type(weapon_type)
		@start_price	= Redenik::Balance::write_here_something
		super(@health,@mana,effects,rarity,start_price,:weapon)
	end

	def use;end

	private

	def _gen_health_by_rare(rarity)
		Redenik::Balance::WEAPON_HEALTH[rarity]
	end

	def _gen_mana_by_rare(rarity)

	end

	def _gen_wield_by_type(weapon_type)
		case weapon_type
		when :axe
			return :dual
		when :claws
			return :mono
		when :club
			return :mono
		when :hammer
			return :dual
		when :knife
			return :mono
		when :staff
			return :dual
		when :sword
			return [:dual, :mono].sample
		end
	end
end