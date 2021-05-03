import processing.core.*;
import java.util.ArrayList;
import java.util.Random;

public class TileProviderSingleton{
  private static TileProviderSingleton instance;
  private static PApplet app;
  private ArrayList<PImage> images;
  private ArrayList<PImage> imagesNegative;
  public int MAX_TILES_INDEX = 15;
  public ArrayList<Integer> TILES_INDEXES;
  
  public static void init(PApplet app){
    TileProviderSingleton.app=app;
  }

  private TileProviderSingleton(){
    images = new ArrayList<PImage>();
    imagesNegative = new ArrayList<PImage>();
     for(int i=1;i<=MAX_TILES_INDEX;i++){
        app.println("loading tile"+i);
        images.add(app.loadImage("tiles/tile"+i+".png"));
        imagesNegative.add(app.loadImage("tiles/tile"+i+"_neg.png"));
      }
      initTilesIndexes();
  }

  private void initTilesIndexes(){
    TILES_INDEXES = new ArrayList<Integer>();
    for(int i=0;i<MAX_TILES_INDEX;i++){
      TILES_INDEXES.add(i);
    }
  }

   public static TileProviderSingleton getInstance()
   { 
     if (instance==null)
     {
       instance= new TileProviderSingleton();
      }
    
     return instance;
   }
   public PImage getImageByIndex(int index){
    return getImageByIndex(index,false);
    
  }
  public PImage getImageByIndex(int index, boolean negative){
    if(!negative)
      return this.images.get(index);
     return this.imagesNegative.get(index);    
  }

  public int getRandomIndex(){
    if(Constants.TILES_INDEXES_VALID.size()==0)
      return new Random().nextInt(images.size());
    return Constants.TILES_INDEXES_VALID.get(new Random().nextInt(Constants.TILES_INDEXES_VALID.size()));
  }

  //Genera il subset di indici di dimensione size
  //Se size=-1 -> casuale
  public void generateRandomIndexes(int size){
    if(size<0)
      size = new Random().nextInt(MAX_TILES_INDEX)+1;
    initTilesIndexes();
    Constants.TILES_INDEXES_VALID=new ArrayList<Integer>();
    while((size)>0){
      int i = new Random().nextInt(TILES_INDEXES.size());
      Constants.TILES_INDEXES_VALID.add(TILES_INDEXES.get(i));
      TILES_INDEXES.remove(i);
      size--;
    }
  }

}
