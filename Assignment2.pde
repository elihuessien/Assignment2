void setup()
{
  size(800, 500);
  textAlign(CENTER, CENTER);
  loadScores();
}
int menu = 0;
int save = 0;
int level = 0;
String name = "";
boolean init = true;
boolean start = false;
boolean named = false;
int gap;
int gapcounter = 0;
int gapManager = 1;
int platchg;
int platon = 0;
Ball player;
ArrayList<Platform> platforms = new ArrayList<Platform>();
int size = 0;

int scoreNum = 0;
ArrayList<Score> scores = new ArrayList<Score>();

void loadScores()
{
  String[] lines = loadStrings("scores.txt");
 
  for(String line:lines)
  {
    String[] elements = line.split(" "); 
    Score score = new Score(elements[0], elements[1], parseInt(elements[2]));
    scores.add(score);
    scoreNum++;
  }
  
  for(int i = 0; i<scores.size(); i++ )
  {
    println(scores.get(i).place + " " + scores.get(i).name + " " +scores.get(i).score);
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
    create();
  }
  
  if(menu == 2)
  {
    if(named)
    {
      save = 1;
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
  if(menu == 2)
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
      //inserting name with max character limit
      if( (((key>='A')&&(key<='Z')) || ((key>='a')&&(key<='z')) || ((key>='0')&&(key<='9'))) && name.length() < 10 )
      {
         name += key;
      }
      
      //enabling backspace
      if (keyCode == BACKSPACE) 
      {
        if (name.length() > 0) 
        {
          name = name.substring(0, name.length()-1);
        }
      }
      
      //Delete button
      if (keyCode == DELETE) 
      {
        name = "";
      }
      
      //enter button
      if( (key==ENTER) || (key==RETURN) ) 
      {
        //ensure name is inputed
        if (name.length() > 0) 
        {
          named = true;
          player.name = name;
        }
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
  if(menu == 0)
  {
    if(mouseX > width/2-25 && mouseX < width/2+25)
    {
      if(mouseY > height/2-30 && mouseY < height/2-10)
      {
        init = true;
        level = 0;
        menu = 1;
      }
    }//end easy button if
    
    
    if(mouseX > width/2-25 && mouseX < width/2+25)
    {
      if(mouseY > height/2-10 && mouseY < height/2+10)
      {
        init = true;
        level = 1;
        menu = 1;
      }
    }//end medium button if
    
    
    if(mouseX > width/2-25 && mouseX < width/2+25)
    {
      if(mouseY > height/2+10 && mouseY < height/2+30)
      {
        init = true;
        level = 2;
        menu = 1;
      }
    }//end Hard button if
  }
  
  if(menu == 1)
  {
    //level select menu botton
    if(mouseX>100 && mouseX<150)
    {
      if(mouseY>height-100 && mouseY<height-(100-20))
      {
        menu = 0;
      }
    }
  }
  
  if(menu > 2)
  {
    //menu botton
    if(mouseX>100 && mouseX<150)
    {
      if(mouseY>height-100 && mouseY<height-(100-20))
      {
        menu = 1;
      }
    }
    
    //play botton
    if(mouseX>width-100 && mouseX<width-(50))
    {
      if(mouseY>height-100 && mouseY<height-(100-20))
      {
        init = true;
        menu = 2;
      }
    }
  }
}

void menuOptions()
{
  if( key == '1')
  {
    init = true;
    menu = 2;
  }
  
  if( key == '2')
  {
    menu = 3;
  }
  
  if( key == '3')
  {
    menu = 4;
  }
}

void mainMenu()
{
  //Level Select
  if(menu == 0)
  {
    fill(255);
    stroke(255);
    text("Jump!", width/2, height/2-100);
    fill(0);
    rect(width/2-25, height/2-30, 50, 20);
    fill(255);
    if(mouseX > width/2-25 && mouseX < width/2+25)
    {
      if(mouseY > height/2-30 && mouseY < height/2-10)
      {
        fill(0, 255, 255);
      }
    }
    text("Easy", width/2, height/2-20);
    
    
    fill(0);
    rect(width/2-25, height/2-10, 50, 20);
    fill(255);
    if(mouseX > width/2-25 && mouseX < width/2+25)
    {
      if(mouseY > height/2-10 && mouseY < height/2+10)
      {
        fill(0, 255, 255);
      }
    }
    text("Medium", width/2, height/2);
    
    
    fill(0);
    rect(width/2-25, height/2+10, 50, 20);
    fill(255);
    if(mouseX > width/2-25 && mouseX < width/2+25)
    {
      if(mouseY > height/2+10 && mouseY < height/2+30)
      {
        fill(0, 255, 255);
      }
    }
    text("Hard", width/2, height/2+20);
  }
  //opening
  if(menu == 1)
  {
    fill(255);
    background(0);
    text("Jump!", width/2, height/2-100);
    text("1: Play", width/2, height/2-20);
    text("2: Instructions", width/2, height/2);
    text("3: Highcores", width/2, height/2+20);
    
    fill(255);
    rect(100, height-100, 50, 20);
    fill(0);
    if(mouseX>100 && mouseX<150)
    {
      if(mouseY>height-100 && mouseY<height-(100-20))
      {
        fill(0, 255, 255);
      }
    }
    text("Levels", 125, height-90);
  }
  
  if(menu == 2)
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
  if(menu == 3)
  {
    background(0);
    fill(255);
    text("Jump!", width/2, height/2-100);
    text("Press spacebar to jump", width/2, height/2 - 20);
    text("Don't fall!", width/2, height/2);
  }
  
  
  //scores menu
  if( menu == 4)
  {
    fill(255);
    text("Jump!", width/2, height/2-100);
    
    textAlign(LEFT, CENTER);
    int j = 0;
    for(int i = level; i<scores.size(); i+=3 )
    {
      text(scores.get(i).place + ": " + scores.get(i).name , width/2-70, height/2+(-20+(j*20)));
      text("score: " + scores.get(i).score , width/2+40, height/2+(-20+j*20));
      j++;
    }
    textAlign(CENTER, CENTER);
  }
  
  //game over menu
  if(menu == 5)
  {
    background(0);
    fill(255);
    text("Game over :(", width/2, height/2-50);
    text("Your score is: " + player.score, width/2, height/2);
    
    fill(255);
    rect(100, height-100, 50, 20);
    fill(0);
    
    if(save == 1)
    {
      cleanup();
      save = 0;
    }
  }
  
  if(menu > 2)
  {
    fill(255);
    rect(100, height-100, 50, 20);
    fill(0);
    if(mouseX>100 && mouseX<150)
    {
      if(mouseY>height-100 && mouseY<height-(100-20))
      {
        fill(0, 255, 255);
      }
    }
    text("Menu", 125, height-90);
    
    fill(255);
    rect(width-100, height-100, 50, 20);
    fill(0);
    if(mouseX>width-100 && mouseX<width-(50))
    {
      if(mouseY>height-100 && mouseY<height-(100-20))
      {
        fill(0, 255, 255);
      }
    }
    text("Play", width-75, height-90);
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
    if(level == 0)
    {
      if((platforms.get(i).pos.x + platforms.get(i).w/2)< 0)
      {
        delete = i;
        player.score++;
      }
    }
    else
    {
      if((platforms.get(i).pos.x + platforms.get(i).w/2)< 0)
      {
        delete = i;
        player.score++;
      }
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
      
      //easy level no gaps
      if(level == 0)
      {
        gap = 1;
      }
      
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
  
  int spacing = 23;
  
  if(level == 1)
  {
    spacing = 19;
  }
  
  if(level == 2)
  {
    spacing = 15;
  }
  
  
  if(gapcounter > (spacing)*gap)
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
    menu = 5;
  }
}

void scorecheck()
{
  //make a new score element
  Score score = new Score("Extra", player.name, player.score);
  scores.add(score);
  
  int tempScore = scores.get(0).score;
  String tempName = scores.get(0).name;
  
  if(scores.get(scoreNum).score > scores.get(scoreNum-(3-level)).score)
  {
    tempScore = scores.get(scoreNum).score;
    tempName = scores.get(scoreNum).name;
    
    scores.get(scoreNum).score = scores.get(scoreNum-(3-level)).score;
    scores.get(scoreNum).name = scores.get(scoreNum-(3-level)).name;
    
    scores.get(scoreNum-(3-level)).score = tempScore;
    scores.get(scoreNum-(3-level)).name = tempName;
  }
  
  //sorting algorithm
  for(int j = level; j < scoreNum-3; j+=3)
  {
    for(int i = level; i < scoreNum-3; i+=3)
    {
      if(scores.get(i).score < scores.get(i+3).score)
      {
        tempScore = scores.get(i).score;
        tempName = scores.get(i).name;
        
        scores.get(i).score = scores.get(i+3).score;
        scores.get(i).name = scores.get(i+3).name;
        
        scores.get(i+3).score = tempScore;
        scores.get(i+3).name = tempName;
      }
    }
  }
  
  scores.remove(scoreNum);
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
  gapcounter = 0;
  gapManager = 1;
  platon = 0;
  
  ArrayList<String> saves = new ArrayList<String>();
 //load scores into strings
  for(Score s:scores)
  {
    String scorelist = (s.place + " " + s.name + " " + str(s.score));
    saves.add(scorelist);
  }
  
  
  PrintWriter saveScores = createWriter("data/scores.txt");
  //print strings to the data file
  for(int i = 0; i<saves.size(); i++ )
  {
    saveScores.println(saves.get(i));
  }
  
  saveScores.flush();
  saveScores.close();
}
