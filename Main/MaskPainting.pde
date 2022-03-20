import com.hamoid.*;

import java.util.Random;
import java.text.DecimalFormat;


void randomize(){
  TileProviderSingleton.getInstance().generateRandomIndexes(-1);
  Globals.STARTING_NEGATIVE=random.nextBoolean();
}

PImage img;
PImage mask;
Random random = new Random();

void settings(){
    img = loadImage("images/mask/prova.png");
    mask = loadImage("images/mask/mask.png");
    Globals.WIDTH =  img.width;
    Globals.HEIGHT = img.height;
    setSize(Globals.WIDTH, Globals.HEIGHT);
    smooth(Globals.SMOOTH);
    println("window: "+ Globals.WIDTH+" x "+Globals.HEIGHT);
}




void setup() {
  MyUtils.init(this);
  Globals.init(this);
}


void draw() {
  ClustersManager clustersManager = new ClustersManager();
  background(Globals.BG);
  for(int x=0;x<Globals.WIDTH;x++){
    println(x+"/"+Globals.WIDTH);
    for(int y=0;y<Globals.HEIGHT;y++){
      color maskColor = mask.get(x,y);
      if (maskColor != Globals.GREEN_SCREEN){
        //Sono su un pixel da tenere
        Pixel pixel = new Pixel(x,y);
        if(!clustersManager.isPixelAlreadyInCluster(pixel)){
          Cluster cluster = createCluster(mask,pixel);
          clustersManager.add(cluster);
          image(clustersManager.img,0,0);
        }        
      }
    }
  }
  clustersManager.draw(img);

  String fileName =getFileName();
  save("out/"+fileName+".jpg");
  saveGlobals("out/"+fileName+".txt");
  println("-------------");
  exit();
}
