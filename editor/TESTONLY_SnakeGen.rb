class Room
	attr_accessor :x, :y, :width, :height
	def initialize(x,y,width,height)
		@x,@y,@width,@height = x,y,width,height
	end
end

class Exit
	attr_accessor :x, :y
	def initialize(x,y)
		@x,@y = x,y
	end
end

class Coridor
	attr_accessor :x1,:y1,:x2,:y2
	def initialize(x1,y1,x2,y2)
		@x1,@y1,@x2,@y2 = x1,y1,x2,y2
	end
end

max_map = 100
rooms = []
exits = []
rooms[0] = Room.new( rand(20..max_map-20), rand(20..max_map-20), rand(5..9), rand(5..9) )
direction = :up#[:up,:left,:right,:down].sample
case direction
when :up
	x = rand(rooms.last.x+1..rooms.last.x-1)
	y = rooms.last.y
	if x>0&&x-6>0
		if x<max_map&&x+6<max_map
			dest_x = x + rand(-6..6)
		else
			dest_x = x + rand(-10..0)
		end
	else
		if x<max_map&&x+6<max_map
			dest_x = x + rand(0..10)
		else
			dest_x = x
		end
	end
	if y>0&&y-10>0
		dest_y = y + rand(-10..0)
	else
		dest_y = y + rand(0..15)
	end
	exits.push Exit.new(x,y)
	exits.push Exit.new(dest_x,dest_y)
end

file = open()