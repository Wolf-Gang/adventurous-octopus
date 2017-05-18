
[group enter?]
void enter()
{
  fsay("Enter?");
  if (select("Yes", "No") == option::first)
  {
    fx::fade_out(1);
    load_scene("dreamland/dreamland_town");
  }
}

[start]
void colorfulness()
{
  entity box = add_entity("pixel");
  set_anchor(box, anchor::topleft);
  set_position(box, vec(4, 0));
  set_scale(box, vec(64, 64));
  
  do {
    set_color(box
      , random(150, 255)
      , random(150, 255)
      , random(150, 255)
      , 255);
    wait(1);
  } while(yield());
}

[start]
void start()
{
	set_position(get_player(), vec(5, 11));
}
