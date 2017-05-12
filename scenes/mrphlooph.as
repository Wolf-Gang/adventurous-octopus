
#include "backend/dreamland_effects.as"
#include "backend/emote.as"

entity unicorn;
entity phlooph;

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
	say("Silence, druggy.\nLet me talk to your friend.\n");
	say("You.\nYes you.");
	nl("The one with the mask.");
	say("I have a task for you.");
	say("Find all my beautiful\nlittle phloophs and\nI will open the gate.");
	say("The only problem is...");
	nl("They are Veeerry persistent.");
	nl("And might just KILL you.");
	say("Off you go, now.");
	
	narrative::end();
	
	set_atlas(phlooph, "default:default");
	animation::start(phlooph);
	
	music::fade_volume(70, 1);
	focus::move(get_position(get_player()), 0.5);
	focus::player();
	player::lock(false);
	group::enable("mrphlooph", false);
}

[group unicorn]
void has_dialogue() {
  
  
  narrative::show();
  narrative::set_speaker(unicorn);
  say("Have you returned with the\ndialogue this miscreant desires?");
  
  if(has_flag("very_dialogue")) {
    
    narrative::set_speaker(phlooph);
    emote phlooph_surprise (phlooph, emote_type::surprise);
    say("HEY");
    phlooph_surprise.remove_emote();
    say("Is that a dialogue?");
    append("Of only the finest variety?");
    say("Gimme");
    move(phlooph, get_position(get_player()), .5);
    say("*Sniff* *Sniff*");
    say("Yes, this will do.");
    move(phlooph, vec(5, 4.5), 2);
    say("Go, your bridge is open.");
    append("I have...matters to attend to.");
    
    narrative::end();
    player::lock(false);
    set_flag("unlockedgate");
    
  } else {
   
    set_atlas(unicorn, "talk_headup");
    say("No?");
    set_atlas(unicorn, "talk");
    say("Well you really should get on\nthat, then.");
    narrative::end();
    player::lock(false);
    
  }
  
}

