# encoding utf-8

class Redenik::GameManager::Screen_Menu_Base < Redenik::GameManager::Screen_Base
	def fire___ok
		#
	end

	def fire___cancel
		Redenik::GameManager.cancel
	end
end