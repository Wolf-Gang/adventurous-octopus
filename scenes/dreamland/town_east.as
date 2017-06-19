#include "town.as"
#include "../backend/clone.as"
#include "../backend/dreamland_effects.as"

const float y_origin = 6.6;

[start]
void start()
{
	set_position(get_player(), vec(15.5, 6.5));
  make_clone((get_position(get_player()) + vec(0, -y_origin))*vec(1, -1) + vec(0, y_origin), vec(1, -1), add_character("mc"));
}

/// Start
//////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Aesthetics

entity create(vec pPos, string &in pAtlas) {
  
  entity thing = add_entity("dreamland", pAtlas);
  set_position(thing, pPos);
  return thing;
  
}

entity statue_vill;

[start]
void create_vill()
{
	statue_vill = add_entity("statue vill", "default:default");
	set_position(statue_vill, vec(27.5, 6.75));
}

[group statue]
void talk_to_statue()
{
	narrative::show();
	say("Who's this nerd?");
	nl("Seems like a nice guy.");
	narrative::end();
	
	player::lock(false);
}

[start]
void make_houses()
{  
  entity house1 = create(vec(4, 4), "house");
  entity house2 = create(vec(8, 4), "house");
  
  entity house3 = create(vec(4, 9), "house");
  set_rotation(house3, 180);
  set_depth(house3, -9000);
  entity house4 = create(vec(8, 9), "house");
  set_rotation(house4, 180);
  set_depth(house4, -9000);
}

[start]
void make_foontan()
{
  entity fountain = create(vec(17, 7), "fountain");
}

[group foontan]
void foontan() {
  
  say("It's a happy fountain.");
  narrative::end();
  player::lock(false);
  
}

[start]
void make_benches()
{
  //by foontan
  create_bench(vec(16, 1.5));
  create_bench(vec(16, 10.5));
}

[start]
void make_bushes()
{
  //top houses
  create_bush(vec(5.3, 4.2), 1);
  create_bush(vec(5.8, 3.9), 2);
  create_bush(vec(6.5, 4.1), 2);
  create_bush(vec(6.8, 4.3), 1);
  create_bush(vec(7.1, 3.7), 1);
  
  //bottom houses
  create_bush(vec(4.8, 9.9), 1);
  create_bush(vec(5.4, 10.1), 2);
  create_bush(vec(5.8, 9.6), 2);
  create_bush(vec(6.4, 9.4), 1);
  create_bush(vec(6.7, 9.9), 1);
  
  //circles
  const vec top_left_center (13, 3.5);
  const vec offsets (8, 7);
  const float radius = 1.3;
  const int bush_count = 12;
  
  for(int x_off = 0; x_off < 2; x_off++)
  for(int y_off = 0; y_off < 2; y_off++)
  {
    const vec center = top_left_center + vec(x_off, y_off) * offsets;
    create_bush(center, (x_off + y_off) % 2 + 1);
    for(int i = 0; i < bush_count; i++)
    {
      const vec position = center
        + vec(0, radius).rotate(360 / bush_count * i);
      create_bush(position,  (i + x_off + y_off) % 2 == 1 ? 1 : 2);
    }
  }
}
/// Aesthetics
////////////////////////////////////////////////////////////////////////////////////////////////

