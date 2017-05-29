import processing.serial.*;
long now,pre;
Serial port;
 
int sensor1_val;
int[] sensor1_vals;

void setup() 
{
  size(640, 480);
  port = new Serial(this, "COM4", 9600);     
  sensor1_vals = new int[width];
  smooth();
}
void draw()
{
  //find first bit
  while(port.available() > 1)
  {
    if (port.read() == 's')
      break;
  }
 
  while (port.available() >= 13) { 
    if (port.read() == 'a') { 
      sensor1_val=((port.read())+(port.read()<<8)); 
    }
    port.read();
  }
  
  
  now=millis();
  if((now-pre)>1){  
    pre=now;
    background(0);
    fill(255, 0, 0);
    text(sensor1_val,100,50);  

    //sensor1
    for (int i=0; i<width-1; i++) 
      sensor1_vals[i] = sensor1_vals[i+1];
    sensor1_vals[width-1] = sensor1_val;
    stroke(255, 0, 0);
    for (int x=1; x<width; x++) {
      line(width-x,   height-1-getY(sensor1_vals[x-1]), width-1-x, height-1-getY(sensor1_vals[x]));
    }
  }
}
 
int getY(int val) {
  return (int)(val / 1023.0f * height) - 1;
}