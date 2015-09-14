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
        return