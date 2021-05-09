import com.hamoid.*;

import java.util.Random;
import java.text.DecimalFormat;

int PADDING = Globals.TILE_SIZE/2;
int window_width;
int window_height;

// Cambia le constanti globali per randomizzare la generazione
void randomize(){
//   int max_levels = 5;
//   double min_rate = 0.2;
//   double max_rate = 0.8;
//   int corner_max=3;
//   Globals.LEVELS=new Random().nextInt(max_levels)+1;
//   Globals.SPLIT_RATE=new Random().nextDouble()*(max_rate-min_rate)+min_rate;
//   Globals.CORNER=new Random().nextInt(corner_max)+1;
  TileProviderSingleton.getInstance().generateRandomIndexes(-1);
  //Globals.COLOR_FACTOR = new Random().nextDouble()*0.9+0.1;
}

// Genera un nuovo albero
// Al termine ho flattenTree ordinato e pronto per essere disegnato
public ArrayList<Tile> generate(){  
  ArrayList<Tile> firstLevel = new ArrayList<Tile>();
  for(int r=0;r<Globals.ROWS;r++){
    for(int c=0;c<Globals.COLS;c++){ 
      int imageIndex=TileProviderSingleton.getInstance().getRandomIndex();
      boolean negative=false;
      firstLevel.add(new Tile(r,c,imageIndex,negative,0,0,0,null));
    }
  }
  ArrayList<Tile> flattenTree = getFlattenTree(firstLevel);

  // Splitto il [SPLIT_RATE]% di ogni livello
  for(int level=1;level<Globals.LEVELS;level++){
    for(Tile t:flattenTree){
      if(t.layer==level-1 && new Random().nextDouble()<Globals.SPLIT_RATE)
        t.split(1);
    }
    flattenTree = getFlattenTree(flattenTree);
    sortFlattenTree(flattenTree);
  }
  return flattenTree;
}
//spliita con le colonne
ArrayList<Tile> generate2(){  
  ArrayList<Tile> firstLevel = new ArrayList<Tile>();
  firstLevel = new ArrayList<Tile>();
  for(int r=0;r<Globals.ROWS;r++){
    for(int c=0;c<Globals.COLS;c++){ 
      int imageIndex=TileProviderSingleton.getInstance().getRandomIndex();
      boolean negative=false;
      Tile t = new Tile(r,c,imageIndex,negative,0,0,0,null);
      firstLevel.add(t);
      t.split(c+1);
    }
  }
  return firstLevel;
  }

// angolo in basso a dx  
ArrayList<Tile> generate3(){  
  ArrayList<Tile> firstLevel = new ArrayList<Tile>();
  for(int r=0;r<Globals.ROWS;r++){
    for(int c=0;c<Globals.COLS;c++){ 
      int imageIndex=TileProviderSingleton.getInstance().getRandomIndex();
      boolean negative=false;
      Tile t = new Tile(r,c,imageIndex,negative,0,0,0,null);
      firstLevel.add(t);      
      int levelFromR=r;
      int levelFromC=c;
      int depth = Math.min(levelFromC,levelFromR);
      t.split(depth);
    }
  }
  return firstLevel;
}

// quadranti
ArrayList<Tile> generate4(){
 ArrayList<Tile> firstLevel = new ArrayList<Tile>();
  for(int r=0;r<Globals.ROWS;r++){
    for(int c=0;c<Globals.COLS;c++){ 
      int imageIndex=TileProviderSingleton.getInstance().getRandomIndex();
      boolean negative=false;
      Tile t = new Tile(r,c,imageIndex,negative,0,0,0,null);
      int depth=0;
      int corner=Globals.CORNER;
      //Q1
      if(r<Globals.ROWS/2 && c<Globals.COLS/2){
        depth = Math.min(r,c);
        if(r>corner&&c>corner)
          continue;
      }
      //Q2
      if(r<Globals.ROWS/2&&c>=Globals.COLS/2){
        depth=Math.min(r,Globals.COLS-1-c);
         if(r>corner&&Globals.COLS-1-c>corner)
          continue;
      }
      //Q3
      if(r>=Globals.ROWS/2&&c<Globals.COLS/2){
        depth=Math.min(Globals.ROWS-1-r,c);
         if(Globals.ROWS-1-r>corner&&c>corner)
          continue;
      }
      // Q4
      if(r>=Globals.ROWS/2&&c>=Globals.COLS/2){        
        depth=Math.min(Globals.ROWS-1-r,Globals.COLS-1-c);
         if(Globals.ROWS-1-r>corner&&Globals.COLS-1-c>corner)
          continue;
      }
      t.split(Math.min(depth,Globals.LEVELS-1));
      firstLevel.add(t);      
    }
  }
  return firstLevel;
}


void settings(){
  Globals.mosaic_width = (int)((Globals.COLS-1)*(Globals.TILE_SIZE*(1-2.0*Globals.TILE_PADDING_RATIO))+Globals.TILE_SIZE);
  Globals.mosaic_height = (int) ((Globals.ROWS-1)*(Globals.TILE_SIZE*(1-2.0*Globals.TILE_PADDING_RATIO))+Globals.TILE_SIZE);
  window_width=Globals.mosaic_width+PADDING*2;
  window_height=Globals.mosaic_height+PADDING*2;
  println("window: "+window_width+" x "+window_height);
  println("mosaic: "+Globals.mosaic_width+" x "+Globals.mosaic_height);
  setSize(window_width,window_height);
  smooth(Globals.SMOOTH);  
}

void setup() {
  TileProviderSingleton.init(this);
  MyUtils.init(this);
  Globals.init(this);
}
void draw() {
    background(0);
    translate(PADDING,PADDING); 
     for(int j=0;j<100;j++){
        println("-----"+j+"-----");
        randomize();
        //  Globals.TILES_INDEXES_VALID=new ArrayList<Integer>();
        // Globals.TILES_INDEXES_VALID.add(j);
        println(getFileName());
        ArrayList<Tile> tree = generate4();
        ArrayList<Tile> flatten = getFlattenTree(tree);
        sortFlattenTreeByY(flatten,true);
        sortFlattenTreeByX(flatten,true);
        sortFlattenTree(flatten);
        for(int i=0;i<flatten.size();i++){
            Tile t = flatten.get(i);
            if(i%100==0)
                println((i+1)+"/"+flatten.size());
            t.draw(true);
        }
        save("out/gen4/"+getFileName()+".jpg");
        println("saved");
     }  
  exit();
}
