

void ded()
{
	player::lock(true);
	entity bg = add_entity("pixel");
	make_gui(bg, 0);
	set_scale(bg, vec(10, 10)*32);
	set_anchor(bg, anchor::topleft);
	set_color(bg, 0, 0, 0, 255);
	
	fx::sound("heh");
	
	music::stop();
	
	narrative::show();
	narrative::set_interval(80);
	say("You ded");
}

bool check_hit(entity pHitter, float pRadius) {
  
  return (get_position(get_player()).distance(get_position(pHitter)) < pRadius);
  
}

