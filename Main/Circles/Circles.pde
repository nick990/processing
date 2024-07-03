import com.hamoid.*;

import java.util.ArrayList;

float PADDING;
float OFFSET;
float CIRCLES_NUMBER;
float STROKE_WEIGHT;
color COLOR_BG;
float ALPHA_MIN = 200;
float ALPHA_MAX = 255;
ArrayList<Integer> PALETTE;
ArrayList<Integer> CHOOSEN_INDEXES;
ArrayList<AbstractCircle> circles;

void setup(){
    size(500,500);
    CIRCLES_NUMBER = 5;
    OFFSET = width/2.0/(CIRCLES_NUMBER+1);
    PADDING = OFFSET;
    STROKE_WEIGHT = OFFSET/4.0;
    COLOR_BG = color(#fdfffc);
    PALETTE = new ArrayList<Integer>();
    PALETTE.add(color(#011627));
    PALETTE.add(color(#2ec4b6));
    PALETTE.add(color(#e71d36));
    PALETTE.add(color(#ff9f1c));
    CHOOSEN_INDEXES = new ArrayList<Integer>();

    circles = new ArrayList<AbstractCircle>();
    float xCenter = width/2;
    float yCenter = height/2;
    for(int i=0; i<CIRCLES_NUMBER; i++){
      float radius = width/2 - PADDING - OFFSET*i;
      boolean clockwise = i%2!=0;
      AbstractCircle circle;
      if(i==CIRCLES_NUMBER-1){
        circle = new CircleCenter(xCenter, yCenter, radius);
      }else{
        circle = new Circle(xCenter, yCenter, radius, clockwise);
      }
      circles.add(circle);
    }
 
}

int frame=0;

void draw() {

      background(COLOR_BG);
      stroke(COLOR_BG);
      strokeWeight(STROKE_WEIGHT);      
      
      for(AbstractCircle c: circles){
        c.draw();
        c.rotate();
      }

      // String fileName = "frames/" + (nf(++frame,6)) + ".png";
      // save(fileName);
      // if(frame==300){
      //   exit();
      // } 
  
}


// Return colorc c with alpha channel = newAlpha
color changeAlpha(color c, float newAlpha) {
  float r = red(c);
  float g = green(c);
  float b = blue(c);
  return color(r, g, b, newAlpha);
}

color getRandomColor() {
  if(CHOOSEN_INDEXES.size()==PALETTE.size()){
    CHOOSEN_INDEXES.clear();
  }
  int index = int(random(PALETTE.size()));
  while(CHOOSEN_INDEXES.contains(index)){
    index = int(random(PALETTE.size()));
  }
  CHOOSEN_INDEXES.add(index);
  return PALETTE.get(index);
}
