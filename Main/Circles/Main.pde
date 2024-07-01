float PADDING;
float OFFSET;
float CIRCLES_NUMBER;
void setup(){
    size(4000,4000);
    CIRCLES_NUMBER = 7;
    OFFSET = width/2/(CIRCLES_NUMBER+1);
    PADDING = OFFSET;
}

void draw() {

    color backgroundColor = color(255,255,255);
    background(backgroundColor);
    stroke(backgroundColor);
    strokeWeight(OFFSET/10);
    float xCenter = width/2;
    float yCenter = height/2;
    
    
    for(int i=0; i<CIRCLES_NUMBER; i++){
        float r= width/2 - PADDING - OFFSET*i;
        color c = color(34,76,56);
        float alpha = random(0,TWO_PI);
        if(i==CIRCLES_NUMBER-1){
          c = backgroundColor;
          alpha = TWO_PI;
        }
        float beta = alpha + PI;   
        Circle circle1 = new Circle(xCenter, yCenter, r, c, alpha, beta);
        float gamma = beta;
        float delta = TWO_PI + alpha;
        c = color (100,100,44);
        Circle circle2 = new Circle(xCenter, yCenter, r, c,gamma,delta);
        circle1.draw();
        circle2.draw();
    }

    
    String fileName = "out_" + millis() + ".png";
  
  save(fileName);
  
  exit();
}
