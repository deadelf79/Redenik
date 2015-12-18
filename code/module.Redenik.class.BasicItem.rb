# encoding utf-8

class Redenik::BasicItem < Redenik::Basic
	attr_accessor :rarity, :price, :icon_index, :weight
	attr_reader :help_info
	def initialize(health,mana,effects,rarity,start_price,type)
		super(health,mana,effects,0)
		@name = Redenik::NameGen.make_name(3,4)
		_gen_help_info
	end

	def help_info=(new_text)
		@help_info = new_text
	end

	private

	def _gen_help_info
		@help_info =	case @type
						when :heal_hp
							#Redenik::NameGen.make_info()
						when :heal_mp

						when :food
						end
	end
end