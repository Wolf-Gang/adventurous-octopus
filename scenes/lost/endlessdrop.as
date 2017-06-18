[start]
void start()
{
	set_position(get_player(), vec(-1.5, 0.5));
  music::open("scribbles100");
}

void create_spike(vec pPosition)
{
  entity spike = add_entity("lost", "spikes");
  set_depth(spike, fixed_depth::background);
  set_position(spike, pPosition);
  set_parallax(spike, -5);
}

[start]
void create_spikes()
{
  create_spike(vec(2, 5));
  create_spike(vec(8, 15));
  create_spike(vec(1, 10));
}

[group blobguy]
void blobguy()
{
  say("Hey, fellow yummy ball of darkness.");
  say("Want a thingamajig?");
  fnl("Too bad."); // Possibly a store?
  wait(0.2);
  append(" I have no thingamajig.");
  say("It's a harsh place down here, don't get lost and die.");
  narrative::end();
  player::lock(false);
}

namespace fuzz{
array<entity> thefuzz(9);

void set_opacity(float pOpacity)
{
  for (uint i = 0; i < thefuzz.length(); i++)
  {
    set_color(thefuzz[i], 255, 255, 255, int(pOpacity));
  }
}

[start]
void create_fuzzthing()
{
  for (uint i = 0; i < thefuzz.length(); i++)
  {
    thefuzz[i] = add_entity("fuzz");
    set_anchor(thefuzz[i], anchor::topleft);
    make_gui(thefuzz[i], -1);
    set_position(thefuzz[i], vec((i%3)*4, floor(i/3)*4));
    animation::start(thefuzz[i]);
    set_color(thefuzz[i], 255, 255, 255, 0);
  }
}

}

[start]
void create_eyewatcher()
{
  /*entity watcher1 = add_entity("eyewatcher");
  set_position(watcher1, vec(0, 4));
  set_atlas(watcher1, "watch:right");
  
  while(yield())
  {
    float distance = abs(get_position(get_player()).y - get_position(watcher1).y);
    if (distance < 2)
      fuzz::set_opacity(255*(1 - distance/2));
    else
      fuzz::set_opacity(0);
  }*/
  
  /*entity eyewatcherlight1 = add_entity("eyewatcherlight");
  set_anchor(eyewatcherlight1, anchor::left);
  set_depth(eyewatcherlight1, fixed_depth::overlay);
  set_position(eyewatcherlight1, vec(0, 3));
  animation::start(eyewatcherlight1);*/
}
