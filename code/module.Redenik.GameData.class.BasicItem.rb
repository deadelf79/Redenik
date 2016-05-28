# encoding utf-8

class Redenik::GameData::BasicItem < Redenik::GameData::Basic
	attr_accessor :rarity, :price, :icon_index, :weight
	attr_reader :help_info
	def initialize(health,mana,effects,rarity,start_price,type)
		# вызов родителя 
		super(health,mana,effects,0)
		
		# создание переменных
		@name = "" # нужно генерировать имя в соответствии с эффектом
		@help_info = ""
		@appearance = {
			icon:nil,
			font:{
				name:"",
				color:Color.new(255,255,255),
				bold:false,
				italic:false
			}
		}
		@effects = []
		@disposed = false

		# вызов методов 
		_load_icon_by_type
		_gen_help_info
	end

	def help_info=(new_text)
		@help_info = new_text
	end

	def icon
		@appearance[:icon]
	end

	def dispose
		@disposed = true
	end

	def disposed?
		@disposed
	end

	def use
		# этот метод будет перезаписываться потомками
	end

	private

	def _load_icon_by_type
		# этот метод будет перезаписываться потомками
	end

	def _gen_help_info
		# этот метод будет перезаписываться потомками
	end
end