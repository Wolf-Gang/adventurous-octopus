
#include "backend/dreamland_effects.as"

entity unicorn;

[start]
void create_unicorn()
{
	unicorn = add_entity("unicorn", "talk");
    set_position(unicorn, vec(7.5, 5));
}

[start]
void start()
{
	music::open("doodle104_2");
	music::volume(70);
	set_position(get_player(), vec(5, 9));
}

[start]
void create_tree()
{
	entity tree = add_entity("cloud tree", "rustle");
	set_position(tree, vec(5, 4));
	animation::start(tree);
}

[group mrphlooph]
void mrphlooph()
{
	music::fade_volume(40, 1);
	player::lock(true);
	focus::move(vec(5, 4), 1);
	
	narrative::show();
	narrative::set_speaker(unicorn);
	set_atlas(unicorn, "talk_headup");
	say("MR PHLOOOPH!");
	set_atlas(unicorn, "talk");
	
	narrative::hide();
	
	// Creat the phlooph of POWER
	entity phlooph = add_entity("mrphlooph", "justphlooph");
	set_position(phlooph, vec(5, 1));
	set_depth(phlooph, fixed_depth::overlay); // Visible above the tree
	
	music::pause();
	fx::sound("heh");
	move(phlooph, direction::down, 3.5, 1); // Mr phlooph has a fall
	set_depth_fixed(phlooph, false); // Set to normal depth after falling
	fx::sound("heh");
	wait(1);
	
	set_atlas(phlooph, "default:default");
	wait(1);
	
	narrative::set_speaker(phlooph);
	say("Haah?");
	music::play();
	say("What did you wake me for?\nDruggy.");
	
	narrative::set_speaker(unicorn);
	say("You left your gate closed again.");
	
	narrative::set_speaker(phlooph);
	say("Can a phlooph not have his\nprivacy?");
	
	narrative::set_speaker(unicorn);
	say("Not that. The bridge!");
	
	narrative::set_speaker(phlooph);
	say("Let's make this clear.");
	nl("I only open my gate when\nI want to.");
	
	narrative::set_speaker(unicorn);
	set_atlas(unicorn, "talk_headup");
	say("Ugh!");
	set_atlas(unicorn, "talk");
	nl("What do you want?");
	
	narrative::set_speaker(phlooph);
	say("Only the finest\ncomplete dialogue.");
	
	narrative::end();
	
	music::fade_volume(70, 1);
	focus::move(get_position(get_player()), 0.5);
	focus::player();
	player::lock(false);
	group::enable("mrphlooph", false);
}
