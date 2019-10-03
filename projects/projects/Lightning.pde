float startX;
float endX;
float startY;
float endY;
float type = 1;
float rAngle = 0;

void setup()
{
  size(500, 500);
  frameRate(4);
  background(10);
  startX = 0;
  endX = 0;
  startY = (height/2);
  endY = (height/2);
  stroke(random(0, 255), random(0, 255), random(0, 255));
}

void draw()
{
  if (type == 1) {
    fill(10, 10, 10, 25);
    rect(-1, -1, width + 1, width + 1);
    stroke(random(0, 250), random(0, 255), random(0, 250));
    while (endX<width) {
      endX+=random(height/30);
      endY+=random(height/15)-(height/30);
      if(endY > ((height/2)+(height/3))){
        endY -= 2;
      } else if(endY < (height/6)){
        endY += 2;
      } else if(endY < (height/2)){
        endY += 1;
      } else if(endY > ((height/2)+(height/6))){
        endY -= 1;
      }
      line(startX, startY, endX, endY);
      startX=endX;
      startY=endY;
      if(startY > height){
        endY-=20;
      }else if(startY < 0){
        endY+=20;
      }
    }
    startX = 0;
    endX = 0;
  } else if (type == 3) {
    fill(10, 10, 10, 25);
    rect(-1, -1, width + 1, width + 1);
    ellipse(width/2.0, height/2.0, width*1.0, width*1.0);
    stroke(random(0, 250), random(0, 255), random(0, 250));
    while (endX<sqrt((150*150)-((endY-150)*(endY-150)))) {
      endX+=random(height/30);
      endY+=random(height/15)-(height/30);
      line(startX, startY, endX, endY);
      startX=endX;
      startY=endY;
      if(startY > 3*height/4){
        endY-=90;
      }else if(startY < height/4){
        endY+=90;
      }
    }
    startX = 0;
    endX = 0;
  } else {
    background(0);
    startLight(startX, startY, endX, endY);
  }
}

void mousePressed()
{
  if (type == 1) {
    background(10);
    startX = 0;
    endX = 0;
    startY = (height/2);
    endY = (height/2);
    stroke(random(0, 255), random(0, 255), random(0, 255));
  } else {
    stroke(random(0, 255), random(0, 255), random(0, 255));
  }
}

void keyPressed() {
  type *= -1;
  startX = 0;
  endX = 0;
  startY = 149;
  endY = 149;
}

void startLight(float iX, float iY, float fX, float fY) {
  endX = mouseX;
  endY = mouseY;
  float theta = atan(((fY-iY)/(fX-iX)));
  if (fX-iX < 0)
    theta+=PI;
  float strech = sqrt(((fX - iX)*(fX - iX))+((fX - iX)*(fX - iX)));
  light(iX, iY, fX, fY, 8, strech/10, theta, 0);
}

void light(float iX, float iY, float fX, float fY, float count, float dist, float angle, float direction) {
  angle += direction*random(PI/5);
  float newiX = iX+(dist*cos(angle));
  float newiY = iY+(dist*sin(angle));
  line(iX, iY, newiX, newiY);
  angle  = atan(((fY-iY)/(fX-iX)));
  if (fX-iX < 0)
    angle+=PI;

  if (count > 0.1 && (direction == 1 || direction == 0)) {
    light(newiX, newiY, fX, fY, (count/2)-2, dist*0.97, angle, 1);
    light(newiX, newiY, fX, fY, count-1, dist*0.97, angle, -1);
  } else if (count > 0.1 && direction == -1) {
    light(newiX, newiY, fX, fY, count-1, dist*0.97, angle, 1);
    light(newiX, newiY, fX, fY, (count/2)-2, dist*0.97, angle, -1);
  }
}
