import com.hamoid.*;
import java.util.Random;

PImage bg = null;
Random random = new Random();
VideoExport videoExport;
String fileName;
ArrayList<Superformula> superformulas;
SuperformulaStateful sf;

void generateBackgroundImage(){
  PImage imgBase = loadImage(Globals.BASE_IMAGE);
  PImage[][] bgImagesGrid = MyUtils.getSubimagesGrid(imgBase,Globals.ROWS,Globals.COLS);
  bg = createImage(Globals.WIDTH, Globals.HEIGHT,RGB);
  int cellW = Globals.WIDTH/Globals.COLS;
  int cellH = Globals.HEIGHT/Globals.ROWS;
  for(int r=0;r<Globals.ROWS;r++){
    for(int c=0;c<Globals.COLS;c++){
      int avgColor = MyUtils.getAvgColor(bgImagesGrid[r][c]);
      for(int x=c*cellW;x<c*cellW+cellW;x++){
        for(int y=r*cellH;y<r*cellH+cellH;y++){
          bg.set(x,y,avgColor);
        }
      }
    }
  }
}

void settings(){
  println("settings");
  setSize(Globals.WIDTH,Globals.HEIGHT);
  smooth(Globals.SMOOTH);  
  println("window: "+ Globals.WIDTH+" x "+Globals.HEIGHT);
}

void setup(){
  MyUtils.init(this);
  if(Globals.USE_BASE_IMAGE){
    generateBackgroundImage();
    bg.save("bg.png"); 
  }
  println("setup");
    background(Globals.BG);
  fileName = getDatetime();
  videoExport = new VideoExport(this, "out/"+fileName+".mp4");
  videoExport.setFrameRate(Globals.FRAME_RATE);  
  videoExport.startMovie();
}



int size = (int)(Globals.WIDTH/30);
int strokeSize = (int)(size/2);
int alfa = 100;
// ms effettivi nel video, calcolato dai frame e frame rate
float millis=0;
int frame=0;
// numero di cerchi disegnati in totale
int totalCircles = 0;
// quanti ms dura uno step
int sleep=400;
// quanti cerchi disegnare in uno step
int circles=0;
void draw(){
  if(millis < 500)
    circles=0;
  if(millis >= 500 && millis < 3000)
    circles=1;
  if(millis >= 3000 && millis < 5000)
    circles=2;
  if(millis > 5000 && millis < 10000){
    circles++;
  }
  if(millis >=10000 && millis < 12000){
    circles = max(0,circles-1);
    sleep+=20;
  }
   if(millis >=12000){
    circles = 0;
    sleep = 30;
  }
  int frameToSave=1;
  sleep=max(sleep-10,30);
  for(int i=0;i<circles;i++){
    drawCircle();
    totalCircles++;
  }
  frameToSave =max(1,(int)(sleep/1000.0f*Globals.FRAME_RATE));
  pauseVideo(videoExport, frameToSave);
  frame+=frameToSave;
  millis=(frame/(float)(Globals.FRAME_RATE/1000.0f));
  if(millis>14000){
    saveFrame();
    saveAndExit();
  }
  println("millis:"+millis);
  println("frame:"+frame);
  println("frameToSave:"+frameToSave);
  println("sleep:"+sleep);
  //delay(sleep);
}

void drawRect(){
  int x = random.nextInt(Globals.WIDTH);
  int y = random.nextInt(Globals.HEIGHT);
  color fillColor = bg.get(x,y);
  fill(fillColor);
  stroke(copyColorWithAlpha(fillColor,alfa));
  strokeWeight(strokeSize);
  rect(x,y,size,size);
}

void drawCircle(){
  int x = random.nextInt(Globals.WIDTH);
  int y = random.nextInt(Globals.HEIGHT);
  color fillColor = bg.get(x,y);
  fill(fillColor);
  stroke(copyColorWithAlpha(fillColor,alfa));
  strokeWeight(strokeSize);
  ellipse(x,y,size,size);
}

void saveFrame(){
  save("out/"+getDatetime()+".jpg");
}

void keyPressed() {
  if (key == 'q') {
  saveAndExit();
  }
  if(key == 's'){
   saveFrame();
  }
}

void saveAndExit(){
   videoExport.endMovie();
    saveGlobals("out/"+fileName
+".txt");
    exit();
    }
