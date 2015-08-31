# encoding utf-8

module GameManager
	class << self
		def start
			@stack = []
		end

		def main
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
	end
end