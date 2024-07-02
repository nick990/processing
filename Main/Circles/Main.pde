import java.util.ArrayList;

float PADDING;
float OFFSET;
float CIRCLES_NUMBER;
color COLOR_BG;
float ALPHA_MIN = 200;
float ALPHA_MAX = 255;
ArrayList<Integer> PALETTE;
void setup(){
    size(4000,4000);
    CIRCLES_NUMBER = 6;
    OFFSET = width/2/(CIRCLES_NUMBER+1);
    PADDING = OFFSET;
    COLOR_BG = color(#fdf0d5);
    PALETTE = new ArrayList<Integer>();
    PALETTE.add(color(#264653));
    PALETTE.add(color(#2a9d8f));
    PALETTE.add(color(#e9c46a));
    PALETTE.add(color(#f4a261));
    PALETTE.add(color(#e76f51));
}

void draw() {
    for(int step=0;step<10;step++){
      background(COLOR_BG);
      stroke(COLOR_BG);
      strokeWeight(OFFSET/5);
      float xCenter = width/2;
      float yCenter = height/2;    
      
      for(int i=0; i<CIRCLES_NUMBER; i++){
          float r= width/2 - PADDING - OFFSET*i;
          Circle bgCircle=new Circle(xCenter,yCenter,r,COLOR_BG,0,TWO_PI);
          //stroke(COLOR_BG);
          bgCircle.draw();
          
          color c = getRandomColor();
          c = changeAlpha(c,random(ALPHA_MIN,ALPHA_MAX));
          float alpha = random(0,TWO_PI);
         
          //Se è l'ultimo metà bassa ha lo stesso colore del bg
          if(i==CIRCLES_NUMBER-1){
            c = COLOR_BG;
            alpha = TWO_PI;
          }
          float beta = alpha + PI;   
          Circle circle1 = new Circle(xCenter, yCenter, r, c, alpha, beta);
          float gamma = beta;
          float delta = TWO_PI + alpha;
          c = getRandomColor();
          c = changeAlpha(c,random(ALPHA_MIN,ALPHA_MAX));
          Circle circle2 = new Circle(xCenter, yCenter, r, c,gamma,delta);
          //stroke(getRandomColor());
          circle1.draw();
          //stroke(getRandomColor());
          circle2.draw();
      }    
      String fileName = "out_" + millis() + ".png";
      save(fileName);
    }
  
  exit();
}

// Return colorc c with alpha channel = newAlpha
color changeAlpha(color c, float newAlpha) {
  float r = red(c);
  float g = green(c);
  float b = blue(c);
  return color(r, g, b, newAlpha);
}

color getRandomColor() {
  return PALETTE.get(int(random(PALETTE.size())));
}
