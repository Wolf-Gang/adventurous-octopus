
entity housedude;

[start]
void start()
{
	//set_position(get_player(), vec(0, 0));
  housedude = add_character("voidian");
  set_position(housedude, vec(-3.5, 0));
  set_direction(housedude, direction::left);
}

[group housedude]
void goaway() {
  set_direction(housedude, direction::right);
  say("Just because I let you in my\nhouse doesn't mean I want to\ntalk.");
  set_direction(housedude, direction::left);
  narrative::end();
}

