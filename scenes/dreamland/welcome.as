#include "../backend/dreamland_effects.as"
#include "../backend/emote.as"
#include "../characters/unicorn.as"

[start]
void create_trees()
{
  create_tree(vec(10, 5.5));
  create_tree(vec(14, -1.5));
}

[start]
void create_flowers()
{
  create_flower_patch(vec(1, -6.5), vec(6, 12));
  create_flower_patch(vec(9, -14), vec(3, 8));
  create_flower_patch(vec(9, -14), vec(3, 8));
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
  narrative::end();
}

[start]
void start()
{
  music::open("doodle169-AFV-Dreamland-Guitar");
	set_position(get_player(), vec(6, 7));
}
