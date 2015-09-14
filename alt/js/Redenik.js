// Собрано из аналогичного файла на ¤зыке Coffee Script
var Redenik,
  indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

Redenik = (function() {
  function Redenik() {}

  Redenik.prototype.start_game = function() {
    (function() {});
    this.game_actors = [];
    this.game_items = [];
    this.game_weapons = [];
    this.game_armors = [];
    this.game_skills = [];
    this.game_party = [];
    this.player_id = {};
    this.player_id[actor_id] = 0;
    this.player_id[party_id] = 0;
    _gen_actors;
    _gen_items;
    _gen_weapons;
    _gen_armors;
    _gen_skills;
    add_party_member(0);
  };

  Redenik.prototype.main_game = function() {
    (function() {});
    if (party_dead) {
      end_game;
    }
    if (this.game_party[this.player_id[party_id]].dead) {
      _change_player(next_member);
    }
  };

  Redenik.prototype.end_game = function() {};

  Redenik.prototype.add_party_member = function(id) {
    var ref;
    (function() {});
    if (ref = this.game_actors[id], indexOf.call(this.game_party, ref) < 0) {
      this.game_party += this.game_actors[id];
    }
    if (id === this.player_id[actor_id]) {
      _change_player;
    }
  };

  Redenik.prototype.party_dead = function() {
    var all, i, id, len, ref;
    (function() {});
    all = true;
    ref = this.game_party;
    for (i = 0, len = ref.length; i < len; i++) {
      id = ref[i];
      if (!this.game_party[id].dead) {
        all = false;
      }
    }
    return all;
  };

  Redenik.prototype._gen_actors = function() {
    var new_level;
    (function() {});
    return new_level = 0;
  };

  return Redenik;

})();