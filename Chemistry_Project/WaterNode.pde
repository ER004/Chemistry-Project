class WaterNode
{
  float mass = 1;
  float size = 20;
  color hue = #49DCE8;
  float xMin;
  float xMax;
  float yMin;
  float yMax;
  float speed;
  PVector location;
  PVector velocity;
  
  WaterNode(float canX, float canY)
  {
    velocity = PVector.random2D();
    yMin = height/2 - canY/2 + size/2;
    yMax = height/2 + canY/2 - size/2;
    xMin = width/2 - canX/2 + size/2;
    xMax = width/2 + canX/2 - size/2;
    location = new PVector(random(xMin + 2, xMax - 2),random(yMin + 2, yMax - 2));
  }
  
  void update(float slider, float tempMax)
  {
    speed = map(slider, 1, tempMax, 1, 5);
    velocity.mult(speed);
    
    //check for horizontal wall collisions
    if(location.y < yMin || location.y > yMax)
    {
      velocity.y = velocity.y * -1;
    }
    //check for vertical wall collisions
    if(location.x < xMin || location.x > xMax)
    {
      velocity.x = velocity.x * -1;
    }
    
    //updates position
    location.add(velocity);
    
    //draws particle
    fill(hue);
    ellipse(location.x,location.y,size,size);
    noStroke();
    
    velocity.div(speed);
  }
  
  float map(float x, float in_min, float in_max, float out_min, float out_max)
  {
    return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
  }
}
