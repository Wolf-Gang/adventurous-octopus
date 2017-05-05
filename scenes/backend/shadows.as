// A shadows thing. Yay.

// Functions:
//       void shadows::add(entity pEntity, shadow_size pShadow_size = shadow_size::small)
//       bool shadows::remove(entity pEntity);

// Placement:
//        Placement of shadows is highly
//        subjective and can vary greatly
//        between style and the current
//        context.
// [CJ]   Shadows should be placed on entities
//        that float to give them that "depth"
//        that is lacking without it. Entities
//        on the ground can go without and IMO
//        feels intrusive (especially when 
//        placed on the player). However;
//        situations where there is one entity
//        with a shadow and all the others are
//        without in a given scene may seem a
//        bit off (maybe).

// Disadvantage:
//   -    Shadows WILL overlap the tile-map and
//        the result may not always be pleasing.
//        Like overlapping walls or a "floating" 
//        shadow. This is one of the reasons I
//        recommended not placing it on the
//        player.
//   -    LOTS OF MANAGING AND MAINTAINING... of
//        shadows if your scene has a lot of
//        entities or a very dynamic scene.
//        However; it is always good to stylize
//        in a way that requires minimal
//        shadows.

namespace shadows
{

namespace priv
{

class entry
{
	entity shadow;
	entity target;
	
	void clean()
	{
		remove_entity(shadow);
	}
};

array<entry> entries;

[start]
void shadow_loop()
{
	const float max_fade = 150;
	const float max_distance = 2;

	do {
		for (uint i = 0; i < entries.length(); i++)
		{
			// Remove this entry if entities were removed
			if (!entries[i].target.is_valid())
			{
				entries[i].clean();
				entries.removeAt(i);
				continue;
			}
			
			// Slightly fade out when entity is floating away from ground
			const float z_distance = abs(get_z(entries[i].target));
			if (z_distance < max_distance)
			{
				const int alpha = 255 - int((z_distance/max_distance)*max_fade);
				set_color(entries[i].shadow, 255, 255, 255, alpha);
			}
			else
			{
				set_color(entries[i].shadow, 255, 255, 255, 255 - max_fade);
			}
			
			// Update position
			set_position(entries[i].shadow, get_position(entries[i].target));
		}
	} while (yield());
}


// Give player a shadow
/* Just leaving this here for consideration later
[start]
void add_player()
{
	if (!has_flag("no_player_shadow"))
		shadows::add(get_player(), shadow_size::small);
}*/

}

enum shadow_size
{
	big,
	small
}

/// Register entity to display shadow on
void add(entity pEntity, shadow_size pShadow_size = shadow_size::small)
{
	if (!pEntity.is_valid())
	{
		eprint("Entity is not valid. Failed to add shadow.");
		return;
	}

	shadows::priv::entry new_entry;
	new_entry.target = pEntity;
	
	switch (pShadow_size)
	{
	case shadow_size::big:
		new_entry.shadow = add_entity("shadow", "shadow");
		break;
	case shadow_size::small:
		new_entry.shadow = add_entity("shadow", "small_shadow");
		break;
	}
	set_anchor(new_entry.shadow, anchor::center);
	set_depth(new_entry.shadow, fixed_depth::below);
	shadows::priv::entries.insertLast(new_entry);
}

bool remove(entity pEntity)
{
	for (uint i = 0; i < shadows::priv::entries.length(); i++)
	{
		if (shadows::priv::entries[i].target == pEntity)
		{
			shadows::priv::entries.removeAt(i);
			return true;
		}
	}
	return false;
}

}