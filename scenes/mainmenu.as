
bool are_there_saves()
{
	if (is_slot_used(0)
	||  is_slot_used(1)
	||  is_slot_used(2))
		return true;
	return false;
}

[start]
void start()
{
	set_visible(get_player(), false);
}

entity add_menu_text(const string&in pText, const vec&in pPosition)
{
	entity text = add_text();
	set_text(text, pText);
	make_gui(text, 1);
	set_position(text, pPosition);
	return text;
}

[start]
void mainmenu()
{
	const vec base_position(pixel(20, 150));
	const vec separation(pixel(0, 20));
	
	// Create the little cursor thing
	entity cursor = add_entity("NarrativeBox", "SelectCursor");
	make_gui(cursor, 1);
	set_anchor(cursor, anchor::topright);
	set_position(cursor, base_position);
	
	// Create the selections
	entity selstart = add_menu_text("Start", base_position);
	entity selcontinue = add_menu_text("Continue", base_position + separation);
	if (!are_there_saves())
		set_color(selcontinue, 200, 200, 200, 255); // TODO: Fix engine not supporting this for some reason
	
	entity selexit = add_menu_text("Exit", base_position + separation*2);
	
	do {
	} while(yield());
}

