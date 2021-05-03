import java.util.Random;
import java.text.DecimalFormat;

int PADDING = Globals.TILE_SIZE/2;
int mosaic_width;
int mosaic_height;
int window_width;
int window_height;
ArrayList<Tile> firstLevel;
ArrayList<Tile> flattenTree;

public  ArrayList<Tile> getFlattenTree(ArrayList<Tile> firstLevel){
    ArrayList<Tile> flattenTree = new ArrayList<Tile>(); 
    for(Tile t:firstLevel)
      flattenTree.addAll(t.getFlattenTree());
    return flattenTree;
}

public void reorderFlattenTree(ArrayList<Tile> tiles){
    for(int i=0;i<tiles.size();i++){
      for(int j=i+1;j<tiles.size();j++){
                  Tile t_i = tiles.get(i);
                  Tile t_j = tiles.get(j);                
                  if(t_i.layer>t_j.layer){
                      Tile aux=t_i.clone();
                      tiles.set(i,t_j);
                      tiles.set(j,aux);
                  }
        }
    }
}

public ArrayList<Tile> makeHoles(ArrayList<Tile> tiles){
  ArrayList<Tile> aux = new ArrayList<Tile>();
  for(Tile t:tiles){
    if(new Random().nextDouble()<0.7){
      aux.add(t);
    }
  }
  return aux;
}

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
void generate1(){  
  println(getFileName());
  firstLevel = new ArrayList<Tile>();
  for(int r=0;r<Globals.ROWS;r++){
    for(int c=0;c<Globals.COLS;c++){ 
      int imageIndex=TileProviderSingleton.getInstance().getRandomIndex();
      boolean negative=false;
      firstLevel.add(new Tile(r,c,imageIndex,negative,0,0,0,null));
    }
  }
  flattenTree = getFlattenTree(firstLevel);

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
    reorderFlattenTree(flattenTree);
  }
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



String getFolderName(){
  return Globals.ROWS+"x"+Globals.COLS+"_"+Globals.TILE_SIZE;
}

String getFileName(){
  DecimalFormat df2 = new DecimalFormat("#.##");
  return "lev"+Globals.LEVELS+"_rate"+df2.format(Globals.SPLIT_RATE)+"_corner"+Globals.CORNER+"_indexes"+MyUtils.ArrayIntToString(Globals.TILES_INDEXES_VALID);
}


void calculateSize(){
  mosaic_width = (int)((Globals.COLS-1)*(Globals.TILE_SIZE*(1-2.0*Globals.TILE_PADDING_RATIO))+Globals.TILE_SIZE);
  mosaic_height = (int) ((Globals.ROWS-1)*(Globals.TILE_SIZE*(1-2.0*Globals.TILE_PADDING_RATIO))+Globals.TILE_SIZE);
  window_width=mosaic_width+PADDING*2;
  window_height=mosaic_height+PADDING*2;
  println("window: "+window_width+" x "+window_height);
  println("mosaic: "+mosaic_width+" x "+mosaic_height);
  setSize(window_width,window_height);
}

void settings(){
  calculateSize();
  smooth(Globals.SMOOTH);  
}

void setup() {
  TileProviderSingleton.init(this);
  MyUtils.init(this);
  Globals.init(this);
}
void draw() {
  translate(PADDING,PADDING);  
  // for(int i=0;i<20;i++){
  //   println(i+")");
    // randomize();
    generate1();
    background(255);
    int count=1;
    for(Tile t : flattenTree){
      // if(count%100==0)
      println((count++)+"/"+flattenTree.size());
      t.drawTree(); 
    }
    save("out/"+getFolderName()+"_"+getFileName()+".jpg");
    println("saved");
    exit();
  }

