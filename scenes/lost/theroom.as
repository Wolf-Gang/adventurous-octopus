[start]
void start()
{
  music::volume(70);
  music::open("scribbles86");
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
  music::stop();
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
  
  /* demo end
  narrative::show();
  narrative::set_expression("sivora icon", "normal");
  say("Hello!");
  narrative::hide();
  
  fx::sound("transition");
  wait(2);
  create_blackout();
  wait(2);
  load_scene("credits");
  */
  
  
  music::volume(70);
  music::open("doodle167-AFV-Sivora");
  
  narrative::show();
  narrative::set_dialog_sound("softdialog");
  narrative::set_expression("sivora icon", "smirk");
  fsay("AH HA!");
  wait(0.2);
  append(" I'll save you from this dangerous place!");
  nl("I am the hero of lost souls.");
  say("<b>I'm Sivora!</b>");
  narrative::set_expression("sivora icon", "default:default");
  say("I've been waiting for you for so long.");
  fnl("You seem fine");
  wait(0.2);
  append(", so far...");
  nl("So let me help you out!");
  narrative::end();
  
  
}