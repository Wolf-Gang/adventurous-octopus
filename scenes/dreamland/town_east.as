entity statue_vill;

[start]
void start()
{
	set_position(get_player(), vec(15.5, 6.5));
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
  set_depth(house3, fixed_depth::overlay);
  entity house4 = create(vec(8, 9), "house");
  set_rotation(house4, 180);
  set_depth(house4, fixed_depth::overlay);
  
  entity fountain = create(vec(17, 7), "fountain");
  
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

