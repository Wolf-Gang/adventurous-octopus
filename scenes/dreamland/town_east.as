#include "town.as"
#include "../backend/clone.as"

entity statue_vill;

const float y_origin = 6.7;

[start]
void start()
{
	set_position(get_player(), vec(15.5, 6.5));
  make_clone((get_position(get_player()) + vec(0, -y_origin))*vec(1, -1) + vec(0, y_origin), vec(1, -1), add_character("mc"));
}

[start]
void create_vill()
{
	statue_vill = add_entity("statue vill", "default:default");
	set_position(statue_vill, vec(27.5, 6.75));
}

entity create(vec pPos, string &in pAtlas) {
  
  entity thing = add_entity("dreamland", pAtlas);
  set_position(thing, pPos);
  return thing;
  
}

[start]
void city_stuff() {
  
  entity house1 = create(vec(4, 4), "house");
  entity house2 = create(vec(8, 4), "house");
  
  entity house3 = create(vec(4, 9), "house");
  set_rotation(house3, 180);
  set_depth(house3, -9000);
  entity house4 = create(vec(8, 9), "house");
  set_rotation(house4, 180);
  set_depth(house4, -9000);
  
  entity fountain = create(vec(17, 7), "fountain");
  
}

/*[start]
void rotate_player()
{
  
  do{
    
    set_rotation(get_player(), 
    
  } while(yield());
}*/

[start]
void make_benches()
{
  create_bench(vec(16, 1.5));
  create_bench(vec(16, 10.5));
}

[group foontan]
void foontan() {
  
  say("It's a happy fountain.");
  narrative::end();
  player::lock(false);
  
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

/*
box b;

[group foontan]
void bawks() {
  
  if(b.is_valid())
    b.show();
  else
    b = box("bawks", pixel(20, 20), pixel(80, 100));
  
  keywait();
  
  b.hide();
  
}
*/

