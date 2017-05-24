entity statue_vill;

[start]
void start()
{
	set_position(get_player(), vec(.5, 6.5));
}

[start]
void create_vill()
{
	statue_vill = add_entity("statue vill", "default:default");
	set_position(statue_vill, vec(27.5, 6.75));
}

[group statue]
void talk_to_statue()
{
	narrative::show();
	say("Who's this nerd?");
	nl("Seems like a nice guy.");
	narrative::end();
	
	player::lock(false);
}