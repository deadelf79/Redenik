class Redenik
    start_game:->
        ->
        @game_actors  = []
        @game_items   = []
        @game_weapons = []
        @game_armors  = []
        @game_skills  = []
        @game_party   = []
        @player_id    = {}
        @player_id[actor_id] = 0
        @player_id[party_id] = 0
        _gen_actors
        _gen_items
        _gen_weapons
        _gen_armors
        _gen_skills
        add_party_member(0)
        return
    main_game:->
        ->
        end_game if party_dead
        _change_player(next_member) if @game_party[@player_id[party_id]].dead
        return
    end_game:->
    add_party_member: (id)->
        ->
        @game_party+=@game_actors[id] unless @game_actors[id] in @game_party
        _change_player if id==@player_id[actor_id]
        return
    party_dead:->
        ->
        all=true
        for id in @game_party
            all=false if !@game_party[id].dead
        return all
    _gen_actors:->
        ->
        new_level = 0
