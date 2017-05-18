[start]
void start()
{
  set_visible(get_player(), false);
}

void credit_text(string pText)
{
  entity text = add_text();
  make_gui(text, 0);
  set_text(text, pText);
  set_position(text, pixel(10, 150));
  set_color(text, 255, 255, 255, 0);
  
  fx::fade_in(text, 3);
  wait(3);
  fx::fade_out(text, 3);
}

[start]
void credits()
{
  music::volume(70);
  music::open("doodle106", false);
  music::loop(false);
  music::play();
  
  
  credit_text("To be Continued....");
  credit_text("A Game by the\nWolf-Gang Team");
  credit_text("Art:\nNisnow");
  credit_text("Story, Programming:\nWarlordofWaffles\nChocolate Jesus");
  credit_text("Music:\nChocolate Jesus");
  credit_text("I hope you enjoyed this crazyfest.");
  credit_text("Bye-bye.");
  
  // The timing is perfect
  
  load_scene("mainmenu");
}
