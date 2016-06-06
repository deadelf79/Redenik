# encoding utf-8

class Redenik::GameData::Item::Book < Redenik::GameData::Item
	def initialize(filename)
		super('',[],:common,false)

		@book_data = open(filename,"r").readlines

		_load_book_name
		_load_book_icon
	end

	private

	def _use_item
		Redenik::GameManager::goto(Redenik::GameManager::Screen_ReadBook(self))
	end

	def _load_icon_by_type
		super("./gfx/icons/book")
	end

	def _gen_help_info
		
	end

	def _load_book_name
		@book_data.each do |line|
			if line =~ /name\=/
				new_name = line.match(/name\=(.+)\n/)
				@name = new_name
			end
		end
	end

	def _load_book_icon
		@book_data.each do |line|
			if line =~ /icon\=/
				new_icon = line.match(/icon\=(.+)\n/)
				@icon = Redenik::Graphics::Image.safety_open(
					new_icon,
					Rect(0,0,Redenik::SystemData::ICONSIZE,Redenik::SystemData::ICONSIZE),
					Color.new(255,255,255,64)
				)
			end
		end
	end
end