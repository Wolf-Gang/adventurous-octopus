[start]
void start()
{
	music::open("doodle108");
	music::volume(70);
	//set_position(get_player(), vec(0, 0));
}

[group flower]
void flower() {
  say("It's some happy little flowers.");
  say("^.^");
  narrative::end();
  player::lock(false);
}

