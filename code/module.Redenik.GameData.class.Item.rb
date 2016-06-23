#encoding utf-8

# 
class Redenik::GameData::Item < Redenik::GameData::BasicItem
	def initialize(name,effects,rarity,consumable,food=false)
		@type = food ? :food : :none
		super(1,0,effects,rarity,0,@type)
		@name = name
		@consumable = consumable

		@alcohol_modifier = false
		@raise_stats_modifier = {
			st:0,
			dx:0,
			iq:0,
			ht:0,
			cr:0
		}
		_load_weight
	end

	def eatable?
		@type == :food
	end

	def medkit?
		@type == :medkit
	end
	
	def consumable?
		@consumable
	end

	def use(actor)
		cant_use		= false
		message			= []
		message[0]		= ""
		result			= _use_item(actor)
		cant_use		= result[0]
		cant_use_cause	= result[1]

		if cant_use
			message[0] = format(Redenik::Translation::Russian::USE_ITEM[:message_start],@name)
			message.push cant_use_cause.join(" ")
		else
			message[0] = format(Redenik::Translation::Russian::USE_ITEM[:message_failed],@name)
			#dispose
		end
		Redenik::message_stack.push message.join(" ")
		return cant_use
	end

	private

	def _use_item(actor)
		cant_use = false
		cause = []
		return [cant_use,cause]
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

	def _gen_help_info
		# этот метод будет перезаписываться потомками, но тут лежит основа
		info = []
		self.help_info = info.join(" ")
	end
	
	def _load_weight
		@weight = Redenik::Balance::ITEM_WEIGHTS[:default]
	end
end