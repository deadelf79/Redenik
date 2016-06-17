# encoding utf-8

class Redenik::Person < Redenik::Basic
	FEATURES___TOO_LOW	= (1..3)
	FEATURES___LOW 		= (4..8)
	FEATURES___NORMAL 	= (9..11)
	FEATURES___HIGH 	= (12..16)
	FEATURES___SUPERB 	= (17..20)
	LEVEL___MAXIMUM		= 100

	attr_reader :appearance, :stats, :equips
	attr_reader :exp, :level, :skills, :sex, :gender
	attr_reader :hungriness, :max_hungriness
	attr_reader :drunkenness, :max_drunkenness
	attr_reader :feel_monsters, :feel_traps
	attr_reader :can_carry_weight
	def initialize(name,appearance,stats)
		@name, @appearance, @stats = name, appearance, stats
		@level = 1
		@current_exp = 0

		@surname, @secondname = "", ""
		@sex, @gender = :male, :getero
		@drunkenness, @max_drunkenness = 0, 100

		@base_exp			= rand(10..30)
		@divider 			= 3
		@late_game_modifier = 1.2345
		@exp_curve_storage  = []
		_generate_exp_curve
		_gen_actor_by_stats(stats)
		reset_exp

		super(0,0,[],0)
	end

	def reset_exp(level=:current)
		@level = 1 unless level==:current
		_reset_exp(@level)
	end

	def exp_curve(level)
		range = @exp_curve_storage[level]
	end

	def recover
		@health = @max_health
		@mana = @max_mana
		@hungriness = 0
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
		return false if stats[:st]>=FEATURES___NORMAL.first
		true
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
		return false if stats[:dx]>=FEATURES___NORMAL.first
		true
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
		return false if stats[:iq]>=FEATURES___NORMAL.first
		true
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
		return false if stats[:ht]>=FEATURES___NORMAL.first
		true
	end

	# Очаровательный?
	def charming?
		return false if stats[:cr]<FEATURES___NORMAL.first
		return false if stats[:cr]<=FEATURES___NORMAL.last
		true
	end
	
	# Грубый?
	def rough?
		return false if stats[:cr]>=FEATURES___NORMAL.first
		true
	end

	private 

	def _check_hungry
		return :too_hungry if @hungriness>@max_hungriness*4/5
		return :not_so_hungry if @hungriness<@max_hungriness*3 /5
		return :hungry
	end

	def _gen_actor_by_stats(stats)
		@max_health = stats[:ht]*3+stats[:ht]*stats[:st]-stats[:cr]*3
		@max_mana = stats[:iq]*3+stats[:ht]*3+stats[:cr]-stats[:dx]
		@max_melee = stats[:st]*3-stats[:ht]*2
		@max_hungriness = (stats[:ht]*12-stats[:st]*6+stats[:dx]*4)*2

		@atk_evade_chance = stats[:dx]*3-stats[:iq]*2 # in percent
		@can_carry_weight = stats[:st]*3+stats[:dx]/3 # in kg
		@feel_traps_chance = [stats[:iq]*3-stats[:dx]*2, 0].max # in percent
		@gold_modifier = (stats[:dx]*3-stats[:iq]*3).abs # in percent
		
		@gold_reward_modifier = [stats[:cr]-stats[:iq],0].max # in percent
		@shop_cost_modifier = [stats[:cr]*2-stats[:iq]*2,0].max # in percent
		@conviction_modifier = [stats[:ht]*2+stats[:iq]*3-stats[:cr]*3,0].max # in percent, шанс убеждения

		recover
	end

	def _reset_exp(level)
		@exp = exp_curve(level).first
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