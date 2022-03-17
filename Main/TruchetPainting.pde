import com.hamoid.*;

import java.util.Random;
import java.text.DecimalFormat;


void randomize(){
  //TileProviderSingleton.getInstance().generateRandomIndexes(-1);
  //Globals.STARTING_NEGATIVE=random.nextBoolean();
}

PImage img;
PImage[][] imagesGrid;
Random random = new Random();

public ArrayList<Tile> generatePainting(){  
  ArrayList<Tile> tree = new ArrayList<Tile>();
  for(int r=0;r<Globals.ROWS;r++){
    for(int c=0;c<Globals.COLS;c++){
      PImage bgImage = imagesGrid[r][c];
      int imageIndex=TileProviderSingleton.getInstance().getRandomIndex();
      boolean negative=Globals.STARTING_NEGATIVE;
      Tile t = new Tile(r,c,imageIndex,negative,0,0,0,bgImage);
      t.generateSubTree();
      tree.add(t);
    }
  }
  // ArrayList<Tile> flattenTree = getFlattenTree(tree);
  // sortFlattenTree(flattenTree);
  // return flattenTree;
  return tree;
}

// Genera un nuovo albero
// Al termine ho flattenTree ordinato e pronto per essere disegnato
public ArrayList<Tile> generate(){  
  ArrayList<Tile> firstLevel = new ArrayList<Tile>();
  for(int r=0;r<Globals.ROWS;r++){
    for(int c=0;c<Globals.COLS;c++){
      PImage bgImage = Globals.USE_BASE_IMAGE?imagesGrid[r][c]:null;
      int imageIndex=TileProviderSingleton.getInstance().getRandomIndex();
      boolean negative=Globals.STARTING_NEGATIVE;
      firstLevel.add(new Tile(r,c,imageIndex,negative,0,0,0,bgImage));
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

ArrayList<Tile> generateFrame(){
 ArrayList<Tile> firstLevel = new ArrayList<Tile>();
  for(int r=0;r<Globals.ROWS;r++){
    for(int c=0;c<Globals.COLS;c++){ 
      int imageIndex=TileProviderSingleton.getInstance().getRandomIndex();
      boolean negative=Globals.STARTING_NEGATIVE;
      PImage bgImage = Globals.USE_BASE_IMAGE?imagesGrid[r][c]:null;
      Tile t = new Tile(r,c,imageIndex,negative,0,0,0,bgImage);
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

// quadranti
ArrayList<Tile> generateQ1Q4(){
 ArrayList<Tile> firstLevel = new ArrayList<Tile>();
  for(int r=0;r<Globals.ROWS;r++){
    for(int c=0;c<Globals.COLS;c++){ 
      int imageIndex=TileProviderSingleton.getInstance().getRandomIndex();
      boolean negative=Globals.STARTING_NEGATIVE;
      PImage bgImage = Globals.USE_BASE_IMAGE?imagesGrid[r][c]:null;
      Tile t = new Tile(r,c,imageIndex,negative,0,0,0,bgImage);
      int depth=0;
      int corner=Globals.CORNER;
      //Q1
      if(r<Globals.ROWS/2 && c<Globals.COLS/2){
        depth = Math.min(r,c);
        if(r>corner&&c>corner)
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

//Split on columns
ArrayList<Tile> generateColumns(){  
  ArrayList<Tile> firstLevel = new ArrayList<Tile>();
  firstLevel = new ArrayList<Tile>();
  for(int r=0;r<Globals.ROWS;r++){
    for(int c=0;c<Globals.COLS;c++){ 
      int imageIndex=TileProviderSingleton.getInstance().getRandomIndex();
      boolean negative=Globals.STARTING_NEGATIVE;
      PImage bgImage = Globals.USE_BASE_IMAGE?imagesGrid[r][c]:null;
      Tile t = new Tile(r,c,imageIndex,negative,0,0,0,bgImage);
      firstLevel.add(t);
      t.split(c+1);
    }
  }
  return firstLevel;
  }

//Bottom-right
ArrayList<Tile> generateBottomRight(){  
  ArrayList<Tile> firstLevel = new ArrayList<Tile>();
  for(int r=0;r<Globals.ROWS;r++){
    for(int c=0;c<Globals.COLS;c++){ 
      int imageIndex=TileProviderSingleton.getInstance().getRandomIndex();
      boolean negative=Globals.STARTING_NEGATIVE;
       PImage bgImage = Globals.USE_BASE_IMAGE?imagesGrid[r][c]:null;
      Tile t = new Tile(r,c,imageIndex,negative,0,0,0,bgImage);
      firstLevel.add(t);      
      int levelFromR=r;
      int levelFromC=c;
      int depth = Math.min(levelFromC,levelFromR);
      depth = Math.min(depth,Globals.LEVELS-1);
      t.split(depth);
    }
  }
  return firstLevel;
}

void settings(){
  if(Globals.USE_BASE_IMAGE){
    img = loadImage(Globals.BASE_IMAGE);
    double imgRatio = (double)img.width/(double)img.height;
    Globals.ROWS = (int)(Globals.COLS/imgRatio);
    // img.filter(GRAY);
  }else{
    img = null;
  }
  Globals.mosaic_width = (int)((Globals.COLS-1)*(Globals.TILE_SIZE*(1-2.0*Globals.TILE_PADDING_RATIO))+Globals.TILE_SIZE);
  Globals.mosaic_height = (int) ((Globals.ROWS-1)*(Globals.TILE_SIZE*(1-2.0*Globals.TILE_PADDING_RATIO))+Globals.TILE_SIZE);
  Globals.WIDTH=  Globals.mosaic_width+Globals.PADDING*2;
  Globals.HEIGHT=Globals.mosaic_height+Globals.PADDING*2;
  setSize(Globals.WIDTH, Globals.HEIGHT);
  smooth(Globals.SMOOTH);
  println("window: "+ Globals.WIDTH+" x "+Globals.HEIGHT);
  println("mosaic: "+Globals.mosaic_width+" x "+Globals.mosaic_height);
}

//Imposta il colore per il BICOLOR
void setTintForBicolor(){
  int tintColor = Globals.COLOR1;
  if(random.nextBoolean()){
    tintColor = Globals.COLOR2;
  }
  tint(tintColor);
}



void setup() {
  TileProviderSingleton.init(this);
  MyUtils.init(this);
  if(Globals.USE_BASE_IMAGE){
    imagesGrid = MyUtils.getSubimagesGrid(img,Globals.ROWS,Globals.COLS);
  }else{
    imagesGrid = null;
  }
  Globals.init(this);
}

void draw() {   
    translate(Globals.PADDING,Globals.PADDING);
    for(int step=1;step<=1;step++){
       background(Globals.BG);
      println("----- "+step+" -----");
        String fileName =getFileName()+"-"+step;
        println(fileName);
        randomize();
        ArrayList<Tile> tree;
        switch(Globals.ALG){
          case 1:
            tree = generatePainting();
            break;
          case 2:
            tree = generate();
            break;
          case 3:
            tree = generateFrame();
            break;
          case 4:
            tree = generateQ1Q4();
            break;
          case 5:
            tree = generateColumns();
          case 6:
            tree = generateBottomRight();
            break;
          default: 
            return;
        }
        ArrayList<Tile> flatten = getFlattenTree(tree);
        sortFlattenTreeByY(flatten,true);
        sortFlattenTreeByX(flatten,true);
        sortFlattenTree(flatten);
         for(int i=0;i<flatten.size();i++){
            Tile t = flatten.get(i);
            if(i%100==0)
                println((i+1)+"/"+flatten.size());
            if(Globals.BICOLOR){
              setTintForBicolor();
              t.draw(false);
            }else{
              t.draw(true);
            }
        }
        save("out/"+fileName+".jpg");
        saveGlobals("out/"+fileName+".txt");
        println("-------------");
      
    }
  exit();
}
