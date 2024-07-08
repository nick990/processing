import com.hamoid.*;

import java.util.ArrayList;

float PADDING;
float OFFSET;
float CIRCLES_NUMBER = 7;
float STROKE_WEIGHT;
color COLOR_BG;
float ALPHA_MIN = 255;
float ALPHA_MAX = 255;
ArrayList<Integer> PALETTE;
ArrayList<Integer> CHOOSEN_INDEXES;
ArrayList<AbstractCircle> circles;
float VEL_MIN_START = 0.005;
float VEL_MAX_START = 0.15;
float VEL_MIN = 0.001;
float VEL_MAX = 0.3;
float VEL_DELTA = 0.001;

void setup(){
    size(400,400);
    PADDING = width/(CIRCLES_NUMBER*2.0)/1.5;
    OFFSET = ((width/2.0)-PADDING)/(CIRCLES_NUMBER);
    STROKE_WEIGHT = OFFSET/4.0;
    COLOR_BG = color(#2b2d42);
    PALETTE = new ArrayList<Integer>();
    PALETTE.add(color(#2b2d42));
    PALETTE.add(color(#faf0ca));
    PALETTE.add(color(#f4d35e));
    PALETTE.add(color(#ee964b));
    PALETTE.add(color(#f95738));
    CHOOSEN_INDEXES = new ArrayList<Integer>();

    circles = new ArrayList<AbstractCircle>();
    float xCenter = width/2;
    float yCenter = height/2;
    for(int i=0; i<CIRCLES_NUMBER; i++){
      float radius = OFFSET*(CIRCLES_NUMBER-i);
      boolean clockwise = i%2!=0;
      AbstractCircle circle;
      if(i==CIRCLES_NUMBER-1){
        circle = new CircleCenter(xCenter, yCenter, radius);
      }else{
        float speed = random(VEL_MIN_START,VEL_MAX_START);
        circle = new Circle(xCenter, yCenter, radius, clockwise, 4, speed);
      }
      circles.add(circle);
    }
 
}

int frame=0;

void draw() {

      background(COLOR_BG);
      stroke(COLOR_BG);
      strokeWeight(STROKE_WEIGHT);      
      for(int i=0; i<CIRCLES_NUMBER; i++){
        AbstractCircle c = circles.get(i);
        c.draw();
        c.rotate();
        if(i%2==0){
          c.speedUp(VEL_DELTA);
        }else{
          c.speedDown(VEL_DELTA);
        }      
      }


      String fileName = "frames/" + (nf(++frame,6)) + ".png";
      System.out.println("Saving: " + fileName);
      save(fileName);
      if(frame==300){
        exit();
      } 
  
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
