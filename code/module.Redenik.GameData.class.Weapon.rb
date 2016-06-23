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
		@can_throw = false
		@can_cook = false
		if self.class.included_modules.include? (WeaponM || WeaponF || WeaponN || WeaponP)
			mixin_initialize_gender_type
		else
			@weapon_gender_type = :m
		end
	end

	def use(actor,target)
		weapon_name = Redenik::Translation::Russian::WEAPON_NAMES[:weapon_type][self.class.downcase.to_sym]
		weapon_name = self.class if weapon_name.nil?

		if can_use?
			results_of_use = _use_weapon(actor,target)
			case actor.sex
			when :male
				Redenik.message_stack.push(
					format(
						Redenik::Translation::Russian::USE_WEAPON[:message_used_m],
						actor.name,
						weapon_name
					)
				)
			when :female
				Redenik.message_stack.push(
					format(
						Redenik::Translation::Russian::USE_WEAPON[:message_used_f],
						actor.name,
						weapon_name
					)
				)
			end
			_show_message_after_use(results_of_use)
		else
			_show_message_cant_use(actor)
		end
	end

	def throw(actor,target)
		if can_throw?
			results_of_use = _use_weapon(actor,target)
			case actor.sex
			when :male
				Redenik.message_stack.push(
					Redenik::Translation::Russian::USE_WEAPON[:message_actor_throw_m]
				)
			when :female
				Redenik.message_stack.push(
					Redenik::Translation::Russian::USE_WEAPON[:message_actor_throw_f]
				)
			end
			_show_message_after_use(results_of_use)
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

	def can_use?;end

	def can_throw?
		@can_throw
	end

	def can_cook?
		@can_cook
	end

	private

	def _use_weapon
		result = {
			deal_no_damage: false,
			deal_damage: 0,
			heal_target: true,
			heal_value: 0,
			armor_break: false,
			armor_break_critical: false,
			target_killed: false,
			actor_self_damage: false,
			actor_self_killed: false,
			actor_self_healed: false
		}

		if target.is_a? Actor
			was_hp = target.hp
			armor = target.armor
			# using process...
			if armor > 0
				minus_armor = 0 # подставь сюда формулы
				target.armor -= minus_armor 
				self.health -= minus_armor*Redenik::Balance::WEAPON_BY_ARMOR_BREAK[self.rarity]
			# elsif armor < weapon_damage
				# критический разлом брони (вдребезги)
			else
				minus_health = 0 # подставь сюда формулы
				target.health -= minus_health
				self.health -= 1
			end
			# after throwing
			if was_hp < target.hp
				# deal damage
			elsif was_hp > target.hp
				# heal target
			else
				# no damage
			end
			if target.hp<=0
				# killed
			end
			if armor > target.armor && target.armor <= 0
				# all armor is broken
			end
		else
			case target.class.downcase
			when "item"

			end
		end

		return result
	end

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

	def _show_message_after_use(results_of_use)
		if results_of_use[:actor_self_killed]

		end
	end

	def _show_message_cant_use(actor)
		if self.health <= 0
			case @weapon_gender_type
			when :m
				this_gender = message_cucb_this_m
				this_broken = message_cucb_broken_m
			when :f
				this_gender = message_cucb_this_f
				this_broken = message_cucb_broken_f
			when :n
				this_gender = message_cucb_this_n
				this_broken = message_cucb_broken_n
			when :p
				this_gender = message_cucb_this_p
				this_broken = message_cucb_broken_p
			end

			Redenik.message_stack.push(
				format(
					Redenik::Translation::Russian::USE_WEAPON[:message_cant_use_cause_broken],
					weapon_name,
					this_gender,
					this_broken
				)
			)
		else
			Redenik.message_stack.push(
				format(
					Redenik::Translation::Russian::USE_WEAPON[:message_cant_use],
					weapon_name
				)
			)
		end
	end

	def _show_message_cant_throw(actor)
		Redenik.message_stack.push(
			format(
				Redenik::Translation::Russian::USE_WEAPON[:message_cant_throw],
				weapon_name
			)
		)
	end
end