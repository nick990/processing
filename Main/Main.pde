import com.hamoid.*;

PImage bg = null;

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
  }
  println("setup");
  fileName = getDatetime();
 // bg = generateBackgroundImage();
  videoExport = new VideoExport(this, "out/"+fileName+".mp4");
  videoExport.setFrameRate(Globals.FRAME_RATE);  
  videoExport.startMovie();

  float radius = width/2;
  float x=width/2;
  float y=height/2;
  float a=0.8;
  float b=1;
  float m=8;
  float n1=1;
  float n2=3;
  float n3=0;
  float delay=PI;
  //generateGrid();
  sf = new SuperformulaStateful(x,y,a,b,m,n1,n2,n3,radius,delay,bg);
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
      superformulas.add(new Superformula(x,y,a,b,m,n1,n2,n3,radius*0.9,delay,bg));
     delay+=0.1;
      m = random(5,15);      
      //n1 = random(1,8);
      // n2 = random(1,4);
    }
  }   
}

float TIME=0;
void draw(){
   background(Globals.BG);
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
    saveGlobals("out/"+fileName
+".txt");
    exit();
  }
  if(key == 's'){
    save("out/"+getDatetime()+".jpg");
  }
}
