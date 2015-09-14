class GameManager
    start:->
        ->
        @stack = []
        setup_first_scene
        @started = true
        return
    main:->
        ->
        start if !@started
        update_scene
        return
    quit:->
        ->
        exit
        return
    setup_first_scene:->
        call(Screen_Title)