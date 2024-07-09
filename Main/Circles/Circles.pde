import com.hamoid.*;

import java.util.ArrayList;

float PADDING;
float OFFSET;
int CIRCLES_NUMBER = 7;
float STROKE_WEIGHT;
color COLOR_BG;
float ALPHA_MIN = 230;
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
    size(500,500);
    PADDING = width/(CIRCLES_NUMBER*2.0)/1.5;
    OFFSET = ((width/2.0)-PADDING)/(CIRCLES_NUMBER);
    STROKE_WEIGHT = OFFSET/4.0;
    COLOR_BG = color(#2b2d42);
    PALETTE = new ArrayList<Integer>();
    PALETTE.add(color(#2b2d42));
    // PALETTE.add(color(#FFFFFF));
    PALETTE.add(color(#faf0ca));
    PALETTE.add(color(#f4d35e));
    PALETTE.add(color(#ee964b));
    PALETTE.add(color(#f95738));
   init();
 
}

void init(){
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
      // Aggiungo un delta casuale al raggio
      float deltaRadius = 0.0;
      // Il primo cerchio non ha un delta
      if(i!=0){
        deltaRadius = -OFFSET*random(0.0,0.5);
      }
      radius += deltaRadius;
      // int slices = CIRCLES_NUMBER-i-1;
      int slices = int(random(2,5));
      if(i==CIRCLES_NUMBER-2){
        slices = 1;
      }
      circle = new Circle(xCenter, yCenter, radius, clockwise, slices, speed);
    }
    if(i%2==0){
      circle.rotate(PI);
    }
    circles.add(circle);
  }
}

int frame=0;
void draw() {

      background(COLOR_BG);
      stroke(COLOR_BG);
      strokeWeight(STROKE_WEIGHT);
      init();
      for(int i=0; i<CIRCLES_NUMBER; i++){
        AbstractCircle c = circles.get(i);
        c.draw();     
      }
      // String fileName = "out" + millis() + ".png";
      // save(fileName);
      // exit();
      String fileName = "frames/" + (nf(++frame,6)) + ".png";
      System.out.println("Saving: " + fileName);
      save(fileName);
      if(frame==5){
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
