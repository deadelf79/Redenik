# encoding utf-8

class Redenik::Key  < Redenik::BasicItem
	def initialize(rarity)
		@rarity = rarity
		@price	= 0
		@weight = 0.1
		@name = format(Redenik::Translation::Russian.KEYS[:key],Redenik::Translation::Russian.KEYS[@rarity])
	end
end