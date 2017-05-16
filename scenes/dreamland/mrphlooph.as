
#include "../backend/dreamland_effects.as"
#include "../backend/emote.as"

entity unicorn;
entity phlooph;

[start]
void create_meadow()
{
	// Top
	create_flower_patch(vec(1, -1), vec(17, 9), 2);
	
	// Left
	create_flower_patch(vec(1, 3), vec(5, 13), 2);
}

[start]
void create_phlooph()
{
	if (has_flag("phloophgate"))
	{
		phlooph = add_entity("mrphlooph", "default:default");
		set_position(phlooph, vec(5, 4.5));
	}
}

[start]
void create_unicorn()
{
  if(!has_flag("bridge_unlocked")) {
    unicorn = add_entity("unicorn", "talk");
    set_position(unicorn, vec(7.5, 5));
    if(!has_flag("phloophgate")) {
      group::enable("unicorn", false);
    }
  } else {
    group::enable("unicorn", false);
  }
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

[start]
void event_check() {
  if(has_flag("phloophgate")) {
    group::enable("mrphlooph", false);
  }
}

[group mrphlooph]
void mrphlooph()
{
	once_flag("phloophgate");
	music::fade_volume(40, 1);
	player::lock(true);
	focus::move(vec(5, 4), 1);
	
	narrative::show();
	narrative::set_speaker(unicorn);
	set_atlas(unicorn, "talk_headup");
	say("MR PHLOOOPH!");
	set_atlas(unicorn, "talk");
	
	narrative::hide();
	
	// Create the phlooph of POWER
	phlooph = add_entity("mrphlooph", "justphlooph");
	set_position(phlooph, vec(5, 1));
	set_depth(phlooph, fixed_depth::overlay); // Visible above the tree
	
	music::pause();
	fx::sound("heh");
	move(phlooph, direction::down, 3.5, 1); // Mr phlooph has a fall
	set_depth_fixed(phlooph, false); // Set to normal depth after falling
	fx::sound("heh");
	wait(1);
	
	set_atlas(phlooph, "awakening");
	animation::start(phlooph);
	wait(1);
	set_atlas(phlooph, "talk");
	
	narrative::set_expression("mrphlooph icon", "default:default");
	narrative::set_speaker(phlooph);
	say("Haah?");
	music::play();
	say("What did you wake me for? Druggy.");
	
	narrative::set_expression("unicorn icon", "default:default");
	narrative::set_speaker(unicorn);
	say("You left your gate closed again.");
	
	narrative::set_expression("mrphlooph icon", "default:default");
	narrative::set_speaker(phlooph);
	say("Can a phlooph not have his privacy?");
	
	narrative::set_expression("unicorn icon", "default:default");
	narrative::set_speaker(unicorn);
	say("Not that. The bridge!");
	
	narrative::set_expression("mrphlooph icon", "default:default");
	narrative::set_speaker(phlooph);
	say("Let's make this clear.");
	nl("I only open my gate when I want to.");
	
	narrative::set_speaker(unicorn);
	narrative::set_expression("unicorn icon", "default:default");
	set_atlas(unicorn, "talk_headup");
	say("Ugh!");
	set_atlas(unicorn, "talk");
	nl("What do you want?");
	
	narrative::set_speaker(phlooph);
	narrative::set_expression("mrphlooph icon", "default:default");
	say("Silence, druggy. Let me talk to your friend.");
	say("You. Yes you.");
	nl("Hood'n mask.");
	say("I have a task for you.");
	say("Find all my beautiful little phloophs");
	nl("and I will open the gate.");
	narrative::set_expression("mrphlooph icon", "sleepy");
	say("The only problem is...");
	narrative::set_expression("mrphlooph icon", "default:default");
	nl("They are Veeerry persistent.");
	narrative::set_expression("mrphlooph icon", "sinister");
	nl("And might just kill you.");
	narrative::set_expression("mrphlooph icon", "default:default");
	say("Off you go, now.");
	
	narrative::set_expression("unicorn icon", "default:default");
	narrative::set_speaker(unicorn);
	set_atlas(unicorn, "talk_headup");
	say("HOLD IT!");
	set_atlas(unicorn, "talk");
	nl("This our special guest.");
	nl("Why would you send h...umm out to an errand?");
	
	narrative::set_expression("mrphlooph icon", "sleepy");
	narrative::set_speaker(phlooph);
	say("You see... They are around that age now.");
	nl("And they don't like me for some reason...");
	narrative::set_expression("mrphlooph icon", "default:default");
	nl("As a father, I would be very thankful.");
	
	narrative::set_expression("unicorn icon", "default:default");
	narrative::set_speaker(unicorn);
	fsay("Hmmm...");
	wait(0.2);
	append(" fine.");
	narrative::end();
	
	set_atlas(phlooph, "default:default");
	animation::start(phlooph);
	
	music::fade_volume(70, 1);
	focus::move(get_position(get_player()), 0.5);
	focus::player();
	player::lock(false);
	group::enable("mrphlooph", false);
  set_flag("phlooph");
}

[group unicornbehere]
void ajsdfh()
{
	narrative::show();
	narrative::set_speaker(unicorn);
	narrative::set_expression("unicorn icon", "default:default");
	say("I'll stay here.");
	nl("Go find his little phloophs and come back.");
	narrative::end();
	player::lock(false);
}

