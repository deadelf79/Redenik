# encoding utf-8

module Redenik::GameManager
	class << self
		def start
			@stack = []
			setup_first_scene
			@started = true
		end

		def main
			start if not @started
			update_scene while !empty?
		end

		def quit
			exit
		end

		def setup_first_scene
			self.call(Redenik::GameManager::Screen_Title)
		end

		def setup_scene(scene)
			@stack << scene.new(Time.now)
		end

		def update_scene
			@stack.last.update
		end

		def dispose_scene
			@stack.last.dispose
			!empty? ? @stack.pop : quit
		end

		def empty?
			@stack.size == 0
		end

		def call(scene)
			begin
				wr "Screen '#{scene.inspect}' created for...",0
				setup_scene(scene)
				wr "#{@stack.last.creation_time} ms"
			rescue => error
				msgbox "Error when call scene '#{scene}': #{error}. Because of:\n#{error.backtrace.join("\n")}"
			end
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