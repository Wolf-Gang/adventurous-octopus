
entity housedude;

[start]
void start()
{
	music::open("doodle108");
	music::volume(70);
	//set_position(get_player(), vec(0, 0));
  housedude = add_character("voidian");
  set_position(housedude, vec(-3.5, 0));
  set_direction(housedude, direction::left);
}

[group housedude]
void goaway() {
  set_direction(housedude, get_position(get_player()));
  say("Just because I let you in my\nhouse doesn't mean I want to\ntalk.");
  set_direction(housedude, direction::left);
  say("...");
  say("Fine I'll tell you.");
  nl("Have you every lost someone\nprecious to you?");
  say("It happened so fast...");
  nl("It fell and...");
  nl("Her head...");
  set_direction(housedude, direction::right);
  say("See that rock over there?");
  say("*Sob* Why *Sob*");
  nl("It dropped so hard... *Sob*");
  nl("My pet rock... *Sob*");
  set_direction(housedude, direction::left);
  narrative::end();
  player::lock(false);
}

