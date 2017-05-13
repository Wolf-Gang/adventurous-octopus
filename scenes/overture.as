[start]
void start()
{
	music::open("doodle110_start", false);
	music::volume(0);
	music::play();
	music::fade_volume(70, 5);
	set_visible(get_player(), false);
}

[start]
void stuff()
{
	wait(2);
	narrative::show();
	narrative::set_interval(100);
	
	say("Broken, lost, and nothing left.");
	
	say("You are just a fading glimpse\nof your past.");
	
	say("Ugly, soulless, and disgraceful.");
	
	say("Wear this mask\nand lose yourself.");
	
	say("For your adventure starts here.");
	music::fade_volume(0, 3);
	fx::fade_out(3);
	narrative::end();
	load_scene("mainmenu");
}
