// Initial dimensions of the window
int WINDOW_WIDTH=800;
int WINDOW_HEIGHT=600;
// Dimensions of the canvas
int CANVAS_WIDTH = 5000;
int CANVAS_HEIGHT = 1000;

int xTrans=0;
int yTrans=0;
int transDelta=10;

//True if a mouse button was pressed while no other button was.
boolean firstMousePress = false;

HScrollbar hScrollbar;

void settings(){
  setSize(WINDOW_WIDTH,WINDOW_HEIGHT);
}

void setup(){
  surface.setResizable(true);
  hScrollbar = new HScrollbar(16, 8);
}

void draw(){
  background(0);
  drawCanvas();
  xTrans = -hScrollbar.getXTranslate();
  translate(xTrans,yTrans);
  
  int rectWidth = 100;
  fill(color(255,0,0));
  rect(0,0,rectWidth,rectWidth);
  fill(color(0,255,0));
  rect(CANVAS_WIDTH-rectWidth,CANVAS_HEIGHT-rectWidth,rectWidth,rectWidth);
  fill(color(0,0,255));
  rect(CANVAS_WIDTH-rectWidth,0,rectWidth,rectWidth);
  fill(color(255,255,0));
  rect(0,CANVAS_HEIGHT-rectWidth,rectWidth,rectWidth);
  
  //Reset the translation
  translate(-xTrans,-yTrans);
  hScrollbar.update();
  hScrollbar.display();
  //After it has been used in the sketch, set it back to false
  if (firstMousePress) {
    firstMousePress = false;
  }
}

void mousePressed() {
  if (!firstMousePress) {
    firstMousePress = true;
  }
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
