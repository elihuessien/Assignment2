void setup()
{
  size(800, 500);
  textAlign(CENTER, CENTER);
  
  player = new Ball();
}
int menu = 0;
boolean start = false;
int j = 0;
int gap;
int gapcounter = 0;
int gapManager = 1;
int platchg;
int platon = 0;
Ball player;
ArrayList<Platform> platforms = new ArrayList<Platform>();
int size = 0;

void draw()
{
  if(menu == 1)
  {
    //game
    background(0);
    fill(255);
    stroke(255);
    //makes platforms
    platVariables();
    //manages platforms
    platOrganiser();
    
    stroke(0);
    player.update();
    landCheck();
    player.render();
    endcheck();
  }
  else
  {
    mainMenu();
  }
}

void keyPressed()
{
  if(menu == 0)
  {
    menuOptions();
  }
  
  //game option 1
  if(menu == 1)
  {
    //jump
    if( key == ' ')
    {
      if(player.j == 0 && start)
      {
        player.j = 1;
      }
    }
  }

}

void mousePressed()
{
  if(menu == 2)
  {
    //menu botton
    if(mouseX>100 && mouseX<150)
    {
      if(mouseY>height-100 && mouseY<height-(100-20))
      {
        menu = 0;
      }
    }
    
    //play botton
    if(mouseX>width-100 && mouseX<width-(50))
    {
      if(mouseY>height-100 && mouseY<height-(100-20))
      {
        menu = 1;
      }
    }
  }
  
  if(menu == 4)
  {
    //menu botton
    if(mouseX>100 && mouseX<150)
    {
      if(mouseY>height-100 && mouseY<height-(100-20))
      {
        menu = 0;
      }
    }
    
    //play botton
    if(mouseX>width-100 && mouseX<width-(50))
    {
      if(mouseY>height-100 && mouseY<height-(100-20))
      {
        cleanup();
        menu = 1;
      }
    }
  }
}

void menuOptions()
{
  if( key == '1')
  {
    menu = 1;
  }
  
  if( key == '2')
  {
    menu = 2;
  }
  
  if( key == '3')
  {
    menu = 3;
  }
}

void mainMenu()
{
  //opening
  if(menu == 0)
  {
    fill(255);
    background(0);
    text("Jump!", width/2, height/2-100);
    text("1: Play", width/2, height/2-20);
    text("2: Instructions", width/2, height/2);
    text("3: Highcores", width/2, height/2+20);
  }
  
  //instructions
  if(menu == 2)
  {
    background(0);
    fill(255);
    text("Jump!", width/2, height/2-100);
    text("Press spacebar to jump", width/2, height/2 - 20);
    text("Don't fall!", width/2, height/2);
    
    
    rect(100, height-100, 50, 20);
    rect(width-100, height-100, 50, 20);
    fill(0, 255, 255);
    text("Menu", 125, height-90);
    text("Play", width-75, height-90);
  }
  
  if(menu == 4)
  {
    background(0);
    fill(255);
    text("Game over :(", width/2, height/2);
    
    rect(100, height-100, 50, 20);
    rect(width-100, height-100, 50, 20);
    fill(0, 255, 255);
    text("Menu", 125, height-90);
    text("Play again", width-75, height-90);
  }
}



void landCheck()
{
  int num = 0;
  
  //apply gravity
  if(start && j==0)
  {
    player.j = 2;
    player.gravity = 10;
  }
  
  //stop player's fall while on land
  for(int i=0; i<size; i++)
  {
    if(player.pos.x > platforms.get(i).pos.x && player.pos.x <= (platforms.get(i).pos.x + platforms.get(i).w))
    {
      if(player.pos.y >= (platforms.get(num).pos.y - player.crw/2) && player.pos.y < (platforms.get(i).pos.y)+ platforms.get(i).h)
      {
        start = true; 
        player.j = 0;
        player.gravity = 0;
        player.pos.y = (platforms.get(num).pos.y - player.crw/2);
      }
    }
  }
}

void platOrganiser()
{
  for(Platform p: platforms)
  {
    p.update();
    p.render();
  }
  
  int delete = -1;
  
  //delete used platforms
  for(int i=0; i<size; i++)
  {
    if(platforms.get(i).pos.x < 0)
    {
      delete = i;
    }
  }
  if(delete > -1)
  {
    platforms.remove(delete);
    size--;
  }
}

void platVariables()
{
  if(gapcounter == 0)
  {
    if(gapManager==0)
    {
      gap = int(random(1,2.1));
      if(gap == 2)
      {
        gapManager = 1;
      }
    }
    else
    {
      gap = 1;
      gapManager = 0;
    }
    
    int change=0;
    
    while(change == 0)
    {
      platchg = int(random(-3,3.5));
      
      if( (platon + platchg) < 8 && (platon + platchg) > 2)
      {
        change = 1;
        platon = (platon + platchg);
      }
    }
    
    //creat new platform
    Platform platform = new Platform();
    platform.pos.x = width;
    platform.pos.y = 100+(50*platon);
    platforms.add(platform);
    size++; 
  }
  
  
  //wait for next platform
  gapcounter++;
  if(gapcounter > (14)*gap)
  {
    gapcounter = 0;
  }
}

void endcheck()
{
  if(player.pos.y > height)
  {
    menu = 4;
  }
}

void cleanup()
{
  for(int i=0; i<size; i++)
  {
    platforms.remove(0);
  }
  size = 0;
  
  menu = 4;
  start = false;
  j = 0;
  gapcounter = 0;
  gapManager = 1;
  platon = 0;
}
