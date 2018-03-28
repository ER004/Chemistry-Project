class Can
{
  float x;
  float y;
  float margin;
  float waterHeight = 75;
  color c;
  boolean isCrushed = false;
  boolean waterOn;
  
  Can(float x, float y, float margin, color c)
  {
    this.waterOn = false;
    this.x = x;
    this.y = y;
    this.margin = margin;
    this.c = c;
  }
  //add int waterNum as argument
  void drawCan()
  {
    noStroke();
    
    rectMode(CENTER);
    fill(c);
    rect(width/2, height/2, x + margin , y + margin, 10);
    fill(0);
    rect(width/2, height/2, x , y, 10);
  }
  
  //add int water as argument
  void drawWater(int water, int waterMax)
  {
    waterHeight = map(water, 0, waterMax, 0, y/2);
    noStroke();
    fill(#49DCE8);
    rect(width/2, height/2 + y/2 - waterHeight/2, x, waterHeight);
  }
  
  void crush()
  {
    y = y/3.5;
    x = x/2;
  }
  
  void unCrush()
  {
    y = y*3.5;
    x = x*2;
  }
  
  float map(float x, float in_min, float in_max, float out_min, float out_max)
  {
    return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
  }
}
