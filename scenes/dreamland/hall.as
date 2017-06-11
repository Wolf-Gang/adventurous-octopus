
entity smol_phlooph;

[start]
void start()
{
	set_position(get_player(), vec(2.5, 5));
}

[start]
void smol_phloophphlooph() {
  if(has_flag("phlooph") && !has_flag("unlockedgate")) {
    smol_phlooph = add_entity("little phlooph");
    set_position(smol_phlooph, vec(1.5, 5.2));
    animation::start(smol_phlooph);
  }
}

[start]
void check_events()
{
  if(!has_flag("phlooph"))
  {
    entity cover1 = add_entity("dreamland", "ground");
    set_position(cover1, vec(0, 6));
    set_scale(cover1, vec(2, 2));
    
    entity cover2 = add_entity("dreamland", "side_clouds");
    set_position(cover2, vec(1.5, 5));
    
    entity cover3 = add_entity("dreamland", "side_clouds");
    set_position(cover3, vec(1.5, 6));
    
    group::enable("littlephloph", false);
  }
  
  if(has_flag("phlooph") && !has_flag("unlockedgate"))
    event_count = 0;
  else
  if(has_flag("unlockedgate"))
    event_count = 2;
}

uint event_count;

[group littlephlooph]
void little_phlooph() {
  
  switch(event_count)
  {
    case 0:
      say("So my dad wants you to find us, huh?");
      nl("This way.");
      narrative::end();
      
      for(float t = 0; t < 2; t += get_delta()) {
        set_position(smol_phlooph, vec(1.5, 5.2) + vec( -1 * t, .25 * ((t - 1)**2 - 1))); //so many parentheses
        yield();
      }
      
      set_visible(smol_phlooph, false);
      
      player::lock(false);
      event_count++;
      break;
    case 1:
    case 2:
      fsay(event_count == 1 ? "Follow the phlooph?" : "Enter the phlooph hideout?");
      if(select("Yes", "No") == option::first)
        load_scene("dreamland/dangerous_game");
      
      narrative::end();
      player::lock(false);
      break;
  }
}

