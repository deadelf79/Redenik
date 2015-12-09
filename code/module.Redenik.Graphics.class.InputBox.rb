# encoding utf-8
class Redenik::Graphics::InputBox < Redenik::Graphics::UI_Component
	attr_reader :text

	def initialize( x, y, width, height, initial_text="", max_chars=nil )
		super(x, y, width, height)
		@text = initial_text.nil? ? "" : initial_text

		@box = Redenik::Graphics::Image.new( 0, 0, width, height, @main_viewport )
		@box.font.size = height - 4
		@box.font.name = "Tahoma"
		@box.z = self.z + 1

		@max_chars = max_chars.nil? ? ( @box.width / @box.text_size('O').width ).to_i : max_chars
		refresh

		@pointer = Redenik::Graphics::Image.new( 0, 2, 2, height - 4, @main_viewport )
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
		@box.draw_text( @box.rect, @text, @box.white )
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
		@pointer.x = @box.text_size( @text ).width
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
		# Проверим выход
		if Keys.trigger?( Keys::RETURN )
			self.deactivate
			self.end_edit
		end
		# Проверим backspace
		if Keys.trigger?( Keys::BACKSPACE )
			@text.gsub!(/.$/){ "" } if @text.size > 0
			_enter
		end

		if Keys.repeat?( Keys::BACKSPACE )
			@text = ""
			_enter
		end
		# Пробелы и знаки препинания
		symbols = [
			Keys::SPACE,
			Keys::OEM_PLUS, Keys::OEM_COMMA, Keys::OEM_MINUS, Keys::OEM_PERIOD,
			Keys::OEM_1, Keys::OEM_2, Keys::OEM_3, Keys::OEM_4,
			Keys::OEM_5, Keys::OEM_6, Keys::OEM_7,
			# numpad
			Keys::MULTIPLY, Keys::ADD, Keys::SUBTRACT, Keys::DECIMAL, Keys::DIVIDE
		]
		if Keys.array_trigger?(symbols)
			if Keys.press?( Keys::LSHIFT )||Keys.press?( Keys::RSHIFT )
				if Keys.locale_ru?
					abc = " +Б_ЮЖ,ЁХ/ЪЭ".split(//)
				elsif Keys.locale_en?
					abc = " +<_>:?~{|}\"".split(//)
				end
				characters = {}
				symbols.each{ | key |
					characters[key] = abc[ symbols.index( key ) ]
				}
				characters.each do | key, value |
					if Keys.trigger?( key )
						@text += value
						_enter
					end
				end
			else
				if Keys.locale_ru?
					abc = " =б-юж.ёх\\ъэ".split(//)
				elsif Keys.locale_en?
					abc = " =,-.;/`[\\]'".split(//)
				end
				characters = {}
				symbols.each{ | key |
					characters[key] = abc[ symbols.index( key ) ]
				}
				characters.each do | key, value |
					if Keys.trigger?( key )
						@text += value
						_enter
					end
				end
			end
		end
		# Проверим любую цифру
		# сюда же - знаки препинания на цифрах
		numbers = [
			Keys::N0, Keys::N1, Keys::N2, Keys::N3, Keys::N4,
			Keys::N5, Keys::N6, Keys::N7, Keys::N8, Keys::N9
		]
		if Keys.array_trigger?(numbers)
			if Keys.locale_ru?
				abc = ")!\"№;%:?*(".split(//)
			elsif Keys.locale_en?
				abc = ")!@\#$%^&*(".split(//)
			end
			characters = {}
			numbers.each{ | key |
				characters[key] = abc[ numbers.index( key ) ]
			}
			if Keys.press?( Keys::LSHIFT )||Keys.press?( Keys::RSHIFT )
				characters.each do | key, value |
					if Keys.trigger?( key )
						@text += value
						_enter
					end
				end
			else
				for index in 0...numbers.size
					if Keys.trigger?(numbers[index])
						@text += index.to_s
						_enter
					end
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
		chars = [
			Keys::A,Keys::B,Keys::C,Keys::D,
			Keys::E,Keys::F,Keys::G,Keys::H,
			Keys::I,Keys::J,Keys::K,Keys::L,
			Keys::M,Keys::N,Keys::O,Keys::P,
			Keys::Q,Keys::R,Keys::S,Keys::T,
			Keys::U,Keys::V,Keys::W,Keys::X,
			Keys::Y,Keys::Z
		]
		if Keys.array_trigger?(chars)
			if Keys.locale_ru?
				abc = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ".split(//)
			elsif Keys.locale_en?
				abc = []
				('A'..'Z').each{ |a| abc+=[ a ] }
			end
			characters = {}
			chars.each{ | key |
				characters[ key ] = abc[ chars.index( key ) ]
			}
			if Keys.press?( Keys::LSHIFT )||Keys.press?( Keys::RSHIFT )
				characters.each do | key, value |
					if Keys.trigger?( key )
						@text += Keys.capslock? ? value.downcase : value.upcase
						_enter
					end
				end
			else
				characters.each do | key, value |
					if Keys.trigger?( key )
						@text += Keys.capslock? ? value.upcase : value.downcase
						_enter
					end
				end
			end
		end
	end

	def _enter
		_repos_pointer
		refresh
		Redenik.joypad_enabled? ? Input.update : Keys.update
	end
end