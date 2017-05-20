
#include "../backend/dreamland_effects.as"

entity worfel;
entity hat;

int talk_count;

[start]
void start()
{
  music::open("doodle104_2");
	music::volume(70);
	set_position(get_player(), vec(2, 2));
}


void worfel_is_here() {
  
  worfel = add_character("worfel");
  set_position(worfel, vec(10.5, 11));

  hat = add_entity("dreamland", "purpleflower");
  set_depth(hat, fixed_depth::overlay);
  set_position(hat, get_position(worfel) + vec(0, -.8));
  //set_z(hat, .8);
  add_child(worfel, hat);
  
}

[start]
void events() {
  
  if(has_flag("Itlikesflowers")) {
    
    group::enable("itlikesthem", false);
    worfel_is_here();
    
  }
  
  if(has_flag("Flower"))
    talk_count = 1;
  else
    talk_count = 0;
  
}

[group itlikesthem]
void itlikesflowers() {
  
  say("It likes flowers!");
  narrative::hide();
  
  worfel_is_here();
  
  set_direction(get_player(), vector_direction(get_position(worfel) - get_position(get_player())));
  focus::move(get_position(worfel) + vec(0, 1), 1.5);
  
  say("Does it want to smell some flowers?");
  narrative::hide();
  
  move(worfel, get_position(get_player()) * .5 + get_position(worfel) * .5, speed(1));
  
  say("Hmmm.");
  nl("Worfel thinks it needs more flowers.");
  
  set_flag("Itlikesflowers");
  set_flag("Flower");
  flower_hat();
  
  say("It has a very flower!");
  narrative::end();
  
  move(worfel, vec(10.5, 11), speed(1));
  
  group::enable("itlikesthem", false);
  
  player::lock(false);
  
}

[group talk]
void spreadthelove() {
  
  switch(talk_count) {
    case 0:
      say("It has made a very happy, yes.");
      say("Worfel is seeing such things.");
      say("It is needing a very flower again.");
      
      set_flag("Flower");
      flower_hat();
      
      nl("It is having much happiness!");
      narrative::end();
      player::lock(false);
      
      talk_count++;
      
    case 1:
      set_direction(worfel, vector_direction(get_position(get_player()) - get_position(worfel)));
      narrative::set_speaker(worfel);
      
      say("It is having much prettiness!");
      fsay("Is it wishing to be sharing the flowers?");
      
      if(select("Yes", "No") == option::first) {
        
        say("It is wanting to giving cheeriness, isn't it?");
        
        load_scene("dreamland/dreamland_town");
        
      }
      
      set_direction(worfel, direction::down);
      
      narrative::end();
      player::lock(false);
      break;
  }
}

