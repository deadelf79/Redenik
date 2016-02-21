#encoding utf-8

class Redenik::DressingPerson < Redenik::Person
	def initialize(name,appearance,stats,equips)
		super(name,appearance,stats,equips)
	end
	def torso;end
	def head;end
	def left_hand;end
	def right_hand;end
	def left_shoulder;end
	def right_shoulder;end
	def neck;end
	def left_greave;end # наголенник
	def right_greave;end
	def left_shoe;end
	def right_shoe;end
end