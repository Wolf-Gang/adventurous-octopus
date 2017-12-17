[start]
void start()
{
	music::open("doodle108");
	music::set_volume(0.7);
	//set_position(get_player(), vec(0, 0));
  wait(0.2);
}

[group flower]
void flower() {
  say("It's some happy little flowers.");
  say("^.^");
  narrative::end();
  player::lock(false);
}

