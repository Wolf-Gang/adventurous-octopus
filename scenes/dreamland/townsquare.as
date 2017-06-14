#include "../backend/dreamland_effects.as"
#include "town.as"

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

[start]
void benches()
{
  //left
  create_bench(vec(5, 6.5));
  create_bench(vec(5, 10.1));
  
  //top
  create_bench(vec(7.55, 4.2), true);
  create_bench(vec(11.4, 4.2), true);
  
  //right
  create_bench(vec(13, 6.5));
  create_bench(vec(13, 10.1));
  
  //bottom
  create_bench(vec(7.55, 11.5), true);
  create_bench(vec(11.4, 11.5), true);
}

[start]
void buches()
{
  //ul
  create_bush(vec(8, 7.5), 1);
  //ur
  create_bush(vec(12, 7.5), 2);
  //bl
  create_bush(vec(8, 11.3), 2);
  //br
  create_bush(vec(12, 11.3), 1);
}

[start]
void triis()
{
  create_tree(vec(6, 6));
  create_tree(vec(14, 6));
  
  create_tree(vec(6, 13));
  create_tree(vec(14, 13));
}

//The senate will decide your fate
[group iamthesenate]
void notyet()
{
  //It's treason then
  say('<c r="240" g="100" b="100"><b>Under Construction.</b></c>');
  move(get_player(), direction::right, .5, .5);
  
  narrative::end();
  player::lock(false);
}

