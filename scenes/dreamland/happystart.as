#include "../backend/dreamland_effects.as"
#include "../backend/emote.as"
#include "../characters/unicorn.as"

characters::unicorn char_unicorn;

[start]
void create_cloud_trees()
{
	create_tree(vec(1, 1));
  create_tree(vec(6, 1));
}

[start]
void create_flowers()
{
	create_flower_patch(vec(0, 1.5), vec(4, 8), 2);
	create_flower_patch(vec(5.5, 1.5), vec(4, 8), 2, flower_type::orange);
}

[start]
void create_unicorn()
{
  char_unicorn.create();
  set_position(char_unicorn, vec(3.5, 2));
}

[start]
void start()
{
	set_position(get_player(), vec(3.5, 4));
  set_atlas(get_player(), "oof");
}

[start]
void things()
{
  entity blackout = add_entity("pixel");
  make_gui(blackout, 1);
  set_scale(blackout, get_display_size());
  set_color(blackout, 255, 255, 255, 255);
  set_anchor(blackout, anchor::topleft);
  
  wait(1);
  say("Hello?");
  nl("You awake?");
  narrative::hide();
  
  music::open("doodle132");
  fx::fade_out(blackout, 5);
  set_direction(get_player(), direction::up);
  wait(0.5);
  quick_emote(char_unicorn, emote_type::surprise, 1);
  say("Hello there!");
  
  narrative::end();
  player::lock(false);
  
}
