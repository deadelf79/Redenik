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
		if alive?
			@health-=value
		end
	end

	def restore_health(value)
		@delta_health = (health-value).abs if alive?
	end

	def restore_mana(value)
		@delta_mana = (mana-value).abs if alive?
	end

	def use_mana(value)
		@mana-=value if alive?
	end

	def update
		if alive?
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
end