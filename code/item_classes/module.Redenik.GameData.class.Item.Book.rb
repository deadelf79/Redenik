# encoding utf-8

# 
class Redenik::GameData::Item::Book < Redenik::GameData::Item
	def initialize(filename)
		name		= ''
		effects		= []
		rarity		= :common
		consumable	= false
		food		= false
		super(name,effects,rarity,consumable,food)

		if filename.is_a?(String)&&filename!=''
			@nobook = false
			@book_data = open(filename,"r").readlines
		else
			@nobook = true
			@book_data = [""]
		end

		_load_book_name
		_load_book_icon
	end

	private

	def _use_item(actor)
		Redenik::GameManager::goto(Redenik::GameManager::Screen_ReadBook(self))
		cant_use = false
		cause = []
		return [cant_use,cause]
	end

	def _load_icon_by_type
		if self.class.lowercase == "book"
			super("./gfx/icons/#{self.class.lowercase}")
		else
			super("./gfx/icons/book/#{self.class.lowercase}")
		end
	end

	def _gen_help_info
		
	end

	def _load_book_name
		if @nobook
			if @name==""
				name =""
				loop do
					name = Redenik::NameGen.make_name(4,8)
					break if not Redenik.nameslist_books.include?(name)
				end
				Redenik.nameslist_books.push name
				@name = name
			end
		else
			@book_data.each do |line|
				if line =~ /name\=/
					new_name = line.match(/name\=(.+)\n/)
					@name = new_name
				end
			end
		end
	end

	def _load_book_icon
		return if @nobook
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