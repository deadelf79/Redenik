# encoding utf-8

class Redenik::GameManager::Screen_New < Redenik::GameManager::Screen_Menu_Base
	def initialize(*args)
		super(*args)

		@select_index = 0
	end

	def create___all_pictures
		create___background
		create___game_start
		create___classes
		create___buttons
		create___select
	end

	def create___background
		@background = Plane.new
		@background.bitmap = Bitmap.new("Gfx/Planes/retrolines")
		@background.z = 100
	end

	def create___game_start
		@game_start = Redenik::Graphics::Cache.load_image('Gfx/Titles/','game_start')
		@game_start.z = 101
	end

	def create___classes

	end

	def create___buttons

	end

	def create___select
		@select = Redenik::Graphics::Image.new(0, 0, 32, 32)
		@select.copy Redenik::Graphics::Cache.load_bitmap('Gfx/Windows/', 'select')
		@select.z = 200
	end

	def create___all_windows
		create___choose_class
		create___game_stat_st
		create___game_stat_dx
		create___game_stat_iq
		create___game_stat_ht
		create___game_stat_cr
		create___game_start_window
		create___game_input_name
		create___game_help_window
	end

	def create___choose_class
		@choose_class = Redenik::Graphics::Slideshow.new( 263, 271, 82, 82 )
		with @choose_class do
			add_slide(Redenik::Translation::Russian::CLASS_NAMES[ :warrior ][ :name ], 	"warrior")
			add_slide(Redenik::Translation::Russian::CLASS_NAMES[ :mage ][ :name ], 	"")#"mage")
			add_slide(Redenik::Translation::Russian::CLASS_NAMES[ :thief ][ :name ], 	"")#"thief")
			add_slide(Redenik::Translation::Russian::CLASS_NAMES[ :trader ][ :name ], 	"")#"citizen")
			add_slide(Redenik::Translation::Russian::CLASS_NAMES[ :citizen ][ :name ], 	"")#"citizen")
		end
		@choose_class.z = 110
		@choose_class.refresh
	end

	def create___game_stat_st
		@stat_st = Redenik::Graphics::Slideshow.new( 464, 258, 120, 16 )
		with @stat_st do
			(1..20).each{|index|
				add_slide(
					index.to_s, "",
					{
						background:Color.new(0,0,0,0),
						color:Color.new(255,255,255)
					}
				)
			}
		end
		@stat_st.z = 110
		@stat_st.refresh
	end

	def create___game_stat_dx
		@stat_dx = Redenik::Graphics::Slideshow.new( 464, 280, 120, 16 )
		with @stat_dx do
			(1..20).each{|index|
				add_slide(
					index.to_s, "",
					{
						background:Color.new(0,0,0,0),
						color:Color.new(255,255,255)
					}
				)
			}
		end
		@stat_dx.z = 110
		@stat_dx.refresh
	end

	def create___game_stat_iq
		@stat_iq = Redenik::Graphics::Slideshow.new( 464, 302, 120, 16 )
		with @stat_iq do
			(1..20).each{|index|
				add_slide(
					index.to_s, "",
					{
						background:Color.new(0,0,0,0),
						color:Color.new(255,255,255)
					}
				)
			}
		end
		@stat_iq.z = 110
		@stat_iq.refresh
	end

	def create___game_stat_ht
		@stat_ht = Redenik::Graphics::Slideshow.new( 464, 324, 120, 16 )
		with @stat_ht do
			(1..20).each{|index|
				add_slide(
					index.to_s, "",
					{
						background:Color.new(0,0,0,0),
						color:Color.new(255,255,255)
					}
				)
			}
		end
		@stat_ht.z = 110
		@stat_ht.refresh
	end

	def create___game_stat_cr
		@stat_cr = Redenik::Graphics::Slideshow.new( 464, 346, 120, 16 )
		with @stat_cr do
			(1..20).each{|index|
				add_slide(
					index.to_s, "",
					{
						background:Color.new(0,0,0,0),
						color:Color.new(255,255,255)
					}
				)
			}
		end
		@stat_cr.z = 110
		@stat_cr.refresh
	end

	def create___game_start_window
		# окно с выбором "начать новую / отмена"
	end

	def create___game_input_name
		Redenik::NameGen.prepare
		@input_name = Redenik::Graphics::InputBox.new( 352, 196, 216, 24, Redenik::NameGen.make_name( 3, 4 ) )
		@input_name.z = 110
	end

	def create___game_help_window
		@help_window = Redenik::Graphics::Label.new( 218, 441, 382, 71 )
		@help_window.z = 110
	end

	def update
		super
		if @input_name.is_active?
			Redenik.joypad(false)
			@input_name.update
		else
			Redenik.joypad(true)
		end

		case @select_index
		when 0
			@select.move_to( @input_name.x - 128, @input_name.y + 8 )
		when 1
			@select.move_to( @choose_class.x - 16, @choose_class.y + 8 )
			case @choose_class.index
			when 0
				@help_window.text(Redenik::Translation::Russian::CLASS_NAMES[ :warrior ][ :desc ])
			when 1
				@help_window.text(Redenik::Translation::Russian::CLASS_NAMES[ :mage ][ :desc ])
			when 2
				@help_window.text(Redenik::Translation::Russian::CLASS_NAMES[ :thief ][ :desc ])
			when 3
				@help_window.text(Redenik::Translation::Russian::CLASS_NAMES[ :trader ][ :desc ])
			when 4
				@help_window.text(Redenik::Translation::Russian::CLASS_NAMES[ :citizen ][ :desc ])
			end
		when 2
			@select.move_to( @stat_st.x - 80, @stat_st.y )
		when 3
			@select.move_to( @stat_dx.x - 80, @stat_dx.y )
		when 4
			@select.move_to( @stat_iq.x - 80, @stat_iq.y )
		when 5
			@select.move_to( @stat_ht.x - 80, @stat_ht.y )
		when 6
			@select.move_to( @stat_cr.x - 80, @stat_cr.y )
		end

		@select.update
		@choose_class.update if @choose_class.is_active?
		@stat_st.update if @stat_st.is_active?
		@stat_dx.update if @stat_dx.is_active?
		@stat_iq.update if @stat_iq.is_active?
		@stat_ht.update if @stat_ht.is_active?
		@stat_cr.update if @stat_cr.is_active?

		unless @choose_class.is_active?||
			@stat_st.is_active?||
			@stat_dx.is_active?||
			@stat_iq.is_active?||
			@stat_ht.is_active?||
			@stat_cr.is_active?
			if Input.trigger?(:DOWN)
				@select_index < 6 ? @select_index += 1 : 0
			end
			if Input.trigger?(:UP)
				@select_index > 0 ? @select_index -= 1 : 6
			end
		end
	end

	def fire___ok
		case @select_index
		when 0
			Input.update
			if !@input_name.edit_now?
				@input_name.activate
				@input_name.begin_edit
			else
				@input_name.end_edit
				@input_name.deactivate
			end
		when 1
			@choose_class.is_active? ? @choose_class.deactivate : @choose_class.activate
		when 2
			@stat_st.is_active? ? @stat_st.deactivate : @stat_st.activate
		when 3
			@stat_dx.is_active? ? @stat_dx.deactivate : @stat_dx.activate
		when 4
			@stat_iq.is_active? ? @stat_iq.deactivate : @stat_iq.activate
		when 5
			@stat_ht.is_active? ? @stat_ht.deactivate : @stat_ht.activate
		when 6
			@stat_cr.is_active? ? @stat_cr.deactivate : @stat_cr.activate
		end
	end

	def fire___cancel
		case @select_index
		when 0
			unless @input_name.edit_now?
				super
			else
				@input_name.end_edit
				@input_name.deactivate
			end
		when 1
			unless @choose_class.is_active?
				super
			else
				@choose_class.deactivate
			end
		when 2
			unless @stat_st.is_active?
				super
			else
				@stat_st.deactivate
			end
		when 3
			unless @stat_dx.is_active?
				super
			else
				@stat_dx.deactivate
			end
		when 4
			unless @stat_iq.is_active?
				super
			else
				@stat_iq.deactivate
			end
		when 5
			unless @stat_ht.is_active?
				super
			else
				@stat_ht.deactivate
			end
		when 6
			unless @stat_cr.is_active?
				super
			else
				@stat_cr.deactivate
			end
		end
	end

	def fire___change_name;end
	def fire___change_class;end
	def fire___change_stat(stat);end
	def fire___start_game;end
end