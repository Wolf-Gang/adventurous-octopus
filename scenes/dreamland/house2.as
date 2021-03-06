entity housedude;

[start]
void start()
{
	music::open("doodle108");
	music::set_volume(0.7);
	//set_position(get_player(), vec(0, 0));
  housedude = add_character("voidian");
  set_position(housedude, vec(-3.5, 0));
  set_direction(housedude, direction::left);
  wait(0.2);
}

int talk_count; // you can use the save value system, it might be better.

[start]
void dialogue_check() {
  if(has_flag("housedudehappy")) {
    talk_count = 4;
    return;
  }
  if(has_flag("memories")) {
    talk_count = 2;
    return;
  }
  else
    talk_count = 0;
}

[start]
void happylittleflower()
{  
  if(!has_flag("housedudehappy"))
    return;
  
  entity dude_hat = add_entity("dreamland", "purpleflower");
  set_position(dude_hat, get_position(housedude) + vec(0, .001));
  set_z(dude_hat, .8);
  add_child(housedude, dude_hat);
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
      set_direction(housedude, get_position(get_player()));
      say("See her over there?");
      narrative::hide();
      focus::move(midpoint(vec(1.5, -.5), get_position(get_player())), 2);
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
      narrative::hide();
      focus::move(get_position(get_player()), 1);
      focus::player();
      break;
    
    case 2:
      say("*Sob*");
      if(has_flower())
        talk_count++;
      break;
      
    case 3:
      say("*Sob*...");
      nl("What's that?");
      set_direction(housedude, get_position(get_player()));
      nl("You have a...flower for me?");
      narrative::hide();
      
      give_flower(housedude, .75);
      set_flag("housedudehappy");
      
      say("Oh!");
      nl("Uhh...wow.");
      nl("That actually makes me feel a lot better.");
      nl("Thanks.");
      
      talk_count++;
      break;
      
    case 4:
      set_direction(housedude, get_position(get_player()));
      say("Thanks for that.");
      break;
  }
  
  narrative::end();
  player::lock(false);
  set_direction(housedude, direction::left);
  
}

