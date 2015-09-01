# encoding utf-8

module Redenik::GameManager
	class << self
		def start
			@stack = []
			self.call(Redenik::GameManager::Screen_Title)
			@started = true
		end

		def main
			start if not @started
			update_scene
		end

		def quit
			exit
		end

		def setup_scene(scene)
			@stack << scene.new(Time.now)
		end

		def update_scene
			@stack.last.update
		end

		def dispose_scene
			@stack.last.dispose
			if @stack.size>0
				@stack.pop
			else
				quit
			end
		end

		def call(scene)
			setup_scene(scene)
		end

		def goto(scene)
			@stack.each{|screen|screen.dispose}
			@stack.clear
			setup_scene(scene)
		end

		def cancel
			dispose_scene
		end
	end
end