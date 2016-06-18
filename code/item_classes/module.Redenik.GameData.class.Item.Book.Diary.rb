# encoding utf-8

class Redenik::GameData::Item::Book::Diary < Redenik::GameData::Item::Book
	def _load_icon_by_type
		super("./gfx/icons/book/diary")
	end
end