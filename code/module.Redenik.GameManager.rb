# encoding utf-8

module Redenik::GameManager
	class << self
		attr_accessor :debug_canvas
		
		def start
			# Специально для визуальной отладки
			@debug_canvas = Redenik::Graphics::Image.new(0,0,Graphics.width,Graphics.height)
			@debug_canvas.z = 9999
			@debug_canvas.visible = $TEST

			# Стек-машина этого менеджера
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
			rescue Exception => error
				msgbox "Error when call scene '#{scene}': #{error}. Because of:\n#{error.backtrace.join("\n")}"
			end
		end

		def goto(scene)
			@stack.each{|screen|screen.dispose}
			@stack.clear
			begin
				wr "Screen '#{scene.inspect}' created for...",0
				setup_scene(scene)
				wr "#{@stack.last.creation_time} ms"
			rescue Exception => error
				msgbox "Error when call scene '#{scene}': #{error}. Because of:\n#{error.backtrace.join("\n")}"
			end
		end

		def cancel
			dispose_scene
		end
	end
end