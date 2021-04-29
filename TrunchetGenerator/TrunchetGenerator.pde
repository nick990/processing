import java.util.Random;
import java.text.DecimalFormat;

int PADDING = Constants.TILE_SIZE/2;
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

void randomize(){
  int max_levels = 3;
  double min_rate = 0.2; 
  Constants.LEVELS=new Random().nextInt(max_levels)+1;
  Constants.SPLIT_RATE=new Random().nextDouble()*(1.0-min_rate)+min_rate;
  TileProviderSingleton.getInstance().generateRandomIndexes(1);
}

void generate(){  
  println(getFileName());
  firstLevel = new ArrayList<Tile>();
  for(int r=0;r<Constants.ROWS;r++){
    for(int c=0;c<Constants.COLS;c++){ 
      int imageIndex=TileProviderSingleton.getInstance().getRandomIndex();
      boolean negative=false;
      firstLevel.add(new Tile(r,c,imageIndex,negative,0,0,0));
    }
  }
  flattenTree = getFlattenTree(firstLevel);

  // Splitto tutti fino al massimo livello
  // for(Tile t:firstLevel){
  //     t.split(Constants.LEVELS-1);
  // }
  // reorderFlattenTree(flattenTree);

  // Splitto il [SPLIT_RATE]% di ogni livello
  for(int level=1;level<Constants.LEVELS;level++){
    for(Tile t:flattenTree){
      if(t.layer==level-1 && new Random().nextDouble()<Constants.SPLIT_RATE)
        t.split(1);
    }
    flattenTree = getFlattenTree(flattenTree);
    reorderFlattenTree(flattenTree);
  }
}

String getFolderName(){
  return Constants.ROWS+"x"+Constants.COLS+"_"+Constants.TILE_SIZE;
}

String getFileName(){
  DecimalFormat df2 = new DecimalFormat("#.##");
  return "lev"+Constants.LEVELS+"_rate"+df2.format(Constants.SPLIT_RATE)+"_indexes"+MyUtils.ArrayIntToString(TileProviderSingleton.getInstance().TILES_INDEXES_VALID);
}


void calculateSize(){
  mosaic_width = (int)((Constants.COLS-1)*(Constants.TILE_SIZE*(1-2.0*Constants.TILE_PADDING_RATIO))+Constants.TILE_SIZE);
  mosaic_height = (int) ((Constants.ROWS-1)*(Constants.TILE_SIZE*(1-2.0*Constants.TILE_PADDING_RATIO))+Constants.TILE_SIZE);
  window_width=mosaic_width+PADDING*2;
  window_height=mosaic_height+PADDING*2;
  println("window: "+window_width+" x "+window_height);
  println("mosaic: "+mosaic_width+" x "+mosaic_height);
  setSize(window_width,window_height);
}

void settings(){
  calculateSize();
  smooth(8);
  
}

void setup() {
  //surface.setResizable(true);
  TileProviderSingleton.init(this);
  MyUtils.init(this);
  Constants.init(this);
}
void draw() {
  translate(PADDING,PADDING);  
  for(int i=0;i<20;i++){
    println(i+")");
    randomize();
    generate();
    background(255);
    
    for(Tile t : flattenTree){
      t.drawTree(); 
    }
    save("out/"+getFolderName()+"_"+getFileName()+".png");
    println("saved");
  }
  
 exit();
}
