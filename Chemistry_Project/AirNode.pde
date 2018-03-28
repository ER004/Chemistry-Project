class AirNode
{
  float mass = 1.61111;
  float size = 10;
  color hue = #FFFFFF;
  float xMin;
  float xMax;
  float yMin;
  float yMax;
  float speed;
  PVector location;
  PVector velocity;
  
  AirNode(float canX, float canY)
  {
    velocity = PVector.random2D();
    yMin = height/2 - canY/2 + size/2;
    yMax = height/2 + canY/2 - size/2;
    xMin = width/2 - canX/2 + size/2;
    xMax = width/2 + canX/2 - size/2;
    location = new PVector(random(xMin + 2, xMax - 2),random(yMin + 2, yMax - 2));
  }
  
  void update(float slider, float tempMax, float waterHeight, float canX, float canY, boolean waterOn)
  {
    yMin = height/2 - canY/2 + size/2;
    yMax = height/2 + canY/2 - size/2;
    xMin = width/2 - canX/2 + size/2;
    xMax = width/2 + canX/2 - size/2;
    
    if(waterOn)
    {
      yMax -= waterHeight;
    }
    
    speed = map(slider, 1, tempMax, 1, 10);
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
    
    //checks if particle is inside the water when it appears and redirects it to a random location in the can
    if(waterOn && location.y > yMax + 3)
    {
      location.y = random(yMin,yMax);
    }
    
    //checks if a particle is outside the can after it crushes
    if(location.x > xMax + 3 || location.x < xMin - 3 || location.y > yMax + 3 || location.y < yMin - 3)
    {
      location.y = random(yMin,yMax);
      location.x = random(xMin,xMax);
    }
    
    if(waterOn)
    {
      yMax += waterHeight;
    }
  }
  
  float map(float x, float in_min, float in_max, float out_min, float out_max)
  {
    return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
  }
}
