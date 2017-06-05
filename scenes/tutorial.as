
[start]
void start()
{
	set_position(get_player(), vec(.5, 0));
  player::lock(true);
}

void goto_entrance()
{
  music::fade_volume(0, 2);
  fx::fade_out(2);
  load_scene("dreamland/entrance");
}

[start]
void tutorial()
{ 
  music::open("scribbles88");
  wait(1);
  
  narrative::show();
  narrative::set_expression("question_expr", "default:default");
  say("Hey, little fellah.");
  narrative::hide();
  
  entity janko = add_character("elderjanko");
  set_position(janko, vec(0.5, -4));
  create_thread(function(args)
  {
    entity janko = entity(args["e"]);
    do{
    set_color(janko, 255, 255, 255, 255 - int((get_position(janko).distance(vec(0.5, -1))/3)*255));
    } while(yield());
  }, dictionary = {{"e", janko}});
  
  set_direction(get_player(), direction::up);
  move(janko, vec(0.5, -1), speed(2));
  
  wait(0.5);
  
  set_atlas(janko, "talk");
  say("You must be new to these lands.");
  nl("A land were only darkness and despair await.");
  say("There are special skills you will need to survive.");
  
  fsay("Do you want to learn these skills?");
  if (select("Yes", "No") == option::second)
  {
    say("You seem well versed in it already.");
    nl("Your skills must be masterful.");
    say("Good bye and good luck.");
    goto_entrance();
  }
  say("Wonderful.");
  say("Let me introduce myself.");
  nl("I am Elder Janko.");
  say("My apprentice, I'll teach you these skills.");
  say("The first is the holy technique of <i>walking</i>.");
  nl('Use the <c r="255" g="255" b="0">Arrow Keys</c> to move.');
  narrative::hide();
  
  player::lock(false);
  while(get_position(get_player()).distance(vec(.5, 0)) <= 0.6 && yield()){}
  
  set_direction(get_player(), direction::up);
  say("You did well.");
  
  
  say("That is all you need to know for now.");
  nl("Good luck out there.");
  goto_entrance();
  
}
