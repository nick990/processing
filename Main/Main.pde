import com.hamoid.*;

import com.hamoid.*;

PImage bg;
VideoExport videoExport;
String filename;


PImage generateBackgroundImage(){
  PImage img = createImage(width,height,RGB);
  img.loadPixels();
  for(int x=0;x<img.width;x++){
    for(int y=0;y<img.height;y++){
      img.set(x,y,getColorFromPositionInWindow(width-x,height-y));
    }
  }
  img.updatePixels();
  return img;
}

void settings(){
  setSize(Globals.WIDTH,Globals.HEIGHT);
  smooth(Globals.SMOOTH);  
}

float t=0;
float radius=100;

void setup(){
  bg=generateBackgroundImage();
   filename = getDatetime();
  videoExport = new VideoExport(this, "out/"+filename+".mp4");
  videoExport.setFrameRate(Globals.FRAME_RATE);  
  videoExport.startMovie();
}

void draw() {
  background(255);
  // image(bg,0,0, width, height);
  translate(width/2,height/2);
  // beginShape();
  for(float theta=0;theta<=2*PI;theta+=0.01){
    // float a=cos(t)*2+8;
    float a=1+cos(t)*0.3;
    float b=0.8+sin(t)*0.05;
    float m=10;
    // float n1=2+sin(t)*0.3;
    float n1=1;
    float n2=2;
    float n3=-2;
    float rad = r(theta,a,b,m,n1,n2,n3);
    float x = rad * cos(theta)*width/4;
    float y = rad * sin(theta)*height/4;
    strokeWeight(2);
    // stroke(getColorFromPositionInWindow((int)x,(int)y));
    // vertex(x,y);
    int col = getColorFromPositionInWindow((int)(x),(int)(y));
    stroke(col);
    noFill();
    ellipse(x, y, radius, radius);
  }
  pauseVideo(videoExport, 1);
  // endShape();
  t += 0.1;
  if(t>=3.14*8){
      videoExport.endMovie();
    exit();
  }
}

float r(float theta, float a, float b, float m, float n1, float n2, float n3){
  return pow(pow(abs(cos(m * theta / 4.0) / a), n2) + pow(abs(sin(m * theta / 4.0) / b), n3),-1.0/n1);
}

void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
  if(key == 's'){
    save("out/"+getDatetime()+".jpg");
  }
}
