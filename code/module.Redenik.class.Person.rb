# encoding utf-8

class Redenik::Person < Redenik::Basic
	FEATURES___TOO_LOW	= (1..3)
	FEATURES___LOW 		= (4..7)
	FEATURES___NORMAL 	= (8..12)
	FEATURES___HIGH 	= (13..16)
	FEATURES___SUPERB 	= (17..20)
	LEVEL___MAXIMUM		= 100

	attr_reader :name, :appearance, :stats :equips
	attr_reader :exp, :level
	def initialize(name,appearance,stats,equips)
		@name, @appearance, @stats, @equips = name, appearance, stats, equips
		@level = 1

		@base_exp			= rand(10..30)
		@divider 			= 3
		@late_game_modifier = 1.2345
		@exp_curve_storage  = []
		_generate_exp_curve
		_reset_exp
	end

	def exp_curve(level)
		range = @exp_curve_storage[level]
	end

	def update
		super
	end

	# Сильный?
	# Является ли характеристика ST выше нормальной (по умолчанию - от 13 и более)
	def strong?
		return false if stats[:st]<FEATURES___NORMAL.first
		return false if stats[:st]<=FEATURES___NORMAL.last
		true
	end
	
	# Слабый?
	def weak?

	end
	
	# Проворный?
	# Является ли характеристика DX выше нормальной (по умолчанию - от 13 и более)
	def agile?
		return false if stats[:dx]<FEATURES___NORMAL.first
		return false if stats[:dx]<=FEATURES___NORMAL.last
		true
	end
	
	# Неуклюжий?
	def clumsy?

	end

	# Умный?
	# Является ли характеристика IQ выше нормальной (по умолчанию - от 13 и более)
	def smart?
		return false if stats[:iq]<FEATURES___NORMAL.first
		return false if stats[:iq]<=FEATURES___NORMAL.last
		true
	end
	
	# Глупый?
	def stupid?

	end
	
	# Живучий?
	# Является ли характеристика HT выше нормальной (по умолчанию - от 13 и более)
	def survivable?
		return false if stats[:ht]<FEATURES___NORMAL.first
		return false if stats[:ht]<=FEATURES___NORMAL.last
		true
	end

	# Нежизнеспособный?
	def unviable?

	end

	private 

	def _check_hungry;end
	def _gen_actor_by_stats(stats);end

	def _reset_exp
		@exp = exp_curve(@level).first
	end

	def _generate_exp_curve
		value = @base_exp
		LEVEL___MAXIMUM.times{|i|
			value+=(i.to_f/@divider).to_i+(i*@late_game_modifier).to_i+@base_exp
			last = value + ((level+1).to_f/@divider).to_i+((level+1)*@late_game_modifier).to_i+@base_exp
			@exp_curve_storage[i] = (value...last)
		}
		@exp_curve_storage
	end
end