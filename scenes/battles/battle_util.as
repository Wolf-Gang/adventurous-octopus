

void ded()
{
	player::lock(true);
	entity bg = add_entity("ded");
	make_gui(bg, 0);
	set_anchor(bg, anchor::topleft);
	
	fx::sound("heh");
	
	music::stop();
	
  wait(1);
  
  keywait();
  
	open_game();
  
}

bool check_hit(entity pHitter, float pRadius) {
  
  return (get_position(player::get()).distance(get_position(pHitter)) < pRadius);
  
}

