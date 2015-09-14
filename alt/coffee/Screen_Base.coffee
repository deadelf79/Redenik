class Screen_Base
    construct = (timer)->
        ->
        create___all_windows
        create___all_pictures
        return
    update:->
        ->
        update_basics
        return
    update_basics:->
        ->
        update_gfx
        update_input
        return