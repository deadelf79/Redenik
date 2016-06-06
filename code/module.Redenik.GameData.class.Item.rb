#encoding utf-8

class Redenik::GameData::Item < Redenik::GameData::BasicItem
	def initialize(name,effects,rarity,food=false)
		@type = food ? :food : :none
		super(1,0,effects,rarity,0,@type)
		@name = name

		@alcohol_modifier = false
		@raise_stats_modifier = {
			st:0,
			dx:0,
			iq:0,
			ht:0,
			cr:0
		}

	end

	def eatable?
		@type == :food
	end

	def medkit?
		@type == :medkit
	end

	def use(actor)
		cant_use = false
		message = []
		message[0] = ""
		_use_item(actor)

		if cant_use
			message[0] = format(Redenik::Translation::Russian::USE_ITEM[:message_start],@name)
		else
			message[0] = format(Redenik::Translation::Russian::USE_ITEM[:message_failed],@name)
			dispose
		end
		Redenik::message_stack.push message.join("")
		return cant_use
	end

	private

	def _use_item(actor)
		# @effects.each do |fx|
		# 	case fx
		# 	when :heal_hp, :heal_mp
		# 		temp = Redenik::Balance::ITEM_USE_FX_BY_RARITY[@rarity][fx]

		# 		if Redenik.player.health < Redenik.player.max_health
		# 			cant_use = false
		# 			amount = rand( temp.first...temp.last )
		# 			Redenik.player.recover_health( amount )
		# 			message.push format(Redenik::Translation::Russian::USE_ITEM[:recover_health],amount)
		# 		elsif Redenik.player.mana < Redenik.player.max_mana
		# 			cant_use = false
		# 			amount = rand( temp.first...temp.last )
		# 			Redenik.player.recover_mana( amount )
		# 			message.push format(Redenik::Translation::Russian::USE_ITEM[:recover_mana],amount)
		# 		else
		# 			cant_use = true
		# 		end
		# 	end
		# end
	end

	def _load_icon_by_type(dir)
		entries = Dir.open(dir).entries
		iconname = ""
		loop do
			iconname = entries.sample
			break if iconname=~/(png|jp[e]?g)$/
		end

		@icon = Redenik::Graphics::Image.safety_open(
			iconname,
			Rect(0,0,Redenik::SystemData::ICONSIZE,Redenik::SystemData::ICONSIZE),
			Color.new(255,255,255,64)
		)
	end
end