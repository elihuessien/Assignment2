void setup()
{
  size(800, 500);
  textAlign(CENTER, CENTER);
  
  loadScores();
}
int menu = 0;
String name = "";
boolean init = true;
boolean start = false;
boolean named = false;
int j = 0;
int gap;
int gapcounter = 0;
int gapManager = 1;
int platchg;
int platon = 0;
Ball player;
ArrayList<Platform> platforms = new ArrayList<Platform>();
int size = 0;

ArrayList<Score> scores = new ArrayList<Score>();

void loadScores()
{
  String[] lines = loadStrings("scores.txt");
 
  for(String line:lines)
  {
    String[] elements = line.split(" "); 
    Score score = new Score(elements[0], elements[1], parseInt(elements[2]));
    scores.add(score);
  }
}

void create()
{
  player = new Ball();
  init = false;
}

void draw()
{
  background(0);
  
  if(init)
  {
    cleanup();
    create();
  }
  
  if(menu == 1)
  {
    if(named)
    {
      //game
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
    }
  }
  
  mainMenu();
}

void keyPressed()
{ 
  //game option 1
  if(menu == 1)
  {
    if(named)
    {
      //jump
      if( key == ' ')
      {
        if(player.j == 0 && start)
        {
          player.j = 1;
          player.gravity = 0;
        }
      }
    }
    else
    {
      if( ((key>='A')&&(key<='Z')) || ((key>='a')&&(key<='z')) || ((key>='0')&&(key<='9')) )
      {
         name += key;
      }
      
      if( (key==ENTER) || (key==RETURN) ) 
      {
        named = true;
        player.name = name;
      }
    }
  }
  else
  {
    menuOptions();
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
        init = true;
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
    if(mouseX>width-110 && mouseX<width-(40))
    {
      if(mouseY>height-100 && mouseY<height-(100-20))
      {
        init = true;
        menu = 1;
      }
    }
  }
}

void menuOptions()
{
  if( key == '1')
  {
    init = true;
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
  
  if(menu == 1)
  {
    if(named)
    {
      text(player.name, 100, 50);
      text("Score: " + player.score, width-100, 50);
    }
    else
    {
      fill(255);
      text("Enter your name please: " + name, width/2, height/2);
    }
  }
  
  //instructions
  if(menu == 2)
  {
    background(0);
    fill(255);
    text("Jump!", width/2, height/2-100);
    text("Press spacebar to jump", width/2, height/2 - 20);
    text("Don't fall!", width/2, height/2);
    
    fill(255);
    rect(100, height-100, 50, 20);
    fill(0, 255, 255);
    if(mouseX>100 && mouseX<150)
    {
      if(mouseY>height-100 && mouseY<height-(100-20))
      {
        fill(0);
      }
    }
    text("Menu", 125, height-90);
    
    fill(255);
    rect(width-100, height-100, 50, 20);
    fill(0, 255, 255);
    if(mouseX>width-100 && mouseX<width-(50))
    {
      if(mouseY>height-100 && mouseY<height-(100-20))
      {
        fill(0);
      }
    }
    text("Play", width-75, height-90);
  }
  
  
  //scores menu
  if( menu == 3)
  {
    fill(255);
    text("Jump!", width/2, height/2-100);
    
    textAlign(LEFT);
    text("1st: " + scores.get(0).name , width/2-50, height/2-20);
    text("score: " + scores.get(0).score , width/2+50, height/2-20);
    
    text("2nd: " + scores.get(1).name , width/2-50, height/2);
    text("score: " + scores.get(1).score , width/2+50, height/2);
    
    text("3rd: " + scores.get(2).name , width/2-50, height/2+20);
    text("score: " + scores.get(2).score , width/2+50, height/2+20);
    textAlign(CENTER);
  }
  
  //game over menu
  if(menu == 4)
  {
    background(0);
    fill(255);
    text("Game over :(", width/2, height/2-50);
    text("Your score is: " + player.score, width/2, height/2);
    
    fill(255);
    rect(100, height-100, 50, 20);
    fill(0, 255, 255);
    if(mouseX>100 && mouseX<150)
    {
      if(mouseY>height-100 && mouseY<height-(100-20))
      {
        fill(0);
      }
    }
    text("Menu", 125, height-90);
    
    fill(255);
    rect(width-110, height-100, 70, 20);
    fill(0, 255, 255);
    if(mouseX>width-110 && mouseX<width-(40))
    {
      if(mouseY>height-100 && mouseY<height-(100-20))
      {
        fill(0);
      }
    }
    text("Play again", width-75, height-90);
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
      player.score++;
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
  if(gapcounter > (15)*gap)
  {
    gapcounter = 0;
  }
}

void landCheck()
{
  int num = 1;
  int j = 0;
  
  //stop player's fall while on land
  for(int i=0; i<size; i++)
  {
    if(player.pos.x > platforms.get(i).pos.x && player.pos.x <= (platforms.get(i).pos.x + platforms.get(i).w))
    {
      if(player.pos.y >= (platforms.get(i).pos.y - player.crw/2) && player.pos.y < (platforms.get(i).pos.y)+ platforms.get(i).h)
      {
        num = 0;
        j = i;
      }
      
      //gravitational error margin
      if(player.gravity > 20)
      {
        if(player.pos.y >= (platforms.get(i).pos.y - player.crw/2) && player.pos.y < (platforms.get(i).pos.y) + platforms.get(i).h + 10)
        {
          num = 0;
          j = i;
        }
      }
    }
  }
  
  //apply gravity
  if(num == 1)
  {
    if(start && player.j == 0)
    {
      player.j = 2;
      player.gravity = 15;
    }
  }
  else
  {
    start = true;
    player.j = 0;
    player.gravity = 0;
    player.pos.y = (platforms.get(j).pos.y - player.crw/2);
  }
  
  if(player.pos.y > height)
  {
    scorecheck();
    menu = 4;
  }
}

void scorecheck()
{
  println("hi");
}


void cleanup()
{
  for(int i=0; i<size; i++)
  {
    platforms.remove(0);
  }
  size = 0;
  
  
  start = false;
  named = false;
  name = "";
  j = 0;
  gapcounter = 0;
  gapManager = 1;
  platon = 0;
}
