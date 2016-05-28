#encoding utf-8

class Redenik::DressingPerson < Redenik::Person
	def initialize(name,appearance,stats,equips={})
		super(name,appearance,stats)
		@equips = {
			torso:nil,
			head:nil,
			left_hand:nil,
			right_hand:nil,
			left_shoulder:nil,
			right_shoulder:nil,
			neck:nil,
			left_greave:nil,
			right_greave:nil,
			left_shoe:nil,
			right_shoe:nil
		}

		@equips[:torso] 			= equips[:torso] 			unless equips[:torso].nil?
		@equips[:head] 				= equips[:head] 			unless equips[:head].nil?
		@equips[:left_hand] 		= equips[:left_hand] 		unless equips[:left_hand].nil?
		@equips[:right_hand] 		= equips[:right_hand] 		unless equips[:right_hand].nil?
		@equips[:left_shoulder] 	= equips[:left_shoulder] 	unless equips[:left_shoulder].nil?
		@equips[:right_shoulder] 	= equips[:right_shoulder] 	unless equips[:right_shoulder].nil?
		@equips[:neck] 				= equips[:neck] 			unless equips[:neck].nil?
		@equips[:left_greave] 		= equips[:left_greave] 		unless equips[:left_greave].nil?
		@equips[:right_greave] 		= equips[:right_greave] 	unless equips[:right_greave].nil?
		@equips[:left_shoe] 		= equips[:left_shoe] 		unless equips[:left_shoe].nil?
		@equips[:right_shoe] 		= equips[:right_shoe] 		unless equips[:right_shoe].nil?
	end

	def torso
		item = @equips[:torso]
		item
	end

	def head
		item = @equips[:head]
		item
	end

	def left_hand
		item = @equips[:left_hand]
		item
	end

	def right_hand
		item = @equips[:right_hand]
		item
	end

	def left_shoulder
		item = @equips[:left_shoulder]
		item
	end

	def right_shoulder
		item = @equips[:right_shoulder]
		item
	end

	def neck
		item = @equips[:neck]
		item
	end

	def left_greave
		item = @equips[:left_greave]
		item
	end
	 # наголенник
	def right_greave
		item = @equips[:right_greave]
		item
	end

	def left_shoe
		item = @equips[:left_shoe]
		item
	end

	def right_shoe
		item = @equips[:right_shoe]
		item
	end

	def torso=(value)
		@equips[:torso] = value
	end

	def head=(value)
		@equips[:head] = value
	end

	def left_hand=(value)
		@equips[:left_hand] = value
	end

	def right_hand=(value)
		@equips[:right_hand] = value
	end

	def left_shoulder=(value)
		@equips[:left_shoulder] = value
	end

	def right_shoulder=(value)
		@equips[:right_shoulder] = value
	end

	def neck=(value)
		@equips[:neck] = value
	end

	def left_greave=(value)
		@equips[:left_greave] = value
	end

	def right_greave=(value)
		@equips[:right_greave] = value
	end

	def left_shoe=(value)
		@equips[:left_shoe] = value
	end

	def right_shoe=(value)
		@equips[:right_shoe] = value
	end
end