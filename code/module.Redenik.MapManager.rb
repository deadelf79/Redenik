#encoding utf-8

module Redenik::MapManager
	class << self
		def make_tutorial_map(player_class,stat)
			instance_eval("_tutorial___#{player_class.to_s}_#{stat}")
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