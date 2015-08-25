# encoding utf-8

class Redenik::Person < Redenik::Basic
	attr_reader :name, :appearance, :stats :equips
	attr_reader :exp, :level
	def initialize(name,appearance,stats,equips);end
	def update;end

	# Сильный?
	def strong?;end
	
	# Слабый?
	def weak?;end
	
	# Умный?
	def smart?;end
	
	# Глупый?
	def stupid?;end
	
	# Проворный?
	def agile?;end
	
	# Неуклюжий?
	def clumsy?;end
	
	# Живучий?
	def survivable?;end

	# Нежизнеспособный?
	def unviable?;end

	private 

	def _check_hungry;end
	def _gen_actor_by_stats(stats);end
end