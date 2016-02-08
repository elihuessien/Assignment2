class Screenchange
{
  //growth variable
  float j;
  int k;
  int dir;
  
  Screenchange()
  {
    j=0;
    k=1;
    dir=0;
  }
  
  void update()
  {
    if(k==0)
    {
      if(j <= width*3)
      {
        background(0);
        fill(0, 204, 255); 
        render();
        j+=30;
      }
      else
      {
        j=0;
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
