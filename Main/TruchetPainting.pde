import com.hamoid.*;

import java.util.Random;
import java.text.DecimalFormat;
Random random = new Random();


void randomize(){
  TileProviderSingleton.getInstance().generateRandomIndexes(-2);
  //Globals.STARTING_NEGATIVE=random.nextBoolean();
}

PImage img;
PImage[][] imagesGrid;

public ArrayList<Tile> generate(){  
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
public ArrayList<Tile> generateWithSplit(){  
  ArrayList<Tile> firstLevel = new ArrayList<Tile>();
  for(int r=0;r<Globals.ROWS;r++){
    for(int c=0;c<Globals.COLS;c++){
      PImage bgImage = imagesGrid[r][c];
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

void settings(){
  img = loadImage("images/g2.jpg");
  // img.filter(GRAY);
  double imgRatio = (double)img.width/(double)img.height;
  Globals.ROWS = (int)(Globals.COLS/imgRatio);
  int treeWidth = (int)((Globals.COLS-1)*(Globals.TILE_SIZE*(1-2.0*Globals.TILE_PADDING_RATIO))+Globals.TILE_SIZE);
  int treeHeigth = (int) ((Globals.ROWS-1)*(Globals.TILE_SIZE*(1-2.0*Globals.TILE_PADDING_RATIO))+Globals.TILE_SIZE);
  Globals.WIDTH=treeWidth+Globals.PADDING*2;
  Globals.HEIGHT=treeHeigth+Globals.PADDING*2;
  setSize(Globals.WIDTH, Globals.HEIGHT);
  smooth(Globals.SMOOTH);
  println("window: "+ Globals.WIDTH+" x "+Globals.HEIGHT);
}

void setup() {
  TileProviderSingleton.init(this);
  MyUtils.init(this);
  imagesGrid = MyUtils.getSubimagesGrid(img,Globals.ROWS,Globals.COLS);
  Globals.init(this);
}

void draw() {
   
    translate(Globals.PADDING,Globals.PADDING);
    for(int step=1;step<=100;step++){
       background(0);
      println("----- "+step+" -----");
        String fileName =getFileName()+"-"+step;
        println(fileName);
        randomize();
        ArrayList<Tile> tree = generateWithSplit();
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
        save("out/"+fileName+".jpg");
        saveGlobals("out/"+fileName+".txt");
        println("-------------");
      
    }
  exit();
}
