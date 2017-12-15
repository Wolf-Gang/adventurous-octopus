
entity smile_door;
entity aura;


[start]
void start()
{
	music::set_volume(80);
  music::open("doodle171-AFV-First-Meet");
	set_position(get_player(), vec(-0.5, 5));
}

[group say1]
void say1()
{
  say("<shake>Happiness...</shake>");
  say("<shake>Flowers...</shake>");
  say("<shake>Peace...</shake>");
  say("<shake>There is only one thing I need to do...</shake>");
  narrative::end();
  group::enable("say1", false);
  player::lock(false);
}

[start]
void create_door()
{
  smile_door = add_entity("smile", "door");
  set_anchor(smile_door, anchor::center);
  set_position(smile_door, vec(-0.5, -6.4));
  animation::start(smile_door);
}

[group throughthedoor]
void throughthedoor()
{
  player::lock(true);
  set_atlas(aura, "auradisappear");
  animation::start(aura);
  fx::fade_out(get_player(), 1);
  
  music::stop();
  fx::sound("augmenting");
  set_atlas(smile_door, "doordisappear");
  animation::play_wait(smile_door);
  
  set_atlas(smile_door, "default:default");
  animation::start(smile_door);
  wait(0.5);
  
  set_atlas(smile_door, "default:default");
  fsay("... Smile ...");
  
  wait(1);
  narrative::end();
  fx::sound("dum");
  entity blackout = add_entity("pixel");
  make_gui(blackout, 1);
  set_scale(blackout, get_display_size());
  set_color(blackout, 0, 0, 0, 255);
  set_anchor(blackout, anchor::topleft);
  wait(2);
  load_scene("dreamland/happystart");
}

/*
[group smilesforeveryone]
void smilesforeveryone()
{
  player::lock(true);
  
  focus::move(vec(-0.5, -5), 2);

  fx::sound("smileappear", 60);
  
  entity smile = add_entity("smile", "appear");
  set_anchor(smile, anchor::center);
  set_position(smile, vec(-0.5, -7));
  animation::play_wait(smile);
  set_atlas(smile, "default:default");
  animation::start(smile);
  
  music::open("doodle131");
  
  say("<shake>...</shake>");
  nl("<shake>.....I....</shake>");
  nl("<shake>.....Smile.....</shake>");
  nl("<shake>.....I....</shake>");
  nl("<shake>.....Happy....</shake>");
  nl("<shake>.....I....</shake>");
  nl("<shake>.....Want....</shake>");
  
  set_atlas(smile, "happy");
  nl('<c r="255"><shake>.....More....</shake></c>');
  narrative::end();
  
  fx::sound("dum");
  music::stop();
  entity blackout = add_entity("pixel");
  make_gui(blackout, 1);
  set_scale(blackout, get_display_size());
  set_color(blackout, 0, 0, 0, 255);
  set_anchor(blackout, anchor::topleft);
  wait(0.5);

}*/

