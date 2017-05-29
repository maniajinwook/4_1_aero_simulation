import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;

Serial myPort;

int triSize = 20;
boolean shoot = false;
int posX, posY;
int ballSize = 30;
int laserLimit = 80;
String data;
int index1, index2;
int sticX, sticY;
int stic; 

void setup() {
  size(200, 400);
  myPort = new Serial(this, "COM4", 9600);
  myPort.bufferUntil('.');
  initGame();
}

void initGame() {
  posY = 0;
  posX = int(random(width));
}

void draw() {
  fill(0, 10);
  rect(0, 0, width, height-laserLimit);
  fill(0);
  rect(0, height-laserLimit, width, height);

  ballDropper();
  triLaser();
  if (shoot == true) {
    ballKiller(sticX);
    shoot=false;
  }
  gameEndChk();
}

void triLaser() {
  if (sticY > height-laserLimit) {
    fill(0, 255, 0);
    stroke(0, 255, 0);
    triangle(sticX-triSize, sticY, sticX+triSize, sticY, sticX, sticY-triSize);
    if (stic == 20) {
      shoot = true;
    }
  }
}

void ballDropper() {
  fill(255);
  stroke(255);
  delay(100);
  ellipse(posX, posY++, ballSize, ballSize);
}

void gameEndChk() {
  if (posY == height-laserLimit) {
    fill(255, 0, 0);
    noLoop();
  }
}

void mousePressed() {
  if (sticY > height-laserLimit)
    shoot=true;
}

void ballKiller(int x) {
  boolean hit = false;
  stroke(255, 0, 0);
  fill(255, 0, 0);
  if ((x>=posX-ballSize/2) && (x<=posX+ballSize)) {
    hit = true;
    line(sticX, sticY, sticX, posY);
    ellipse(posX, posY, ballSize+25, ballSize+25);
    initGame();
  }
  if (hit == false) {
    line(sticX, sticY, sticX, 0);
  }
}

void keyPressed() {
  initGame();
  loop();
}

void serialEvent (Serial myPort) {
  data = myPort.readStringUntil('.');
  data = data.substring(0, data.length()-1);

  String[] datas;

  datas = data.split(",");
  println(datas[1]);
  println(datas[2]);
  println(datas[3]);
  
  stic = int(datas[1]);
  sticX = int(datas[2]);
  sticY = int(datas[3]);
  
  println(stic, sticX, sticY);
}