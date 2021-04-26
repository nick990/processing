import java.util.Random;

public class TileProvider{
  private ArrayList<PImage> images;
  private ArrayList<PImage> imagesNegative;
  
  public TileProvider(){
    images = new ArrayList<PImage>();
    imagesNegative = new ArrayList<PImage>();
     for(int i=1;i<=7;i++){
         println("loading tile"+i);
          images.add(loadImage("tiles/tile"+i+".png"));
          imagesNegative.add(loadImage("tiles/tile"+i+"_neg.png"));
      }
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
