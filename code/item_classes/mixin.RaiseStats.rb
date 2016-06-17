module Redenik::GameData::Item::RaiseStats
	def mixin_initialize(stat,value,time)
		stat = :st unless [:st,:dx,:iq,:ht,:cr].include?
		value = [0,value].max
		value = [10,value].min
		@raiser = {
			st:0,
			dx:0,
			iq:0,
			ht:0,
			cr:0
		}
		@raiser[stat]+=value
		@time = [1,time].max
	end
	
	def mixin_use_item(actor)
		# не буду пока писать, я еше не придумал формат
		# Redenik::GameManager::FlowStack.push()
	end
end