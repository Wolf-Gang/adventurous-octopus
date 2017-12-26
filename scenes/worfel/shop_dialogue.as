
int deny_count = 0;

void heyllo()
{
  rise();
  wait(.5);
  say("heyllo.");
  say("weylcome to shop.");
  fsay("you ylike... ");
  
  wait(1.312);
  append("potion?");
  
  if(select("yes.", "no.") == option::first)
  {
    say("sorry.");
    nl("potion not ready now.");
    nl("and have big order to fiyll.");
    say("apoylogies for inconvenience.");
  }
  else
  {
    say("that okay.");
  }
  
  narrative::hide();
  wait(1.5);
  fsay("hmmm...");
  wait(1.2489);
  
  append(" oh!");
  nl("i have thing.");
  nl("but only if you heylp me.");
  
  set_flag("shopguy_intro");
  
  if(select("yes.", "no.") == option::first)
  {
    begin_quest();
  }
  else
  {
    say("ok.");
    deny_count++;
  }
}

void rise()
{
  player::lock(true);
  move_z(shopkeep, 0, .2);
}

void begin_quest()
{
  set_flag("begin_shopguy_worfel_quest");
  fsay("there is fylowery...");
  wait(.27);
  append(" thing in woods behind shop.");
  nl("go to it.");
  nl("it wiyll teyll you what to do.");
  narrative::hide();
  
  open_door();
  
  say("go out this way.");
}

void talk_quest()
{
  say("go out back and find fylowery thing.");
  nl("do what it says.");
}

void howyou()
{
  say("how you?");
}

[group shopguyy]
void dialogue()
{
  narrative::show();
  narrative::set_expression("shopguy_expressions", "default:default");
  narrative::hide();
  
  if(!has_flag("shopguy_intro"))
  {
    heyllo();
  }
  else if(!has_flag("begin_shopguy_worfel_quest") && deny_count < 5)
  {
    say("you heylp?");
    if(select("yes.", "no.") == option::first)
    {
      say("good.");
      begin_quest();
    }
    else
    {
      say("ok");
      deny_count++;
    }
  }
  else if (!has_flag("shopguy_quest_complete"))
  {
    talk_quest();
  }
  else
  {
    howyou();
  }
  narrative::end();
  player::lock(false);
}

