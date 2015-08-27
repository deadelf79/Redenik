# encoding utf-8

class Basic
	attr_accessor :health, :mana, :effects
	attr_accessor :gold_modifier
	def initialize(health,mana,effects,gold_modifier)
		@max_health, @max_mana, @effects, @gold_modifier = health, mana, effects, gold_modifier
		@health = @max_health
		@mana 	= @max_mana

		@delta_health = 0
		@delta_mana = 0
	end

	def dead?
		@health<=0
	end

	def alive?
		@health>0
	end

	def damage(value)
		@health-=value
	end

	def restore_health(value)
		@delta_health = (health-value).abs
	end

	def restore_mana(value)
		@delta_mana = (mana-value).abs
	end

	def use_mana(value)
		@mana-=value
	end

	def update
		if @delta_mana>0 then
			@delta_mana-=1
			@mana+=1 if @mana < @max_mana
		end

		if @delta_health>0 then
			@delta_health-=1
			@health+=1 if @health < @max_health
		end
	end
end