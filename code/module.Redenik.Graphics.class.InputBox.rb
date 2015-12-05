# encoding utf-8
class Redenik::Graphics::InputBox < Redenik::Graphics::UI_Component
	def initialize(x, y, width, height, initial_text="")
		super(x, y, width, height)
		@text = initial_text.nil? ? "" : initial_text

		@box = Redenik::Graphics::Image.new(0, 0, width, height, @main_viewport)
		@box.font.size = height - 4
		@box.font.name = "Tahoma"
		@box.z = self.z + 1
		refresh

		@pointer = Redenik::Graphics::Image.new(0, 2, 2, height - 4, @main_viewport)
		@pointer.z = self.z + 2
		@pointer.hide

		@pointer_blink = false
		_draw_pointer
		_repos_pointer
	end

	def clear
		@text = ""
		refresh
	end

	def refresh
		@box.clear
		@box.draw_text(@box.rect, @text, @box.white)
	end

	def z=(value)
		super
		@box.z = self.z + 1
		@pointer.z = self.z + 2
	end

	def update
		if @pointer_blink
			@pointer.opacity > 64 ? @pointer.opacity -= 8 : @pointer_blink = false
		else
			@pointer.opacity < 255 ? @pointer.opacity += 8 : @pointer_blink = true
		end

		_input_update
	end

	def begin_edit
		@pointer.show
		_repos_pointer
		_show_keyboard
	end

	def end_edit
		@pointer.hide
		_hide_keyboard
	end

	def edit_now?
		self.is_active?
	end

	private

	def _repos_pointer
		@pointer.x = @box.text_size(@text).width
	end

	def _show_keyboard

	end

	def _hide_keyboard

	end

	def _draw_pointer
		with @pointer do
			draw_rect( rect, white )
		end
	end

	def _input_update
		# Проверим backspace
		if Keys.trigger?(Keys::BACKSPACE)
			@text.gsub!(/.$/){""} if @text.size > 0
			_enter
		end

		if Keys.repeat?(Keys::BACKSPACE)
			@text = ""
			_enter
		end
		# Проверим любую цифру
		numbers = [
			Keys::N0, Keys::N1, Keys::N2, Keys::N3, Keys::N4,
			Keys::N5, Keys::N6, Keys::N7, Keys::N8, Keys::N9
		]
		if Keys.array_trigger?(numbers)
			for index in 0...numbers.size
				if Keys.trigger?(numbers[index])
					@text += index.to_s
					_enter
				end
			end
		end
		# в том числе - на нампаде
		numbers = [
			Keys::NUMPAD0, Keys::NUMPAD1, Keys::NUMPAD2, Keys::NUMPAD3, Keys::NUMPAD4,
			Keys::NUMPAD5, Keys::NUMPAD6, Keys::NUMPAD7, Keys::NUMPAD8, Keys::NUMPAD9
		]
		if Keys.array_trigger?(numbers)
			for index in 0...numbers.size
				if Keys.trigger?(numbers[index])
					@text += index.to_s
					_enter
				end
			end
		end
		# Проверим любую букву
		
	end

	def _enter
		_repos_pointer
		refresh
		Input.update
	end
end