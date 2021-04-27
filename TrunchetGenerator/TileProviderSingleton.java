import processing.core.*;
import java.util.ArrayList;
import java.util.Random;

public class TileProviderSingleton{
  private static TileProviderSingleton instance;
  private static PApplet app;
  private ArrayList<PImage> images;
  private ArrayList<PImage> imagesNegative;
  
  public static void init(PApplet app){
    TileProviderSingleton.app=app;
  }

  private TileProviderSingleton(){
    images = new ArrayList<PImage>();
    imagesNegative = new ArrayList<PImage>();
     for(int i=1;i<=15;i++){
        app.println("loading tile"+i);
        images.add(app.loadImage("tiles/tile"+i+".png"));
        imagesNegative.add(app.loadImage("tiles/tile"+i+"_neg.png"));
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
   return new Random().nextInt(images.size());
  }

}
