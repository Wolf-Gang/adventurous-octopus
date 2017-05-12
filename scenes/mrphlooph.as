
#include "backend/dreamland_effects.as"
#include "backend/emote.as"

entity unicorn;
entity phlooph;

[start]
void create_unicorn()
{
  if(!has_flag("bridge_unlocked")) {
    unicorn = add_entity("unicorn", "talk");
    set_position(unicorn, vec(7.5, 5));
    phlooph = add_entity("mrphlooph", "default:default");
    set_position(phlooph, vec(5, 4.5));
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
	say("Only the finest\ncomplete dialogue.");
	
  focus::move(get_position(get_player()), .5);
  focus::player();
  
  narrative::set_speaker(unicorn);
  say("Hmmm, where to find such\na thing?");
  set_atlas(unicorn, "talk_headup");
  say("Oh, I know!");
  set_atlas(unicorn, "talk");
  say("Try his kids.");
  nl("Find them...I don't know where they are.");
  
	narrative::end();
	
	set_atlas(phlooph, "default:default");
	animation::start(phlooph);
	
	music::fade_volume(70, 1);
	focus::move(get_position(get_player()), 0.5);
	focus::player();
	player::lock(false);
  set_flag("phloophgate");
	group::enable("mrphlooph", false);
}

[group unicorn]
void has_dialogue() {
  
  
  narrative::show();
  narrative::set_speaker(unicorn);
  say("Have you returned with the\ndialogue this miscreant desires?");
  
  if(has_flag("very_dialogue")) {
    
    say("Ah yes, very good.");
    
    narrative::set_speaker(phlooph);
    emote phlooph_surprise (phlooph, emote_type::surprise);
    say("HEY");
    phlooph_surprise.remove_emote();
    say("Is that a dialogue?");
    append("Of only the finest variety?");
    say("Gimme");
    move(phlooph, get_position(get_player()), .5);
    say("*Sniff* *Sniff*");
    say("Yes, this will do");
    say("Go, your bridge is open");
    append("I have...matters to attend to.");
    
    narrative::end();
    player::lock(false);
    set_flag("unlockedgate");
    
  } else {
   
    set_atlas(unicorn, "talk_headup");
    say("No?");
    set_atlas(unicorn, "talk");
    say("Well you really should get on that,\n then.");
    narrative::end();
    
  }
  
}

