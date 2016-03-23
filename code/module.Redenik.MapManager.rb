#encoding utf-8

module Redenik::MapManager
	class << self
		def make_tutorial_map(player_class,stat)
			case player_class
			when :warrior
				case stat
				when :st
					_tutorial___warrior_st
				when :dx
					_tutorial___warrior_dx
				when :iq
					_tutorial___warrior_iq
				when :ht
					_tutorial___warrior_ht
				when :cr
					_tutorial___warrior_cr
				end
			when :mage
				case stat
				when :st
					_tutorial___mage_st
				when :dx
					_tutorial___mage_dx
				when :iq
					_tutorial___mage_iq
				when :ht
					_tutorial___mage_ht
				when :cr
					_tutorial___mage_cr
				end
			when :thief
				case stat
				when :st
					_tutorial___thief_st
				when :dx
					_tutorial___thief_dx
				when :iq
					_tutorial___thief_iq
				when :ht
					_tutorial___thief_ht
				when :cr
					_tutorial___thief_cr
				end
			when :trader
				case stat
				when :st
					_tutorial___trader_st
				when :dx
					_tutorial___trader_dx
				when :iq
					_tutorial___trader_iq
				when :ht
					_tutorial___trader_ht
				when :cr
					_tutorial___trader_cr
				end
			when :citizen
				case stat
				when :st
					_tutorial___citizen_st
				when :dx
					_tutorial___citizen_dx
				when :iq
					_tutorial___citizen_iq
				when :ht
					_tutorial___citizen_ht
				when :cr
					_tutorial___citizen_cr
				end
			end
		end

		private

		def _tutorial___warrior_st
			player = Redenik.player
			if player.stupid?

			elsif player.smart?

			else

			end
		end

		def _tutorial___warrior_dx;end
		def _tutorial___warrior_iq;end
		def _tutorial___warrior_ht;end
		def _tutorial___warrior_cr;end

		def _tutorial___mage_st;end
		def _tutorial___mage_dx;end
		def _tutorial___mage_iq;end
		def _tutorial___mage_ht;end
		def _tutorial___mage_cr;end

		def _tutorial___thief_st;end
		def _tutorial___thief_dx;end
		def _tutorial___thief_iq;end
		def _tutorial___thief_ht;end
		def _tutorial___thief_cr;end

		def _tutorial___trader_st;end
		def _tutorial___trader_dx;end
		def _tutorial___trader_iq;end
		def _tutorial___trader_ht;end
		def _tutorial___trader_cr;end

		def _tutorial___citizen_st;end
		def _tutorial___citizen_dx;end
		def _tutorial___citizen_iq;end
		def _tutorial___citizen_ht;end
		def _tutorial___citizen_cr;end
	end
end