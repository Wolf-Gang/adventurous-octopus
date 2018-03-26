#include "../backend/dreamland_effects.as"
#include "../backend/shadows.as"
#include "../backend/emote.as"

[start]
void start()
{
	set_position(get_player(), vec(22.5, 25));
}

bool should_scram = false;
array<entity> phloophs;

entity jimmy;


[start]
void create_jimmy()
{
	jimmy = add_entity("bunny", "afraid");
	set_position(jimmy, vec(22.5, 15));
	animation::start(jimmy);
}

[group scram]
void scram()
{
	should_scram = true;
	for (uint i = 0; i < 4; i++)
		quick_emote(phloophs[i], emote_type::surprise, 1, thread());
	say("Someone's here, scram!");
	narrative::end();
	player::lock(false);
	group::enable("scram", false);
}

[group talktoJimmy]
void talktoJimmy()
{
	fsay("...Sniff");
	wait(0.2);
	append(" Sniff...");
	
	animation::stop(jimmy);
	set_atlas(jimmy, "default:down");
	say("Oh! Jimmy me cretins!");
	say("Sorry, I didn't see you there.");
	nl("I was playing with my friends.");
}

[start]
void create_phlooph_event()
{
	for (uint i = 0; i < 4; i++)
	{
		phloophs.insertLast(add_entity("little phlooph", "scary"));
		set_position(phloophs[i], get_position(jimmy) + vec(1, 0).rotate(90*i));
		shadows::add(phloophs[i]);
	}
	while(!should_scram && yield())
	{
		thread hops;
		for (uint i = 0; i < 4; i++)
			move_hop(phloophs[i], get_position(phloophs[i]).rotate(get_position(jimmy), 90), 0.5, 0.5, hops);
		hops.wait();
		wait(1);
	}
	wait(0.5);
	for (uint i = 0; i < 4; i++)
		move_hop(phloophs[i], vec(22, 1), 0.5, 2, thread());
	
}