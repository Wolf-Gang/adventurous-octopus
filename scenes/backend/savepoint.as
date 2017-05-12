
// TODO
void open_savepoint()
{
	entity bg = add_entity("pixel");
	make_gui(bg, 0);
	set_scale(bg, vec(10, 10)*32);
	set_color(bg, 0, 0, 0, 255);
	
	array<entity> slots(3);
	slots[0] = add_entity("pixel");
	
	int currect_selection = 0;
	
	do{
		if (is_triggered(control::select_up) && currect_selection != 0)
			--currect_selection;
		if (is_triggered(control::select_down) && currect_selection != 2)
			++currect_selection;
		
	}while(yield())
	
}
