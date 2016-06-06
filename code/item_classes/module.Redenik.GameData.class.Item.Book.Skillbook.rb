# encoding utf-8

class Redenik::GameData::Item::Book::Comics < Redenik::GameData::Item::Book
	def initialize(filename)
		super(Redenik::NameGen.make_name(4,8),[],:common,false)

		@book_data = open(filename,"r").readlines
	end

	private

	def _use_item
		Redenik::GameManager::goto(Redenik::GameManager::Screen_ReadBook(self))
	end

	def _load_icon_by_type
		entries = Dir.open("./gfx/icons/book/comics").entries
		iconname = ""
		loop do
			iconname = entries.sample
			break if iconname=~/(png|jp[e]?g)$/
		end

		@icon = Redenik::Graphics::Image.safety_open(
			iconname,
			Rect(0,0,Redenik::SystemData::ICONSIZE,Redenik::SystemData::ICONSIZE),
			Color.new(255,255,255,64)
		)
	end

	def _gen_help_info
		
	end
end