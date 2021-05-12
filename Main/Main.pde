import com.hamoid.*;

int w;              // Width of entire wave

float theta = 0.0;  // Start angle at 0
float amplitude = 75.0;  // Height of wave
float period = 500.0;  // How many pixels before the wave repeats
float dx;  // Value for incrementing X, a function of period and xspacing
float[] yvalues;  // Using an array to store height values for the wave
float diameter;
int xspacing;  // How far apart should each horizontal location be spaced
PImage bg;
VideoExport videoExport;
String filename;


PImage generateBackgroundImage(){
  PImage img = createImage(width,height,RGB);
  img.loadPixels();
  // for (int i = 0; i < img.pixels.length; i++) {
  //   img.pixels[i] = color(0, 90, 102); 
  // }
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

void setup() {
  diameter = Globals.DIAMETER;
  xspacing = (int)(diameter/4); 
  w = width+xspacing;
  amplitude = height/6;
  period = width/2;
  dx = (TWO_PI / period) * xspacing;
  yvalues = new float[w/xspacing];
  bg = generateBackgroundImage();
  filename = getDatetime();
  videoExport = new VideoExport(this, "out/"+filename+".mp4");
  videoExport.setFrameRate(Globals.FRAME_RATE);  
  videoExport.startMovie();
  noStroke();
  fill(255);
  strokeWeight(Globals.STROKE_WEIGHT);
  saveGlobals("out/"+filename+".txt");
}

void draw() {
    image(bg,0,0);
    calcWave();
    renderWave();
    videoExport.saveFrame();
    if(theta>=3.14*2){
        videoExport.endMovie();
        exit();
    }
}

void calcWave() {
  // Increment theta (try different values for 'angular velocity' here
  theta += 0.01;
  // For every x value, calculate a y value with sine function
  float x = theta;
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = sin(x)*amplitude;
    x+=dx;
  }

}

void renderWave() {
  // A simple way to draw the wave with an ellipse at each location
  for (int x = 0; x < yvalues.length; x++) {
    float pointX=x*xspacing;
    float pointY=height/2+yvalues[x];
    stroke(getColorFromPositionInWindow((int)pointX,(int)pointY));
    float d=diameter;
    float minD=diameter*0.8;
    if(x%2==0)
        d = minD+(diameter-minD)/2+cos(theta)*(diameter-minD)/2;
    else
        d = minD+(diameter-minD)/2+sin(theta)*(diameter-minD)/2;

    ellipse(pointX, pointY, d, d);
  }
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