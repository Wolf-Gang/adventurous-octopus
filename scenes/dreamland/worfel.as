
#include "../backend/dreamland_effects.as"

entity worfel;
entity hat;

[start]
void start()
{
	set_position(get_player(), vec(2, 2));
}

[start]
void flag_check() {
  
  if(has_flag("Itlikesflowers")) {
    
    group::enable("itlikesthem", false);
    
    worfel = add_character("worfel");
    set_position(worfel, vec(10.5, 11));

    hat = add_entity("dreamland", "purpleflower");
    set_position(hat, get_position(worfel));
    set_z(hat, .8);
    add_child(worfel, hat);
    
  }
}

[group itlikesthem]
void itlikesflowers() {
  
  say("It likes flowers!");
  narrative::hide();
  
  worfel = add_character("worfel");
  set_position(worfel, vec(10.5, 11));
  
  hat = add_entity("dreamland", "purpleflower");
  set_position(hat, get_position(worfel));
  set_z(hat, .8);
  add_child(worfel, hat);
  
  set_direction(get_player(), vector_direction(get_position(worfel) - get_position(get_player())));
  focus::move(get_position(worfel) + vec(0, 1), 1.5);
  
  say("Does it want to smell some flowers?");
  narrative::hide();
  
  move(worfel, get_position(get_player()) * .7 + get_position(worfel) * .3, speed(1));
  
  say("Hmmm.");
  nl("Worfel thinks it needs more flowers.");
  
  set_flag("Itlikesflowers");
  flower_hat();
  
  say("It has a very flower!");
  narrative::end();
  
  move(worfel, vec(10.5, 11), speed(1));
  
  group::enable("itlikesthem", false);
  
  player::lock(false);
  
}

[group goflowers]
void spreadthelove() {
  
  set_direction(worfel, vector_direction(get_position(get_player()) - get_position(worfel)));
  
  say("It is having much prettiness!");
  fsay("Is it wishing to be sharing the flowers?");
  
  if(select("Yes", "No") == option::first) {
    
    say("It is to be wanting to cheer someone up, isn't it?");
    
    load_scene("dreamland/dreamland_town");
    
  }
  
  set_direction(worfel, direction::down);
  
  narrative::end();
  player::lock(false);
  
}

