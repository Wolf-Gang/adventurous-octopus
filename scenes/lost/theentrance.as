#include "../backend/savepoint.as"

[start]
void start()
{
  music::volume(70);
  music::open("scribbles86");
	set_position(get_player(), vec(0.5, 2.5));
}

[start]
void save_thing()
{
  make_savepoint(vec(8.5, 4.5));
}

[group whereareyougoing?]
void whereareyougoing()
{
  fx::sound("bells");
  player::lock(true);
	
  scoped_entity sivora = add_character("sivora");
  set_direction(sivora, direction::down);
  set_position(sivora, vec(5, 2));
  set_color(sivora, 0, 0, 0, 255);
	
  move(sivora, direction::down, 0.5, speed(1));
  move(sivora, direction::right, 1, speed(1));
  
  say("Where are you going?");
  nl("Come over here.");
  narrative::end();
  
  move(sivora, direction::left, 1, speed(1));
  move(sivora, direction::up, 0.5, speed(1));
  
  move(get_player(), direction::left, 0.5, 0.2);
  player::lock(false);
  
}
