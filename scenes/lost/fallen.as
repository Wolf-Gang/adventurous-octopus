
#include "../backend/shadows.as"

entity crate;

[start]
void start() {
  
  set_position(get_player(), vec(2.5, 1.5));
  
  crate = add_entity("lost", (has_flag("fall") ? "crushed_crate" : "crate"));
  set_position(crate, vec(2.5, 1.7));
  set_depth(crate, fixed_depth::below);
  
  if(has_flag("fall"))
  {
    music::volume(70);
    music::open("scribbles103");
  }
}

void create_corruptable_barrel(vec pPosition)
{
  entity barrel = add_entity("corruptedbarrel", "corrupt");
  set_position(barrel, pPosition);
  create_thread(function(args){
    entity barrel = entity(args["e"]);
    while(get_position(get_player()).distance(get_position(barrel)) >= 7){ yield(); }
    animation::play_wait(barrel);
    set_atlas(barrel, "Crush");
    animation::start(barrel);
    set_depth(barrel, fixed_depth::below);
  }, dictionary = {{"e", barrel}});
}

[start]
void create_barrels()
{
  create_corruptable_barrel(vec(15, 1));
  create_corruptable_barrel(vec(16, 1));
  create_corruptable_barrel(vec(10, 2));
}

[start]
void fall()
{
  
  if(has_flag("fall"))
    return;
  
  player::lock(true);
  
  set_z(get_player(), 7);
  shadows::add(get_player());
  
  wait(2);
  
  set_direction(get_player(), direction::right);
  set_anchor(get_player(), anchor::center);
  set_rotation(get_player(), 90);
  
  move_z(get_player(), 0.2, 15);
  
  set_rotation(get_player(), 0);
  set_atlas(get_player(), "oof");
  set_atlas(crate, "crushed_crate");
  
  fx::fade_out(2);
  
  set_rotation(get_player(), 0);
  set_z(get_player(), 0);
  shadows::remove(get_player());
  
  wait(3);
  
  set_anchor(get_player(), anchor::bottom);
  set_atlas(get_player(), "default:right");
  
  player::lock(false);
  
  fx::fade_in(3);
  
  music::volume(0);
  music::fade_volume(70, 2);
  music::open("scribbles103");
  
  set_flag("fall");
  
}


