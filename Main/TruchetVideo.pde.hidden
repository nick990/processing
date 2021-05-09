import com.hamoid.*;

import java.util.Random;
import java.text.DecimalFormat;

VideoExport videoExport;

int PADDING = Globals.TILE_SIZE/12;
int mosaic_width;
int mosaic_height;
int window_width;
int window_height;

// Cambia le constanti globali per randomizzare la generazione
void randomize(){
  Globals.COLOR_FACTOR=new Random().nextDouble()*0.8+0.2;
  TileProviderSingleton.getInstance().generateRandomIndexes(-1);
}


//Genera il primo livello
public ArrayList<Tile> generateFirstLevel(){  
  ArrayList<Tile> firstLevel = new ArrayList<Tile>();
  for(int r=0;r<Globals.ROWS;r++){
    for(int c=0;c<Globals.COLS;c++){ 
      int imageIndex=TileProviderSingleton.getInstance().getRandomIndex();
      boolean negative=false;
      firstLevel.add(new Tile(r,c,imageIndex,negative,0,0,0,null));
    }
  }
  return firstLevel;
}

// Genera un nuovo albero
// Al termine ho flattenTree ordinato e pronto per essere disegnato
public ArrayList<Tile> generate(){  
  ArrayList<Tile> firstLevel = new ArrayList<Tile>();
  for(int r=0;r<Globals.ROWS;r++){
    for(int c=0;c<Globals.COLS;c++){ 
      int imageIndex=TileProviderSingleton.getInstance().getRandomIndex();
      boolean negative=false;
      Tile t  = new Tile(r,c,imageIndex,negative,0,0,0,null);
      t.split(Globals.LEVELS-1);
      firstLevel.add(t);
    }
  }

  ArrayList<Tile> flattenTree = getFlattenTree(firstLevel,true);
  return flattenTree;
}


void settings(){
  mosaic_width = (int)((Globals.COLS-1)*(Globals.TILE_SIZE*(1-2.0*Globals.TILE_PADDING_RATIO))+Globals.TILE_SIZE);
  mosaic_height = (int) ((Globals.ROWS-1)*(Globals.TILE_SIZE*(1-2.0*Globals.TILE_PADDING_RATIO))+Globals.TILE_SIZE);
  window_width=mosaic_width+PADDING*2;
  window_height=mosaic_height+PADDING*2;
  println("window: "+window_width+" x "+window_height);
  println("mosaic: "+mosaic_width+" x "+mosaic_height);
  setSize(window_width,window_height);
  smooth(Globals.SMOOTH);  
}
String video_path;
void setup() {
  TileProviderSingleton.init(this);
  MyUtils.init(this);
  Globals.init(this);
  TileProviderSingleton.getInstance().generateRandomIndexes(5);
}


void draw() {
    translate(PADDING,PADDING);    
    for(int i=0;i<50;i++){
      println("----- " + i + " -----");
      randomize();
      background(0);
      ArrayList<Tile> tree = generate();
      video_path = "video/"+MyUtils.getFileName()+".mp4";
      videoExport = new VideoExport(this, video_path);
      videoExport.setFrameRate(Globals.FRAME_RATE);  
      videoExport.startMovie();
      boolean tint=true;
      println(video_path);
      println("Print layer 0");
      ArrayList<Tile> layerTree = extractLevel(tree,0);        
      drawFlattenTree(layerTree,tint,null);
      pauseVideo(videoExport,60);
      for(int layer=1;layer<Globals.LEVELS;layer++){
        println("Print layer "+layer);
        layerTree = extractLevel(tree,layer);
        boolean ascX=layer%2==0?true:false;
        boolean ascY=layer%2==0?false:true;        
        sortFlattenTreeByX(layerTree,ascX);
        sortFlattenTreeByY(layerTree,ascY);
        drawFlattenTree(layerTree,tint,videoExport);
        // pauseVideo(videoExport,10);
      }    
      save("video/"+MyUtils.getFileName()+".jpg"); 
      videoExport.endMovie();
    }
  exit();
}
