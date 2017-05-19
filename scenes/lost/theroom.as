[start]
void start()
{
	set_position(get_player(), vec(5, 7));
}

entity create_blackout()
{
  entity e = add_entity("pixel");
  make_gui(e, 0);
	set_scale(e, vec(10, 10)*32);
	set_anchor(e, anchor::topleft);
  set_color(e, 0, 0, 0, 255);
  return e;
}

[group sivoraintro]
void sivoraintro()
{
  fx::sound("bells");
  
  player::lock(true);
  scoped_entity sivora = add_character("sivora");
  set_direction(sivora, direction::down);
  set_position(sivora, vec(5, 3));
  
  // Had to use separate for statements
  // because color functions are a bit limited
  
  // Fade in black
  for(float timer = 0; timer < 1; timer += get_delta()) 
  {
    int c = int(255*timer);
    set_color(sivora, 0, 0, 0, c);
    yield();
  }
  
  // Fade to color
  for(float timer = 0; timer < 1; timer += get_delta())
  {
    int c = int(255*timer);
    set_color(sivora, c, c, c, 255);
    yield();
  }
  
  narrative::show();
  narrative::set_expression("sivora icon", "normal");
  say("Hello!");
  narrative::end();
  
  fx::sound("transition");
  wait(2);
  create_blackout();
  wait(2);
  load_scene("credits");
  
  
  
  music::volume(100);
  music::open("doodle113");
  
  narrative::show();
  narrative::set_expression("sivora icon", "normal");
  say("AH HA! I'll save you from this dangerous place!");
  nl("I am the hero of lost souls.");
  say("I'm Sivora!");
  say("I've been waiting for you for so long.");
  nl("You seem fine, so far...");
  nl("So let's play!");
  narrative::end();
  
  
  
}