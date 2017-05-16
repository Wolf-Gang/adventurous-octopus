
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

int talk_count;

[start]
void dialogue_check() {
  if(has_flag("memories"))
    talk_count = 2;
  else
    talk_count = 0;
}

[group housedude]
void goaway() {
  
  if (talk_count < 2)
    set_direction(housedude, get_position(get_player()));
  
  switch(talk_count) {
    
    case 0:
      say("Just because I let you in my\nhouse doesn't mean I want to\ntalk.");
      talk_count++;
      break;
      
    case 1:
      say("...");
      say("Fine.");
      append("\nI'll tell you.");
      say("Have you ever lost someone\nprecious to you?");
      set_direction(housedude, direction::left);
      say("It happened so fast...");
      nl("She fell and...");
      nl("Her head...");
      set_direction(housedude, direction::right);
      say("See her over there?");
      focus::move(vec(1.5, -.5), 2);
      wait(.5);
      fsay("*Sob*...");
      wait(.5);
      fnl("Why?!?!");
      wait(.5);
      nl("*Sob*...");
      say("It dropped so hard... *Sob*");
      nl("My pet rock... *Sob*");
      set_flag("memories");
      talk_count++;
      focus::move(get_position(get_player()), 1);
      focus::player();
      break;
    
    case 2:
      say("*Sob*");
      break;
  }
  
  narrative::end();
  player::lock(false);
  set_direction(housedude, direction::left);
  
}

