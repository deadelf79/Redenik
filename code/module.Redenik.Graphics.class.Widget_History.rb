class Widget_History < UI_Component
	def initialize(x,y)
		super(x,y,200,114)

		@message_size = Redenik.message_stack.size

		@window = Redenik::Graphics::Image.new( 0, 0, 322, 54, @main_viewport )
		@window.copy Bitmap.new('Gfx/Windows/Widget_History')

		@canvas = Redenik::Graphics::Window.new( 4, 4, width - 8, height - 8 )
		@canvas.deactivate
		refresh
	end

	def refresh
		_draw_all
	end

	private

	def _draw_all
		if @message_size != Redenik.message_stack.size
			if Redenik.message_stack.size == 0
				# обычно стек сообщений стирается при переходе с одной карты
				# но новую. тогда все кнопки из этого окна нужно стереть
				@canvas.clear true
				@message_size = Redenik.message_stack.size
			else
				# если добавилось несколько новых сообщений, то посчитаем
				# их количество, отберем это количество сверху стека
				# и добавим кнопки с текстом в наше окно
				#count = Redenik.message_stack.size - @message_size
				for index in @message_size...Redenik.message_stack.size
					with @canvas do
						add_button(
							Redenik.message_stack[index],
							nil,
							nil,
							"",
							false
						)
					end
				end
				@canvas.refresh
			end
		end
	end
end