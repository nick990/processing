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
ArrayList<Circle> circles;

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

    circles = new ArrayList<Circle>();
    float xCenter = width/2;
    float yCenter = height/2;
    //Creo i cerchi
    for(int i=0; i<CIRCLES_NUMBER; i++){
      float r= width/2 - PADDING - OFFSET*i;
      Circle bgCircle=new Circle(xCenter,yCenter,r,COLOR_BG,0,TWO_PI);
      circles.add(bgCircle);
      color c = getRandomColor();
      c = changeAlpha(c,random(ALPHA_MIN,ALPHA_MAX));
      float alpha = random(0,TWO_PI);
      float beta = alpha + random(PI/3.0,PI*4.0/3.0);      
      float speed = random(0.03,0.1);
      if(i%2==0){
        speed = -speed;
      }
      if(i==CIRCLES_NUMBER-1){
        c = COLOR_BG;
        alpha = 0.0;
        beta = PI;
        speed = 0.0;
      }
          
      Circle circle1 = new Circle(xCenter, yCenter, r, c, alpha, beta,speed);
      circles.add(circle1);
      float gamma = beta;
      float delta = TWO_PI + alpha;
      c = getRandomColor();
      c = changeAlpha(c,random(ALPHA_MIN,ALPHA_MAX));
      Circle circle2 = new Circle(xCenter, yCenter, r, c,gamma,delta,speed);
      circles.add(circle2);
    }  
}

int frame=0;

void draw() {

      background(COLOR_BG);
      stroke(COLOR_BG);
      strokeWeight(STROKE_WEIGHT);      
      
      for(Circle c: circles){
        c.draw();
        c.rotate();
      }

      String fileName = "frames/" + (nf(++frame,6)) + ".png";
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
