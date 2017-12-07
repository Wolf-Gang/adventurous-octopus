#include "../backend/dreamland_effects.as"
#include "../backend/emote.as"
#include "../characters/unicorn.as"


entity froggo;

[start]
void create_froggo()
{
  froggo = add_entity("Frog");
  set_position(froggo, vec(24, -12));
}

[start]
void create_welcome_sign()
{
  entity welcome_sign = add_entity("dreamland", "welcome");
  set_position(welcome_sign, pixel(115,160));
}

[group frog1]
void frog1()
{
  narrative::show();
  narrative::set_expression("frog_expression", "default:default");
  say(".....");
  narrative::set_expression("mc_expression", "default:default");
  say(".....");
  narrative::end();
  
  music::pause();
  fx::sound("FX_nom", 0.7);
  set_atlas(froggo, "eat");
  set_visible(get_player(), false);
  animation::play_wait(froggo);
  wait(0.5);
  
  fx::sound("FX_splash", 0.5);
  set_atlas(froggo, "swim");
  set_position(froggo, vec(25.5, -12));
  move(froggo, vec(28, -12), speed(2));
  // Goes to next scene
}


entity hamster_police1;

[start]
void create_hamster()
{
  hamster_police1 = add_entity("Hamster");
  set_position(hamster_police1, vec(2.5, -14.5));
}

[group talktohamster1]
void talktohamster1()
{
  narrative::set_speaker(hamster_police1);
  say("Can't go farther than this, buddy.");
  say("This area is closed off for... \"Maintenance.\"");
  narrative::end();
  player::lock(false);
}



/*
[group unicorn1]
void unicorn1()
{
  characters::unicorn unicorn;
  unicorn.create();
  unicorn.appear(vec(7.5, 3));
  
  narrative::show();
  narrative::set_speaker(unicorn);
	narrative::set_expression("unicorn icon", "default:default");
  say("");
  narrative::end();
  group::enable("unicorn1", false);
  player::lock(false);
}*/

void create_forest(vec pPosition, vec pSize)
{
  for (float y = 0; y < pSize.y; y++)
    if (y % 2 == 0)
      for (float x = 0; x < pSize.x; x++)
          create_tree(pPosition + vec(x*2, y));
    else
      for (float x = 0; x < pSize.x - 1; x++)
          create_tree(pPosition + vec(x*2 + 1, y));
}

[start]
void create_trees()
{
  create_tree(vec(10, 5.5));
  create_tree(vec(14, -1.5));
  
  create_forest(vec(12, -15.5), vec(4, 3));
  create_forest(vec(4, -15.5), vec(4, 2));
  create_forest(vec(-1, -16.5), vec(1, 3));
  create_tree(vec(1, -15.5));
}


[start]
void create_flowers()
{
  create_flower_patch(vec(1, -6.5), vec(6, 12));
  create_flower_patch(vec(9, -14), vec(4, 8));
  create_flower_patch(vec(11, -13), vec(14, 8));
  create_flower_patch(vec(18, -13), vec(2, 7));
  create_flower_patch(vec(19, -13), vec(2, 5));
}

[start]
void create_buildings()
{
  entity building1 = add_entity("dreamland", "building1");
  set_position(building1, vec(7, -10.5));
}

[start]
void create_eggswing()
{
  entity eggswing = add_entity("dreamland", "eggswing");
  set_position(eggswing, vec(13.5, -1.6));
  set_z(eggswing, 0.5);
}

[group eggswing]
void eggswing_talks()
{
  say("Don't judge me.");
  nl("Eggs can swing, too.");
  say("Just gotta wait for the wind to pick up...");
  narrative::end();
  player::lock(false);
}

[group house_door]
void talk_door()
{
  if(!has_flag("shopisopen"))
  {
    say("Wanna come in? The door's open.");
    set_flag("shopisopen");
  }
  load_scene("dreamland/shop");
}


[start]
void start()
{
  music::open("doodle169-AFV-Dreamland-Guitar");
	set_position(get_player(), vec(6, 7));
}
