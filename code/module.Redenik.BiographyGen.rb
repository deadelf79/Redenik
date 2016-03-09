# encoding utf-8

module BiographyGen
	class << self
		def prepare
			@data = {
				name:"Василий",
				age:18,
				sex:(:male),
				gender:(:getero),
				surname:"Пупкин",
				secondname:"Иванович",
				orphan:false,
				widower:false,
				childrens:false,
			}
		end

		def actor=(value)
			@data[:name] 		= value.name
			@data[:age] 		= value.age
			@data[:sex] 		= value.sex
			@data[:gender] 		= value.gender
			@data[:surname] 	= value.surname
			@data[:secondname] 	= value.secondname
		end

		def orphan=(value)
			@data[:orphan] = value
		end

		def widower=(value)
			@data[:widower] = value
		end

		def childrens=(value)
			@data[:childrens] = value
		end

		def generate
			story = []
			return story.join("\s")
		end
	end
end