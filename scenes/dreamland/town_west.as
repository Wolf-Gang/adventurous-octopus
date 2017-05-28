
[start]
void start()
{
	set_position(get_player(), vec(12, 5));
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

