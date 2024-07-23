int WINDOW_WIDTH=800;
int WINDOW_HEIGHT=600;
int CANVAS_WIDTH = 1000;
int CANVAS_HEIGHT = 1000;
int xTrans=0;
int yTrans=0;
int transDelta=10;

void settings(){
  setSize(WINDOW_WIDTH,WINDOW_HEIGHT);
}

void setup(){
  surface.setResizable(true);
}

void draw(){
  println("("+xTrans+","+yTrans+")");
  background(0);
  drawCanvas();
  translate(xTrans,yTrans);
  
  fill(color(255,0,0));
  rect(300,300,100,100);  
}

void keyPressed() {
  if (keyCode == RIGHT) {
    xTrans = max(xTrans-transDelta,-CANVAS_WIDTH+width/2);
  }
  if(keyCode == LEFT){
    xTrans = min(xTrans+transDelta,width/2);
  }
  if(keyCode == UP){
    yTrans = min(yTrans+transDelta,height/2);
  }
  if(keyCode == DOWN){
    yTrans = max(yTrans-transDelta,-CANVAS_HEIGHT+height/2);
  }
}

void drawCanvas(){
  fill(color(255));
  rect(xTrans,yTrans,CANVAS_WIDTH,CANVAS_HEIGHT);
}
