# encoding utf-8

class Redenik::BasicItem < Redenik::Basic
	attr_accessor :rarity, :price, :icon_index, :weight
	attr_reader :help_info
	def initialize(health,mana,effects,rarity,start_price,type)
		super(health,mana,effects,0)
		@name = Redenik::NameGen.make_name(3,4)

		@appearance = {
			icon:nil
		}
		_load_icon_by_type
		_gen_help_info

		@disposed = false
	end

	def help_info=(new_text)
		@help_info = new_text
	end

	def icon
		@appearance[:icon]
	end

	def dispose
		@disposed = true
	end

	def disposed?
		@disposed
	end

	private

	def _load_icon_by_type
		item_fx = []
		@effects.each{|fx|
			case fx
			when :heal_hp
				item_fx += ["hp"]
			when :heal_mp
				item_fx += ["mp"]
			when :food
				item_fx += ["food"]
			when :poison
				item_fx += ["poison"]
			when :rotten
				item_fx += ["rotten"]
			end
		}

		# все иконки расположены в папке Gfx/Icons/items
		# Если предмет - еда
		if item_fx.include? "food"
			if item_fx.include? "hp"
				@appearance[:icon] = "healing_food"
			elsif item_fx.include? "mp"
				@appearance[:icon] = "mana_food"
			elsif item_fx.include? "poison"
				@appearance[:icon] = "poisoned_food"
			elsif item_fx.include? "rotten"
				@appearance[:icon] = "rotten_food"
			else
				@appearance[:icon] = "food_only"
			end
		# Если предмет - бутылочка с жидкостью
		else
			@appearance[:icon] = "random_bottle_#{rand(8)}"
		end
	end

	def _gen_help_info
		@help_info =	case @type
						when :heal_hp
							#Redenik::NameGen.make_info()
						when :heal_mp

						when :food
						end
	end
end