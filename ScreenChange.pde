class ScreenChange
{
  //growth variable
  float j;
  int colorChange;
  int k;
  int dir;
  
  ScreenChange()
  {
    j=0;
    k=1;
    dir=0;
    colorChange = 1;
  }
  
  void update()
  {
    if(k==0)
    {
      if(j <= width*4)
      {
        if(colorChange == 0)
        {
          background(0);
          fill(102, 102, 102);
        }
        else
        {
          background(102, 102, 102);
          fill(0);
        }
        render();
        j+=30;
      }
      else
      {
        k=1;
        dir++;
      }
    }//end repitition check if
  }
  
  void render()
  {
    if(dir<4)
    {
      if(dir==0)
      {
        ellipse(0, 0, j, j);
      }
      if(dir==1)
      {
        ellipse(width, 0, -j, j);
      }
      if(dir==2)
      {
        ellipse(width, height, -j, -j);
      }
      if(dir==3)
      {
        ellipse(0, height, j, -j);
      }
    }
    else
    {
      dir=0;
    }
  }
}
