int eye_count = 0;

[start]
void start()
{
	music::open("FX_deepvibes");
	set_position(get_player(), vec(5, 7));
	set_direction(get_player(), direction::up);
}

[start]
void create_eye()
{
  entity clarissa = add_entity("clarissa");
  set_anchor(clarissa, anchor::center);
  set_position(clarissa, vec(5.7, 1.9));
	entity eyeyeyey = add_entity("eye", "twitch");
	set_anchor(eyeyeyey, anchor::center);
	set_position(eyeyeyey, vec(5, 2));
	animation::start(eyeyeyey);
	
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

[group eyetoeye]
void eyesee() {
  
  if(eye_count > 16) {
    
    load_scene("happiness");
    
  }
  
  narrative::set_interval(1000);
  say("...");
  narrative::end();
  eye_count++;
  
}

