class Point
	attr_accessor :x, :y
	def initialize(x, y)
		@x, @y = x, y
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

class Rect
	attr_accessor :x, :y, :width, :height
	def initialize(x, y, width, height)
		@x, @y, @width, @height = x, y, width, height
	end
end

class Leaf
	attr_accessor :min_size, :min_room, :room, :worms
	attr_reader :left, :right, :x, :y, :width, :height
	def initialize(x, y, width, height)
		@min_size, @min_room, @worm_max = 6, 5, 6
		@left, @right = nil, nil
		@x, @y, @width, @height = x, y, width, height
		@room = nil
		@worms = []
	end

	def cut
		return false unless @left.nil?||@right.nil?
		return false if (@width-@min_size)<=@min_size||(@height-@min_size)<=@min_size
		side = @width > @height
		if side
			new_side = rand(@min_size...@width-@min_size)
			@left = Leaf.new(@x, @y, new_side, @height)
			@right = Leaf.new(@x + new_side, @y, @width - new_side, @height) 
		else
			new_side = rand(@min_size...@height-@min_size)
			@left = Leaf.new(@x, @y, @width, new_side)
			@right = Leaf.new(@x, @y + new_side, @width, @height - new_side)
		end
		return true
	end

	def fill
		return unless @left.nil?||@right.nil?
		room_x = rand(@x..@x + @width - @min_room)
		room_y = rand(@y..@y + @height - @min_room)
		room_width =  rand(@min_room..@width - (room_x - @x))
		room_height =  rand(@min_room..@height - (room_y - @y))

		@room = Rect.new(room_x, room_y, room_width, room_height)
	end

	def worm
		return if @left.nil?||@right.nil?
		return if @worms.size > 4

		if !@left.room.nil?&&!@right.room.nil?
			start_point = Point.new(
				rand(@left.room.x...@left.room.x + @left.room.width),
				rand(@left.room.y...@left.room.y + @left.room.height)
			)

			end_point = Point.new(
				rand(@right.room.x...@right.room.x + @right.room.width),
				rand(@right.room.y...@right.room.y + @right.room.height)
			)
		else
			start_point = Point.new(
				rand(@x...@x + @width),
				rand(@y...@y + @height)
			)

			end_point = Point.new(
				rand(@x...@x + @width),
				rand(@y...@y + @height)
			)
		end

		direction = :horizontal
		direction = :vertical if (end_point.x - start_point.x).abs < (end_point.y - start_point.y).abs
		loop do
			break if start_point == end_point
			case direction
			when :horizontal
				next_start = Point.new( start_point.x, start_point.y )
				if start_point.x < end_point.x
					if ( end_point.x - start_point.x ) < @worm_max
						next_start = Point.new( end_point.x, start_point.y )
					else
						next_start = Point.new( start_point.x + @worm_max, start_point.y )
					end
				elsif start_point.x > end_point.x
					if ( start_point.x - end_point.x ) < @worm_max
						next_start = Point.new( end_point.x, start_point.y )
					else
						next_start = Point.new( start_point.x - @worm_max, start_point.y )
					end
				else
					start_point = next_start
					direction = :vertical
					next
				end
				@worms.push Line.new(
					start_point.x,
					start_point.y,
					next_start.x,
					next_start.y
				)
				start_point = next_start
				direction = :vertical
			when :vertical
				next_start = Point.new( start_point.x, start_point.y )
				if start_point.y < end_point.y
					if ( end_point.y - start_point.y ) < @worm_max
						next_start = Point.new( start_point.x, end_point.y )
					elsif ( end_point.y - start_point.y ) > @worm_max
						next_start = Point.new( start_point.x, start_point.y  + @worm_max)
					end
				elsif start_point.y > end_point.y
					if ( start_point.y - end_point.y ) < @worm_max
						next_start = Point.new( start_point.x, end_point.y )
					elsif ( start_point.y - end_point.y ) > @worm_max
						next_start = Point.new( start_point.x, start_point.y - @worm_max )
					end
				else
					start_point = next_start
					direction = :horizontal
					next
				end
				@worms.push Line.new(
					start_point.x,
					start_point.y,
					next_start.x,
					next_start.y
				)
				start_point = next_start
				direction = :horizontal
			end
		end
	end
end

# TEST ZONE
# AUTHORIZED PERSONEL ONLY

mapsize = 50

@leafs = []
@leafs[0] = Leaf.new( 0, 0, mapsize, mapsize )

loop do
	cutted = false
	@leafs.each do |leaf|
		cutted = leaf.cut
		if cutted
			@leafs << leaf.left
			@leafs << leaf.right
		end
	end
	break unless cutted
end

@leafs.each { |leaf| leaf.fill }
@leafs.each { |leaf| leaf.worm }

open("text2image.txt", "w") do | file |

	@leafs.each { |leaf| file.write "leaf #{leaf.x.to_s.ljust(8)}#{leaf.y.to_s.ljust(8)}#{leaf.width.to_s.ljust(8)}#{leaf.height.to_s.ljust(8)}\n" }
	@leafs.each { |leaf| file.write "room #{leaf.room.x.to_s.ljust(8)}#{leaf.room.y.to_s.ljust(8)}#{leaf.room.width.to_s.ljust(8)}#{leaf.room.height.to_s.ljust(8)}\n" unless leaf.room.nil? }
	@leafs.each { |leaf|
		leaf.worms.each { |wormhole|
			file.write "worm #{wormhole.sx.to_s.ljust(8)}#{wormhole.sy.to_s.ljust(8)}#{wormhole.ex.to_s.ljust(8)}#{wormhole.ey.to_s.ljust(8)}\n"
			puts "#{wormhole.sx.to_s.ljust(8)}#{wormhole.sy.to_s.ljust(8)}#{wormhole.ex.to_s.ljust(8)}#{wormhole.ey.to_s.ljust(8)}\n"
		}
	}

end

puts "leaf count: #{@leafs.size}"
room_count = 0
@leafs.each { |leaf| room_count += 1 unless leaf.room.nil? }
puts "room count: #{room_count}"