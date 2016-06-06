# encoding utf-8

class Redenik::GameData::Item::Book::Comics < Redenik::GameData::Item::Book
	def initialize(filename)
		super(filename)
	end

	private

	def _load_icon_by_type
		super("./gfx/icons/book/comics")
	end

	def _gen_help_info
		
	end
end