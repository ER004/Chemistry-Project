import controlP5.*;

float temperature;
int airMax = 1000;
int waterMax = 1000;
int air;
int water;
float threshold = 373.2;
float tempMax = 700;
ControlP5 cp5;
Slider tempSlider;
Slider airSlider;
Slider waterSlider;
AirNode[] airNodes = new AirNode[5000];
WaterNode[] waterNodes = new WaterNode[5000];
Can can = new Can(400, 600, 20, #F03F3F);

void setup()
{
  size(600,800);
  
  cp5 = new ControlP5(this);
  tempSlider = cp5.addSlider("Temperature (Kelvin)");
  tempSlider
  .setPosition(width/2 - can.x/2, 65)
  .setSize(int(can.x) - 100, 20)
  .setRange(1,tempMax)
  .setValue(tempMax)
  ;
  
  airSlider = cp5.addSlider("Air Particles");
  airSlider
  .setPosition(width/2 - can.x/2, height - 80)
  .setSize(int(can.x) - 100, 20)
  .setRange(0,airMax)
  .setValue(100)
  ;
  
  waterSlider = cp5.addSlider("Water Particles");
  waterSlider
  .setPosition(width/2 - can.x/2, height - 50)
  .setSize(int(can.x) - 100, 20)
  .setRange(0,waterMax)
  .setValue(100)
  ;
  for(int i = 0; i<airMax; i++)
  {
    airNodes[i] = new AirNode(can.x,can.y);
  }
  for(int i = 0; i<waterMax; i++)
  {
    waterNodes[i] = new WaterNode(can.x,can.y);
  }
}

void draw()
{
  temperature = tempSlider.getValue();
  air = int(airSlider.getValue());
  water = int(waterSlider.getValue());
  background(0);
  can.drawCan();
  
  for(int i = 0; i<air; i++)
  {
    airNodes[i].update(temperature, tempMax, can.waterHeight, can.x, can.y, can.waterOn);
  }
  
  if(temperature >= threshold)
  {
    if(can.isCrushed == true)
    {
      can.unCrush();
      can.isCrushed = false;
    }
    
    can.waterOn = false;
    for(int i = 0; i<water; i++)
    {
      waterNodes[i].update(temperature, tempMax);
    }
  }
  
  else
  {
    can.waterOn = true;
    can.drawWater(water, waterMax);
    if(can.isCrushed == false)
    {
      can.crush();
      can.isCrushed = true;
    }
  }
}
