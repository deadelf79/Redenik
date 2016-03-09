class Vector
	attr_accessor :x, :y, :direction
	def initialize(x, y, direction)
		@x, @y, @direction = x, y, direction
	end

	def ==(value)
		return false unless value.is_a? Point
		return true if x==value.x && y==value.y
		return false
	end
end

class Line
	attr_accessor :sx, :sy, :ex, :ey
	def initialize(sx, sy, ex, ey)
		@sx, @sy, @ex, @ey = sx, sy, ex, ey
	end
end

class Room
	def initialize(x, y, width, height)
		@x, @y, @width, @height = x, y, width, height
		@door = Vector.new(@x,@y,:up)
		@doors = []
	end
	
	def add_door(direction)
		return if @doors.include? direction
		@doors.push direction
		#@door.direction = direction
		case direction
			when :up
				@door.x = rand(@x...@width)
				@door.y = @y
			when :left
				@door.x = @x
				@door.y = rand(@y...@height)
			when :right
				@door.x = @x
				@door.y = rand(@y...@height)
			when :down
				@door.x = rand(@x...@width)
				@door.y = @y
		end
	end

	def door
		@door
	end
end

# TEST ONLY
begin
	max_rooms = 20
	max_width = 50
	max_height = 50
	min_size = 3
	max_size = 6
	min_worm = 4
	max_worm = 8
	rooms = []
	worm = []

	x = rand(min_size...max_width-max_size-min_size)
	y = rand(min_size...max_height-max_size-min_size)
	wh = rand(min_size...max_size)
	rooms.push Room.new(x,y,wh,wh)
	
	for i in 1...max_rooms
		rand_direction = [:up,:left,:right,:down].sample
		rooms.last.add_door(rand_direction)
		door = rooms.last.door
		case door.direction
			when :up
				x1 = door.x
				x2 = door.x
				y1 = door.y
				y2 = door.y - rand(min_worm...max_worm)
				worms.push Line.new(x1,y1,x2,y2)
			when :left
				x1 = 
				x2 = 
				y1 = door.y
				y2 = door.y
				worms.push Line.new(x1,y1,x2,y2)
			when :right
				x1 = 
				x2 = 
				y1 = door.y
				y2 = door.y
				worms.push Line.new(x1,y1,x2,y2)
			when :down
				x1 = door.x
				x2 = door.x
				y1 = 
				y2 = 
				worms.push Line.new(x1,y1,x2,y2)
		end
	end
end