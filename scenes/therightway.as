entity flash;

[start]
void start()
{
	music::open("FX_deepvibes");
	set_position(get_player(), vec(5, 7));
	set_direction(get_player(), direction::up);
  group::enable("noescape", false);
}

[start]
void create_eye()
{
  entity clarissa = add_entity("clarissa");
  set_anchor(clarissa, anchor::center);
  set_position(clarissa, vec(5.7, 1.9));
  set_color(clarissa, 255, 255, 255, 0);
	entity eyeyeyey = add_entity("eye", "open");
	set_anchor(eyeyeyey, anchor::center);
	set_position(eyeyeyey, vec(5, 2));
  animation::start(eyeyeyey);
	
  wait(5.7 * 5);
  
  set_atlas(eyeyeyey, "twitch");
  animation::stop(eyeyeyey);
  
  for (float i = 0; i <= 255; i += ((255/6) * get_delta())) {
    set_color(clarissa, 255, 255, 255, int(i));
    yield();
  }
  
  group::enable("noescape", true);
  
	float timer = 0;
  
	do{
		timer += get_delta();
		
		if (timer >= 5)
		{
			set_atlas(eyeyeyey, "blink");
			animation::start(eyeyeyey);
			wait(1.8);
			set_atlas(eyeyeyey, "twitch");
			animation::start(eyeyeyey);
			timer = 0;
		}
	}while(yield());
}

[group noescape]
void staretoolong() {
  
  player::lock(true);
  set_direction(get_player(), direction::up);
  
  narrative::show();
  narrative::set_interval(2000);
  say("...");
  
  narrative::hide();
  
  do_flash();
  
  load_scene("happiness");
}

void do_flash() {
  flash = add_entity("pixel");
  set_scale(flash, vec(17, 17));
  set_color(flash, 255, 255, 255, 0);
  set_position(flash, focus::get());
  for(float i = 0; i <= 255; i += (255/.5) * get_delta()) {
    
    set_color(flash, i, i, i, i);
    
    yield();
  }
}