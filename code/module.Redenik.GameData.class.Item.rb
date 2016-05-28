#encoding utf-8

class Redenik::Item < Redenik::BasicItem
	def initialize(name,effects,rarity,food)
		@type = :food if food
		super(1,0,effects,rarity,0,:none)
		@name = name
	end

	def eatable?
		@type == :food
	end

	def medkit?
		@type == :medkit
	end

	def use
		cant_use = false
		message = []
		message[0] = ""
		@effects.each do |fx|
			case fx
			when :heal_hp, :heal_mp
				temp = Redenik::Balance::ITEM_USE_FX_BY_RARITY[@rarity][fx]

				if Redenik.player.health < Redenik.player.max_health
					cant_use = false
					amount = rand( temp.first...temp.last )
					Redenik.player.recover_health( amount )
					message.push format(Redenik::Translation::Russian::USE_ITEM[:recover_health],amount)
				elsif Redenik.player.mana < Redenik.player.max_mana
					cant_use = false
					amount = rand( temp.first...temp.last )
					Redenik.player.recover_mana( amount )
					message.push format(Redenik::Translation::Russian::USE_ITEM[:recover_mana],amount)
				else
					cant_use = true
				end
			end
		end
		if cant_use
			message[0] = format(Redenik::Translation::Russian::USE_ITEM[:message_start],@name)
		else
			message[0] = format(Redenik::Translation::Russian::USE_ITEM[:message_failed],@name)
			dispose
		end
		Redenik::message_stack.push message.join("")
		return cant_use
	end
end