# encoding utf-8

class Redenik::GameManager::Screen_New < Redenik::GameManager::Screen_Menu_Base
	def initialize(*args)
		super(*args)

		@screen_offset = {
			x:0,
			y:Graphics.height-624
		}

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
		#@background.bitmap = Graphics.snap_to_bitmap
		#@background.bitmap.blur
		@background.z = 100
	end

	def create___game_start
		@game_start = Redenik::Graphics::Cache.load_image('Gfx/Titles/','game_start')
		@game_start.z = 101

		@game_start.x = @screen_offset[:x]
		@game_start.y = @screen_offset[:y]
	end

	def create___classes

	end

	def create___buttons

	end

	def create___select
		@select = Redenik::Graphics::Image.new(0, 0, 32, 32)
		@select.copy Redenik::Graphics::Cache.load_bitmap('Gfx/Windows/', 'big_select')
		@select.z = 200
	end

	def create___all_windows
		create___game_choose_class
		create___game_stat_st
		create___game_stat_dx
		create___game_stat_iq
		create___game_stat_ht
		create___game_stat_cr
		create___game_start_window
		create___game_input_name
		create___game_help_window
		create___game_stats_apportion
	end

	def create___game_choose_class
		@choose_class = Redenik::Graphics::Slideshow.new( 263, 271, 82, 82 )
		with @choose_class do
			add_slide(Redenik::Translation::Russian::CLASS_NAMES[ :warrior ][ :name ], 	"warrior")
			add_slide(Redenik::Translation::Russian::CLASS_NAMES[ :mage ][ :name ], 	"mage")
			add_slide(Redenik::Translation::Russian::CLASS_NAMES[ :thief ][ :name ], 	"thief")
			add_slide(Redenik::Translation::Russian::CLASS_NAMES[ :trader ][ :name ], 	"trader")
			add_slide(Redenik::Translation::Russian::CLASS_NAMES[ :citizen ][ :name ], 	"citizen")
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

		@help_window.text(Redenik::Translation::Russian::CLASS_NAMES[ :warrior ][ :desc ])
	end

	def create___game_stats_apportion
		@stats_apportion = Redenik::Graphics::Slideshow.new( 527, 382, 50, 20 )
		with @stats_apportion do
			(0..48).each{|index|
				add_slide(index.to_s, "",{background:Color.new(0,0,0,0),color:Color.new(0,255,0)})
			}
			self.z=110
			self.show_arrows = false
			self.refresh
			self.control = false
		end
		_select_apportion(Redenik::Balance::START___STATS_CAN_APPORTION)
	end

	def update
		super
		if @input_name.is_active?
			Redenik.joypad(false)
			@input_name.update
		else
			Redenik.joypad(true)
		end

		@select.update
		@stats_apportion.update
		@choose_class.update if @choose_class.is_active?

		_update_select
		_update_apportion
		_update_movement
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
			_select_apportion(Redenik::Balance::START___STATS_CAN_APPORTION)
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
		when 7
			fire___start_game
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

	def fire___start_game
		class_index = case @choose_class.index
					  when 0; 1
					  when 1; 2
					  when 2; 3
					  when 3; 4
					  when 4; 0
					  end
		Redenik.start_game({
			name:@input_name.text,
			class_name:Redenik::Balance::STATS___CLASSES[class_index][:class_name],
			st:@stat_st.index+1,
			dx:@stat_dx.index+1,
			iq:@stat_iq.index+1,
			ht:@stat_ht.index+1,
			cr:@stat_cr.index+1
		})

		Redenik::GameManager::goto(Redenik::GameManager::Screen_Map)
	end
	private

	def _set_stat(class_id_in_balance)
		@stat_st.select( Redenik::Balance::STATS___CLASSES[class_id_in_balance][:st] - 1 )
		@stat_dx.select( Redenik::Balance::STATS___CLASSES[class_id_in_balance][:dx] - 1 )
		@stat_iq.select( Redenik::Balance::STATS___CLASSES[class_id_in_balance][:iq] - 1 )
		@stat_ht.select( Redenik::Balance::STATS___CLASSES[class_id_in_balance][:ht] - 1 )
		@stat_cr.select( Redenik::Balance::STATS___CLASSES[class_id_in_balance][:cr] - 1 )
		@stat_st.update; @stat_st.deactivate
		@stat_dx.update; @stat_dx.deactivate
		@stat_iq.update; @stat_iq.deactivate
		@stat_ht.update; @stat_ht.deactivate
		@stat_cr.update; @stat_cr.deactivate
	end

	def _select_apportion(approtion_to_stats)
		@stats_apportion.select(approtion_to_stats)
	end

	def _update_select
		# selector areas
		if Mouse.area?( 224, 176, 368, 64 )
			Redenik::GameManager.debug_canvas.clear
			rect = Rect.new( 224, 176, 368, 64 )
			color = Color.new( 255, 135, 0 )
			Redenik::GameManager.debug_canvas.draw_rect(rect, color, false)

			@select_index = 0
		elsif Mouse.area?( 216, 264, 176, 96 )
			Redenik::GameManager.debug_canvas.clear
			rect = Rect.new( 216, 264, 176, 96 )
			color = Color.new( 255, 135, 0 )
			Redenik::GameManager.debug_canvas.draw_rect(rect, color, false)

			@select_index = 1
		elsif Mouse.area?( 404, 256, 230, 20 )
			Redenik::GameManager.debug_canvas.clear
			rect = Rect.new( 404, 256, 230, 20 )
			color = Color.new( 255, 135, 0 )
			Redenik::GameManager.debug_canvas.draw_rect(rect, color, false)

			@select_index = 2
		elsif Mouse.area?( 404, 276, 230, 20 )
			Redenik::GameManager.debug_canvas.clear
			rect = Rect.new( 404, 276, 230, 20 )
			color = Color.new( 255, 135, 0 )
			Redenik::GameManager.debug_canvas.draw_rect(rect, color, false)

			@select_index = 3
		elsif Mouse.area?( 404, 296, 230, 20 )
			Redenik::GameManager.debug_canvas.clear
			rect = Rect.new( 404, 296, 230, 20 )
			color = Color.new( 255, 135, 0 )
			Redenik::GameManager.debug_canvas.draw_rect(rect, color, false)

			@select_index = 4
		elsif Mouse.area?( 404, 316, 230, 20 )
			Redenik::GameManager.debug_canvas.clear
			rect = Rect.new( 404, 316, 230, 20 )
			color = Color.new( 255, 135, 0 )
			Redenik::GameManager.debug_canvas.draw_rect(rect, color, false)

			@select_index = 5
		elsif Mouse.area?( 404, 336, 230, 20 )
			Redenik::GameManager.debug_canvas.clear
			rect = Rect.new( 404, 336, 230, 20 )
			color = Color.new( 255, 135, 0 )
			Redenik::GameManager.debug_canvas.draw_rect(rect, color, false)

			@select_index = 6
		elsif Mouse.area?( 296, 520, 224, 48 )
			Redenik::GameManager.debug_canvas.clear
			rect = Rect.new( 296, 520, 224, 48 )
			color = Color.new( 255, 135, 0 )
			Redenik::GameManager.debug_canvas.draw_rect(rect, color, false)

			@select_index = 7
		end

		case @select_index
		when 0
			@select.move_to( @input_name.x - 138, @input_name.y + 8 )
		when 1
			@select.move_to( @choose_class.x - 26, @choose_class.y + 8 )
			case @choose_class.index
			when 0
				@help_window.text( Redenik::Translation::Russian::CLASS_NAMES[ :warrior ][ :desc ] )
				_set_stat(1)# warrior
			when 1
				@help_window.text(Redenik::Translation::Russian::CLASS_NAMES[ :mage ][ :desc ])
				_set_stat(2)# mage
			when 2
				@help_window.text(Redenik::Translation::Russian::CLASS_NAMES[ :thief ][ :desc ])
				_set_stat(3)# thief
			when 3
				@help_window.text(Redenik::Translation::Russian::CLASS_NAMES[ :trader ][ :desc ])
				_set_stat(4)# trader
			when 4
				@help_window.text(Redenik::Translation::Russian::CLASS_NAMES[ :citizen ][ :desc ])
				_set_stat(0)# citizen
			end
		when 2
			@select.move_to( @stat_st.x - 100, @stat_st.y )
			@help_window.text(Redenik::Translation::Russian::STAT_NAMES[ :st ][ :desc ])
		when 3
			@select.move_to( @stat_dx.x - 100, @stat_dx.y )
			@help_window.text(Redenik::Translation::Russian::STAT_NAMES[ :dx ][ :desc ])
		when 4
			@select.move_to( @stat_iq.x - 100, @stat_iq.y )
			@help_window.text(Redenik::Translation::Russian::STAT_NAMES[ :iq ][ :desc ])
		when 5
			@select.move_to( @stat_ht.x - 100, @stat_ht.y )
			@help_window.text(Redenik::Translation::Russian::STAT_NAMES[ :ht ][ :desc ])
		when 6
			@select.move_to( @stat_cr.x - 100, @stat_cr.y )
			@help_window.text(Redenik::Translation::Russian::STAT_NAMES[ :cr ][ :desc ])
		when 7
			@select.move_to( 280, 537 )
		end
	end

	def _update_apportion
		if @stats_apportion.index > 0
			if @stat_st.is_active?
				unless @stat_st.block_right?
					if Input.trigger?(:RIGHT)
						@stats_apportion.select @stats_apportion.index - 1
					end
				end
				unless @stat_st.block_left?
					if Input.trigger?(:LEFT)
						@stats_apportion.select @stats_apportion.index + 1
					end
				end
			end
			if @stat_dx.is_active?
				unless @stat_dx.block_right?
					if Input.trigger?(:RIGHT)
						@stats_apportion.select @stats_apportion.index - 1
					end
				end
				unless @stat_dx.block_left?
					if Input.trigger?(:LEFT)
						@stats_apportion.select @stats_apportion.index + 1
					end
				end
			end
			if @stat_iq.is_active?
				unless @stat_iq.block_right?
					if Input.trigger?(:RIGHT)
						@stats_apportion.select @stats_apportion.index - 1
					end
				end
				unless @stat_iq.block_left?
					if Input.trigger?(:LEFT)
						@stats_apportion.select @stats_apportion.index + 1
					end
				end
			end
			if @stat_ht.is_active?
				unless @stat_ht.block_right?
					if Input.trigger?(:RIGHT)
						@stats_apportion.select @stats_apportion.index - 1
					end
				end
				unless @stat_ht.block_left?
					if Input.trigger?(:LEFT)
						@stats_apportion.select @stats_apportion.index + 1
					end
				end
			end
			if @stat_cr.is_active?
				unless @stat_cr.block_right?
					if Input.trigger?(:RIGHT)
						@stats_apportion.select @stats_apportion.index - 1
					end
				end
				unless @stat_cr.block_left?
					if Input.trigger?(:LEFT)
						@stats_apportion.select @stats_apportion.index + 1
					end
				end
			end
		else
			@stat_st.block_right; @stat_st.update; @stat_st.deactivate
			@stat_dx.block_right; @stat_dx.update; @stat_dx.deactivate
			@stat_iq.block_right; @stat_iq.update; @stat_iq.deactivate
			@stat_ht.block_right; @stat_ht.update; @stat_ht.deactivate
			@stat_cr.block_right; @stat_cr.update; @stat_cr.deactivate
		end
		_update_stats
	end

	def _update_stats
		@stat_st.index > 0 ? @stat_st.unblock_left : @stat_st.block_left
		@stat_dx.index > 0 ? @stat_dx.unblock_left : @stat_dx.block_left
		@stat_iq.index > 0 ? @stat_iq.unblock_left : @stat_iq.block_left
		@stat_ht.index > 0 ? @stat_ht.unblock_left : @stat_ht.block_left
		@stat_cr.index > 0 ? @stat_cr.unblock_left : @stat_cr.block_left

		(@stat_st.index < 19 ? @stat_st.unblock_right : @stat_st.block_right) unless @stat_st.block_right?
		(@stat_dx.index < 19 ? @stat_dx.unblock_right : @stat_dx.block_right) unless @stat_dx.block_right?
		(@stat_iq.index < 19 ? @stat_iq.unblock_right : @stat_iq.block_right) unless @stat_iq.block_right?
		(@stat_ht.index < 19 ? @stat_ht.unblock_right : @stat_ht.block_right) unless @stat_ht.block_right?
		(@stat_cr.index < 19 ? @stat_cr.unblock_right : @stat_cr.block_right) unless @stat_cr.block_right?

		@stat_st.update if @stat_st.is_active?
		@stat_dx.update if @stat_dx.is_active?
		@stat_iq.update if @stat_iq.is_active?
		@stat_ht.update if @stat_ht.is_active?
		@stat_cr.update if @stat_cr.is_active?
	end

	def _update_movement
		unless @choose_class.is_active?||
			@stat_st.is_active?||
			@stat_dx.is_active?||
			@stat_iq.is_active?||
			@stat_ht.is_active?||
			@stat_cr.is_active?
			if Input.trigger?(:DOWN)
				@select_index < 7 ? @select_index += 1 : 0
			end
			if Input.trigger?(:UP)
				@select_index > 0 ? @select_index -= 1 : 7
			end
		end
	end
end