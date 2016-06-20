# encoding utf-8

class Redenik::Weapon < Redenik::BasicItem

	attr_reader :dual_wield

	def initialize(effects,rarity)
		@health 		= _gen_health_by_rare(rarity)
		@mana 			= _gen_mana_by_rare(rarity)
		@dual_wield 	= _gen_wield_by_type
		@start_price	= Redenik::Balance::write_here_something
		super(@health,@mana,effects,rarity,start_price,:weapon)
		_load_weight
	end

	def use(target)
		if target.is_a? Actor

		end
	end

	def throw(target)
		if @can_throw

		else
			Redenik.message_stack.push(
				Redenik::Translation::Russian::USE_WEAPON[:message_cant_throw]
			)
		end
	end

	def equip(actor,hand)
		case @dual_wield
		when :mono
			case hand
			when :left
				actor.left_hand = Redenik.game_weapons.index(self)
				if Redenik.game_weapons[actor.right_hand].dual_wield?
					actor.right_hand = -1
				end
			when :right
				actor.right_hand = Redenik.game_weapons.index(self)
				if Redenik.game_weapons[actor.left_hand].dual_wield?
					actor.left_hand = -1
				end
			else
				actor.right_hand = Redenik.game_weapons.index(self)
				if Redenik.game_weapons[actor.left_hand].dual_wield?
					actor.left_hand = -1
				end
			end
		when :dual
			case hand
			when :left
				actor.left_hand = Redenik.game_weapons.index(self)
				actor.right_hand = -1
			when :right
				actor.left_hand = -1
				actor.right_hand = Redenik.game_weapons.index(self)
			else
				actor.left_hand = -1
				actor.right_hand = Redenik.game_weapons.index(self)
			end
		end
	end

	def dual_wield?
		@dual_wield == :dual
	end

	private

	def _gen_health_by_rare(rarity)
		Redenik::Balance::WEAPON_HEALTH[rarity]
	end

	def _gen_mana_by_rare(rarity)
		Redenik::Balance::WEAPON_HEALTH[rarity]
	end

	def _gen_wield_by_type(weapon_type)
		begin
			Redenik::Balance::WEAPON_WEILDS[self.class.downcase.to_sym]
		rescue
			return :mono
		end
	end

	def _load_weight
		Redenik::Balance::WEAPON_WEIGHTS[self.class.downcase.to_sym]
	end
end