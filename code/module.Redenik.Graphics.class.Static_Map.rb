# encoding utf-8

class Redenik::Graphics::Static_Map < Redenik::Graphics::Map
	def initialize(id,filename)
		file = open('data/maps/'+filename+'.static_map',"rb")
		super(id,width,height,type,min_level,max_level)

		@data = Table.new(10,10)
		(1...10).each do |index|
			@data[index,1] = 2
			@data[index,2] = 2
			@data[index,5] = 2
			@data[index,9] = 2
			@data[1,index] = 2
			@data[5,index] = 2
			@data[9,index] = 2
		end
	end
end