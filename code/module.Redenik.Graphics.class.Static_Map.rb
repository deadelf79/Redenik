# encoding utf-8

class Redenik::Graphics::Static_Map < Redenik::Graphics::Map
	def initialize(id,filename)
		file = open('data/maps/'+filename+'.static_map',"rb")
		width, height = 10, 10
		start_x, start_y = 0,0
		file.readlines.each do |line|
			width  = line[/dataw[\s](\d+)/] if line=~/dataw/
			height = line[/datah[\s](\d+)/] if line=~/datah/

		end

		super( id, width.to_i, height.to_i, :safe, 1, 2 )

		@data.clear
		arr = file.readlines

		arr.each do |line|
			if line=~/beginmapdata/
				h_index = 0
				for read_index in arr.index_of(line)...arr.size
					break if arr[read_index]=~/endmapdata/
					w_index = 0
					line.slice(/\t/).each do |tile|
						@data[w_index,h_index]=tile
						w_index += 1
					end
					h_index+=1
				end
			end
		end
		self
	end
end