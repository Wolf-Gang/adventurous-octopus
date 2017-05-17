
#include "../backend/shadows.as"

entity crate;

[start]
void fall()
{
  
  if(has_flag("fall"))
    return;
  
  player::lock(true);
  
  set_z(get_player(), 30);
  shadows::add(get_player());
  
  wait(2);
  
  set_direction(get_player(), direction::right);
  
  set_anchor(get_player(), anchor::center);
  
  set_rotation(get_player(), 90);
  
  float v = -4;
  
  float g = -10;
  
  for(float t = 0; get_z(get_player()) > .2; t += get_delta()) {
    
    yield();
    
    float z = get_z(get_player());
    
    set_z(get_player(), z + get_delta() * v + .5 * g * get_delta()**2);
    
    v += g * get_delta();
    
  }
  
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
  
  //set_flag("fall");
  
}

[start]
void start() {
  
  set_position(get_player(), vec(.5, 1.7));
  
  crate = add_entity("lost", (has_flag("fall") ? "crushed_crate" : "crate"));
  set_position(crate, vec(.5, 2));
  set_depth(crate, fixed_depth::below);
  
}

