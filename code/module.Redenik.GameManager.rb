# encoding utf-8

module Redenik::GameManager
	class << self
		attr_accessor :debug_canvas
		attr_accessor :pointer
		
		def start
			# Специально для визуальной отладки
			@debug_canvas = Redenik::Graphics::Image.new(0,0,Graphics.width,Graphics.height)
			@debug_canvas.z = 9999
			@debug_canvas.visible = $TEST||$BTEST||$DEBUG

			# Курсор мыши
			@pointer = Redenik::Graphics::Mouse.new

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
			self.call( Redenik::GameManager::Screen_Title )
		end

		def setup_scene( scene, *args )
			@stack << scene.new( Time.now, *args )
		end

		def update_scene
			@pointer.update unless @pointer.nil?
			@stack.last.update
		end

		def dispose_scene
			@stack.last.dispose
			!empty? ? @stack.pop : quit
		end

		def empty?
			@stack.size == 0
		end

		def call(scene,*args)
			begin
				setup_scene(scene)
				wr "Screen '#{scene.inspect}' created for #{@stack.last.creation_time} ms"
			rescue Exception => error
				msgbox "Error when call scene '#{scene}': #{error}. Because of:\n#{error.backtrace.join("\n")}"
			end
		end

		def goto(scene,*args)
			@stack.each{|screen|screen.dispose}
			@stack.clear
			begin
				setup_scene(scene)
				wr "Screen '#{scene.inspect}' created for #{@stack.last.creation_time} ms"
			rescue Exception => error
				msgbox "Error when call scene '#{scene}': #{error}. Because of:\n#{error.backtrace.join("\n")}"
			end
		end

		def cancel
			dispose_scene
		end
	end
end