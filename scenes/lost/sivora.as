
[start]
void create_boxes()
{
  entity box1 = add_entity("lost", "crate");
  set_position(box1, vec(4, 4));
  
  entity box2 = add_entity("lost", "crate");
  set_position(box2, vec(4, 4));
  set_z(box2, .5);
}

[group meetsivora]
void meetsivora()
{
  player::lock(true);

  scoped_entity sivora = add_character("sivora");
  set_direction(sivora, direction::down);
  set_position(sivora, vec(4.3, 3.7));
  set_color(sivora, 0, 0, 0, 255);
  
  wait(0.5);
  say("Hello?");
  fnl("Is that a person?");
  
  if (select("...", "Yes") == option::first)
  {
    say("Don't lie, I can hear you.");
  }
  else
  {
    say("Oh yes oh yes!");
  }
  narrative::hide();
  move(sivora, direction::right, 0.5, speed(1));
  move(sivora, vec(5, 4.5), speed(1));
  set_direction(sivora, direction::left);
  
  for(float timer = 0; timer < 1; timer += get_delta())
  {
    int c = int(255*timer);
    set_color(sivora, c, c, c, 255);
    yield();
  }
  
  say("Did you perhaps fall? That is a rather long fall.");
  nl("Come this way.");
}

[start]
void start()
{
	set_position(get_player(), vec(1, 4.5));
}
