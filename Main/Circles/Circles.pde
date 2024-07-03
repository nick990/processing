import com.hamoid.*;

import java.util.ArrayList;

float PADDING;
float OFFSET;
float CIRCLES_NUMBER;
color COLOR_BG;
float ALPHA_MIN = 255;
float ALPHA_MAX = 255;
ArrayList<Integer> PALETTE;
ArrayList<Integer> CHOOSEN_INDEXES;
ArrayList<Circle> circles;

void setup(){
    size(500,500);
    CIRCLES_NUMBER = 6;
    OFFSET = width/2/(CIRCLES_NUMBER+1);
    PADDING = OFFSET;
    COLOR_BG = color(#ffffff);
    PALETTE = new ArrayList<Integer>();
    PALETTE.add(color(#219ebc));
    PALETTE.add(color(#023047));
    PALETTE.add(color(#ffb703));
    PALETTE.add(color(#fb8500));
    CHOOSEN_INDEXES = new ArrayList<Integer>();

    circles = new ArrayList<Circle>();
    float xCenter = width/2;
    float yCenter = height/2;
    //Creo i cerchi
    for(int i=0; i<CIRCLES_NUMBER; i++){
      float r= width/2 - PADDING - OFFSET*i;
      Circle bgCircle=new Circle(xCenter,yCenter,r,COLOR_BG,0,TWO_PI);
      // stroke(COLOR_BG);
      // bgCircle.draw();
      
      color c = getRandomColor();
      c = changeAlpha(c,random(ALPHA_MIN,ALPHA_MAX));
      float alpha = random(0,TWO_PI);
      float beta = alpha + random(PI/3.0,PI*4.0/3.0);      
      float speed = random(0.01,0.05);
      //Se è l'ultimo metà bassa ha lo stesso colore del bg
      if(i==CIRCLES_NUMBER-1){
        c = COLOR_BG;
        alpha = 0.0;
        beta = PI;
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
      strokeWeight(OFFSET/5);      
      
      for(Circle c: circles){
        c.draw();
        c.rotate();
      }

      String fileName = "out/" + (++frame) + ".png";
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
