
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
  if (has_flag("meetsivora"))
    return;
  player::lock(true);

  scoped_entity sivora = add_character("sivora");
  set_direction(sivora, direction::down);
  set_position(sivora, vec(4.3, 3.7));
  set_color(sivora, 0, 0, 0, 255);
  
  wait(0.5);
  narrative::show();
  narrative::set_expression("question_expr", "default:default");
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
  
  say("Did you perhaps fall? That is a rather long fall.");
  nl("Come this way.");
  nl("I can help you.");
  narrative::hide();
  player::lock(false);
  
  move(sivora, direction::right, 10, speed(3));
  set_flag("meetsivora");
}

[start]
void start()
{
  music::volume(70);
  music::open("scribbles86");
	set_position(get_player(), vec(1, 4.5));
}
