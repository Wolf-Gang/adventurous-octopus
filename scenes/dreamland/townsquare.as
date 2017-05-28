#include "../backend/dreamland_effects.as"

[start]
void start()
{
	set_position(get_player(), vec(10, 10));
}

entity fountain;

[start]
void foontan()
{
  fountain = add_entity("dreamland", "fountain");
  set_position(fountain, vec(10, 9.5));
}

[group iamthesenate]
void notyet()
{
  say("<b>Under Construction.</b>");
  move(get_player(), direction::right, .5, .5);
  
  narrative::end();
  player::lock(false);
}

