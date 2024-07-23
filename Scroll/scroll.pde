int WINDOW_WIDTH=2000;
int WINDOW_HEIGHT=1500;
int CANVAS_WIDTH = 10000;
int CANVAS_HEIGHT = 10000;
int xTrans=0;
int yTrans=0;
int transDelta=10;

void settings(){
  setSize(WINDOW_WIDTH,WINDOW_HEIGHT);
}

void draw(){
  println("("+xTrans+","+yTrans+")");
  background(0);
  drawCanvas();
  translate(xTrans,yTrans);
  
  fill(color(255,0,0));
  rect(WINDOW_WIDTH/2-50,WINDOW_HEIGHT/2-50,100,100);  
}

void keyPressed() {
  if (keyCode == RIGHT) {
    xTrans = max(xTrans-transDelta,-CANVAS_WIDTH+WINDOW_WIDTH/2);
  }
  if(keyCode == LEFT){
    xTrans = min(xTrans+transDelta,WINDOW_WIDTH/2);
  }
  if(keyCode == UP){
    yTrans = min(yTrans+transDelta,WINDOW_HEIGHT/2);
  }
  if(keyCode == DOWN){
    yTrans = max(yTrans-transDelta,-CANVAS_HEIGHT+WINDOW_HEIGHT/2);
  }
  println(xTrans);
}

void drawCanvas(){
  fill(color(255));
  rect(xTrans,yTrans,CANVAS_WIDTH,CANVAS_HEIGHT);
}
