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
		#
	end
end