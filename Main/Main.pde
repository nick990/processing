import com.hamoid.*;

import com.hamoid.*;

PImage bg;
VideoExport videoExport;
String filename;
ArrayList<Superformula> superformulas;
SuperformulaStateful sf;

PImage generateBackgroundImage(){
  PImage img = createImage(width,height,RGB);
  img.loadPixels();
  for(int x=0;x<img.width;x++){
    for(int y=0;y<img.height;y++){
      img.set(x,y,getColorFromPositionInWindow(width-x,height-y));
    }
  }
  img.updatePixels();
  return img;
}

void settings(){
  setSize(Globals.WIDTH,Globals.HEIGHT);
  smooth(Globals.SMOOTH);  
}

void setup(){
  bg = generateBackgroundImage();
  filename = getDatetime();
  videoExport = new VideoExport(this, "out/"+filename+".mp4");
  videoExport.setFrameRate(Globals.FRAME_RATE);  
  videoExport.startMovie();

  float radius = width/2;
  float x=width/2;
  float y=height/2;
  float a=5;
  float b=1;
  float m=6;
  float n1=1;
  float n2=5;
  float n3=-10;
  float delay=PI;
  generateGrid();
  sf = new SuperformulaStateful(x,y,a,b,m,n1,n2,n3,radius*0.9,delay);
}

void generateGrid(){
 superformulas = new ArrayList<Superformula>();
  float a=0;
  float b=1;
  float m=10;
  float n1=5;
  float n2=1;
  float n3=-1;
  float radius = width/(Globals.COLS*2);
  float delay=0;
  for(int row=0;row<Globals.ROWS;row++){
    for(int col=0;col<Globals.COLS;col++){
      float x = radius+col*2*radius;
      float y = radius+row*2*radius;
      superformulas.add(new Superformula(x,y,a,b,m,n1,n2,n3,radius*0.9,delay));
     delay+=0.1;
      m = random(5,15);      
      //n1 = random(1,8);
      // n2 = random(1,4);
    }
  }   
}

float TIME=0;
void draw(){
  background(255);
  // for(Superformula s:superformulas){
  //   s.display(TIME);
  // }
  sf.display(TIME);
  pauseVideo(videoExport,1);
  TIME+=0.1;
}

void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
  if(key == 's'){
    save("out/"+getDatetime()+".jpg");
  }
}
