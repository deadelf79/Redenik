# encoding utf-8

class Redenik::Graphics::Static_Map < Redenik::Graphics::Map
	def initialize(id,filename)
		file = open('data/maps/'+filename+'.static_map',"rb")
		super( id, 11, 11, :safe, 1, 2 )

		start_read = false
		@data.clear

		file.readlines.each{|line|
			if line=~/begindata/
				start_read = true
			elsif line=~/enddata/
				start_read = false
				break
			end
			if start_read
				index = @data.add_line
				@data[index] = line
			end
		}
		self
	end
end