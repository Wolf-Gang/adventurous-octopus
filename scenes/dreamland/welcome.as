#include "../backend/dreamland_effects.as"
#include "../backend/emote.as"
#include "../characters/unicorn.as"


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
}

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



[start]
void start()
{
  music::open("doodle169-AFV-Dreamland-Guitar");
	set_position(get_player(), vec(6, 7));
}
