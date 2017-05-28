
[start]
void start()
{
	set_position(get_player(), vec(34, 5));
}

entity create(vec pPos, string &in pAtlas) {
  
  entity thing = add_entity("dreamland", pAtlas);
  set_position(thing, pPos);
  return thing;
  
}

