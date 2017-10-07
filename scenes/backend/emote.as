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

class emote
{
	private entity mEmote;
	private entity mTarget;
	
	emote()
	{}
	
	emote(entity pTarget, emote_type pType)
	{
		add_emote(pTarget, pType);
	}
	
	void add_emote(entity pTarget, emote_type pType)
	{
		mTarget = pTarget;
    
    // Translate enum to an atlas name
    string emote_atlas_name;
		switch(pType)
		{
		case emote_type::silence:
      emote_atlas_name = "silence";
			break;
		case emote_type::surprise:
      emote_atlas_name = "surprise";
      break;
    case emote_type::question:
      emote_atlas_name = "question";
      break;
    case emote_type::angry:
      emote_atlas_name = "angry";
      break;
    case emote_type::idea:
      emote_atlas_name = "idea";
      break;
    case emote_type::frustrated:
      emote_atlas_name = "frustrated";
      break;
    case emote_type::embarrassed:
      emote_atlas_name = "embarrassed";
      break;
    default:
      eprint("wat u doin");
      return;
		}
		mEmote = add_entity("emotes", emote_atlas_name);
		
		set_anchor(mEmote, anchor::center);
		set_depth(mEmote, fixed_depth::overlay);
		
		animation::start(mEmote);
		
		create_thread(function(args)
		{
			entity mEmote = entity(args["mEmote"]);
			entity mTarget = entity(args["mTarget"]);
			
			do{
				if (!mTarget.is_valid() || !mEmote.is_valid())
					return;
				set_position(mEmote, get_position(mTarget));
				set_z(mEmote, pixel(get_size(mTarget)).y + 0.25 + get_z(mTarget));
			} while(yield());
			
		}, dictionary = {{"mEmote", mEmote}, {"mTarget" , mTarget}});
	}

	void remove_emote()
	{
		remove_entity(mEmote);
	}
};

void quick_emote(entity pTarget, emote_type pType, float pTime)
{
  emote current_emote(pTarget, pType);
  wait(pTime);
  current_emote.remove_emote();
}
