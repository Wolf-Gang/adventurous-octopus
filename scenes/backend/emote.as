
enum emote_type
{
	silence,
	surprise,
	question,
	angry,
	idea,
	frustrated,
	embarrassed
};

[start]
void follow_target()
{
	
}

class emote
{
	entity em;
	entity target;
	
	emote()
	{}
	
	emote(entity tEntity, emote_type eType)
	{
		add_emote(tEntity, eType);
	}
	
	void add_emote(entity tEntity, emote_type eType)
	{
	
		target = tEntity;

		switch(eType)
		{
			case emote_type::silence:
				em = add_entity("emotes", "silence");
				break;
			case emote_type::surprise:
				em = add_entity("emotes", "surprise");
				break;
			case emote_type::question:
				em = add_entity("emotes", "question");
				break;
			case emote_type::angry:
				em = add_entity("emotes", "angry");
				break;
			case emote_type::idea:
				em = add_entity("emotes", "idea");
				break;	
			case emote_type::frustrated:
				em = add_entity("emotes", "frustrated");
				break;	
			case emote_type::embarrassed:
				em = add_entity("emotes", "embarrassed");
				break;	
		}
		
		set_anchor(em, anchor::center);
		set_depth(em, fixed_depth::overlay);
		
		animation::start(em);
		
		create_thread(function(args)
		{
			entity em = entity(args["em"]);
			entity t = entity(args["t"]);
			
			do{
				if (!t.is_valid() || !em.is_valid())
					return;
				set_position(em, get_position(t));
				set_z(em, pixel(get_size(t)).y + 0.25 + get_z(t));
			} while(yield());
			
		}, dictionary = {{"em", em}, {"t" , target}});
	}

	void remove_emote()
	{
		remove_entity(em);
	}	
};