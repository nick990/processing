import java.util.Random;
import java.text.DecimalFormat;

int PADDING = Globals.TILE_SIZE/2;
int mosaic_width;
int mosaic_height;
int window_width;
int window_height;

// Cambia le constanti globali per randomizzare la generazione
void randomize(){
  int max_levels = 5;
  double min_rate = 0.2;
  double max_rate = 0.8;
  int corner_max=3;
  Globals.LEVELS=new Random().nextInt(max_levels)+1;
  Globals.SPLIT_RATE=new Random().nextDouble()*(max_rate-min_rate)+min_rate;
  TileProviderSingleton.getInstance().generateRandomIndexes(-1);
  Globals.CORNER=new Random().nextInt(corner_max)+1;
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

  // Splitto tutti fino al massimo livello
  // for(Tile t:firstLevel){
  //     t.split(Globals.LEVELS-1);
  // }
  // reorderFlattenTree(flattenTree);

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
// void generate2(){  
//   println(getFileName());
//   firstLevel = new ArrayList<Tile>();
//   for(int r=0;r<Globals.ROWS;r++){
//     for(int c=0;c<Globals.COLS;c++){ 
//       int imageIndex=TileProviderSingleton.getInstance().getRandomIndex();
//       boolean negative=false;
//       Tile t = new Tile(r,c,imageIndex,negative,0,0,0);
//       firstLevel.add(t);
//       t.split(c+1);
//     }
//   }
//   flattenTree = getFlattenTree(firstLevel);
//   reorderFlattenTree(flattenTree);
//   }

//angolo in basso a dx  
// void generate3(){  
//   println(getFileName());
//   firstLevel = new ArrayList<Tile>();
//   for(int r=0;r<Globals.ROWS;r++){
//     for(int c=0;c<Globals.COLS;c++){ 
//       int imageIndex=TileProviderSingleton.getInstance().getRandomIndex();
//       boolean negative=false;
//       Tile t = new Tile(r,c,imageIndex,negative,0,0,0);
//       firstLevel.add(t);      
//       int levelFromR=r;
//       int levelFromC=c;
//       int depth = Math.min(levelFromC,levelFromR);
//       t.split(depth);
//     }
//   }
//   flattenTree = getFlattenTree(firstLevel);
//   reorderFlattenTree(flattenTree);
// }

//quadranti
// void generate4(){
//   println(getFileName());
//   firstLevel = new ArrayList<Tile>();
//   for(int r=0;r<Globals.ROWS;r++){
//     for(int c=0;c<Globals.COLS;c++){ 
//       int imageIndex=TileProviderSingleton.getInstance().getRandomIndex();
//       boolean negative=false;
//       Tile t = new Tile(r,c,imageIndex,negative,0,0,0);
//       int depth=0;
//       int corner=Globals.CORNER;
//       //Q1
//       if(r<Globals.ROWS/2 && c<Globals.COLS/2){
//         depth = Math.min(r,c);
//         if(r>corner&&c>corner)
//           continue;
//       }
//       //Q2
//       if(r<Globals.ROWS/2&&c>=Globals.COLS/2){
//         depth=Math.min(r,Globals.COLS-1-c);
//          if(r>corner&&Globals.COLS-1-c>corner)
//           continue;
//       }
//       //Q3
//       if(r>=Globals.ROWS/2&&c<Globals.COLS/2){
//         depth=Math.min(Globals.ROWS-1-r,c);
//          if(Globals.ROWS-1-r>corner&&c>corner)
//           continue;
//       }
//       //Q4
//       if(r>=Globals.ROWS/2&&c>=Globals.COLS/2){        
//         depth=Math.min(Globals.ROWS-1-r,Globals.COLS-1-c);
//          if(Globals.ROWS-1-r>corner&&Globals.COLS-1-c>corner)
//           continue;
//       }
//       t.split(depth);
//       firstLevel.add(t);      
//     }
//   }
//   flattenTree = getFlattenTree(firstLevel);
//   reorderFlattenTree(flattenTree);
// }


void settings(){
  int mosaic_width = (int)((Globals.COLS-1)*(Globals.TILE_SIZE*(1-2.0*Globals.TILE_PADDING_RATIO))+Globals.TILE_SIZE);
  int mosaic_height = (int) ((Globals.ROWS-1)*(Globals.TILE_SIZE*(1-2.0*Globals.TILE_PADDING_RATIO))+Globals.TILE_SIZE);
  int window_width=mosaic_width+PADDING*2;
  int window_height=mosaic_height+PADDING*2;
  println("window: "+window_width+" x "+window_height);
  println("mosaic: "+mosaic_width+" x "+mosaic_height);
  setSize(window_width,window_height);
  smooth(Globals.SMOOTH);  
}

void setup() {
  TileProviderSingleton.init(this);
  MyUtils.init(this);
  Globals.init(this);
}
void draw() {
    background(255);
    translate(PADDING,PADDING); 
    for(int step=0;step<20;step++){
        randomize();
        println(step+" "+MyUtils.getFileName());
        ArrayList<Tile> tree = generate();
        for(int i=0;i<tree.size();i++){
            Tile t = tree.get(i);
            if(i%100==0)
                println((i+1)+"/"+tree.size());
            t.drawTree();
        }
        println("saving...");
        save("out/"+step+"_"+MyUtils.getFileName());
        println("saved");
    }  
  exit();
}

