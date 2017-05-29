

bool are_there_saves()
{
	if (is_slot_used(0)
	||  is_slot_used(1)
	||  is_slot_used(2))
		return true;
	return false;
}

void save_slot(int pSlot) {

  set_slot(pSlot);
  save_game();
  say("Saved to slot " + (pSlot + 1) + "!");
  
}

void load_slot(int pSlot) {
  
  if(is_slot_used(pSlot)) {
  
    set_slot(pSlot);
    open_game();
    
  } else {
    
    dprint("Warning: Attempt to load unused slot");
    
  }
  
}

