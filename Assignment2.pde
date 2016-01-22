void setup()
{
  size(800, 500);
  
  player = new Ball();
}

boolean start = false;
int j = 0;
int gap;
int gapcounter = 0;
int gapManager = 1;
int platchg;
int platon = 0;
Ball player;
ArrayList<Platform> platforms= new ArrayList<Platform>();
int size = 0;

void draw()
{
  background(0);
  stroke(255);
  //makes platforms
  platVariables();
  //manages platforms
  platOrganiser();
  
  stroke(0);
  player.update();
  landCheck();
  player.render();
}

void keyPressed()
{
  if( key == ' ')
  {
    if(player.j == 0 && start)
    {
      player.j = 1;
    }
  }
}  


void landCheck()
{
  int num = 0;
  
  if(start && j==0)
  {
    player.j = 2;
    player.gravity = 10;
  }
  
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
  
  println(player.j);
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
