# encoding utf-8

class Redenik::GameManager::Screen_Menu_Base < Redenik::GameManager::Screen_Base
	def update
		super
		fire___ok if Input.trigger?(:C)
		fire___cancel if Input.trigger?(:B)
	end

	def fire___ok
		#
	end

	def fire___cancel
		Redenik::GameManager.cancel
	end
end