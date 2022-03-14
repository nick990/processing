import processing.core.*;
import java.util.ArrayList;
import java.util.Random;

public class TileProviderSingleton {
  private static TileProviderSingleton instance;
  private static PApplet app;
  private ArrayList<PImage> images;
  private ArrayList<PImage> imagesNegative;
  public int MAX_TILES_INDEX = 15;
  // public int MAX_TILES_INDEX = 19;
  public ArrayList<Integer> TILES_INDEXES;

  public static void init(PApplet app) {
    TileProviderSingleton.app = app;
  }

  private TileProviderSingleton() {
    images = new ArrayList<PImage>();
    imagesNegative = new ArrayList<PImage>();
    for (int i = 1; i <= MAX_TILES_INDEX; i++) {
      app.println("loading tile" + i);
      images.add(app.loadImage("tiles/tile" + i + ".png"));
      imagesNegative.add(app.loadImage("tiles/tile" + i + "_neg.png"));
    }
    initTilesIndexes();
  }

  private void initTilesIndexes() {
    TILES_INDEXES = new ArrayList<Integer>();
    for (int i = 0; i < MAX_TILES_INDEX; i++) {
      TILES_INDEXES.add(i);
    }
  }

  public static TileProviderSingleton getInstance() {
    if (instance == null) {
      instance = new TileProviderSingleton();
    }

    return instance;
  }

  public PImage getImageByIndex(int index) {
    return getImageByIndex(index, false);

  }

  public PImage getImageByIndex(int index, boolean negative) {
    if (!negative)
      return this.images.get(index);
    return this.imagesNegative.get(index);
  }

  public int getRandomIndex() {
    if (Globals.TILES_INDEXES_VALID.size() == 0)
      return new Random().nextInt(images.size());
    return Globals.TILES_INDEXES_VALID.get(new Random().nextInt(Globals.TILES_INDEXES_VALID.size()));
  }

  // Genera il subset di indici di dimensione size
  // Se size <0:
  // size = -1 : dimensione casuale
  // size = -2 : 1,2
  // size = -3 : 3,4
  // size = -4 : 8,9,10,11
  // size = -5 : 12,13,14,15
  public void generateRandomIndexes(int size) {
    initTilesIndexes();
    Globals.TILES_INDEXES_VALID = new ArrayList<Integer>();
    switch (size) {
      case -5:
      Globals.TILES_INDEXES_VALID.add(TILES_INDEXES.get(11));
      Globals.TILES_INDEXES_VALID.add(TILES_INDEXES.get(12));
      Globals.TILES_INDEXES_VALID.add(TILES_INDEXES.get(13));
      Globals.TILES_INDEXES_VALID.add(TILES_INDEXES.get(14));
      break;
      case -4:
      Globals.TILES_INDEXES_VALID.add(TILES_INDEXES.get(7));
      Globals.TILES_INDEXES_VALID.add(TILES_INDEXES.get(8));
      Globals.TILES_INDEXES_VALID.add(TILES_INDEXES.get(9));
      Globals.TILES_INDEXES_VALID.add(TILES_INDEXES.get(10));
      break;
      case -3:
      Globals.TILES_INDEXES_VALID.add(TILES_INDEXES.get(2));
      Globals.TILES_INDEXES_VALID.add(TILES_INDEXES.get(3));
      break;
      case -2:
      Globals.TILES_INDEXES_VALID.add(TILES_INDEXES.get(0));
      Globals.TILES_INDEXES_VALID.add(TILES_INDEXES.get(1));
      break;
      case -1:
      size = new Random().nextInt(MAX_TILES_INDEX) + 1;
      break;
      default:
      break;
    }
    while ((size) > 0) {
      int i = new Random().nextInt(TILES_INDEXES.size());
      Globals.TILES_INDEXES_VALID.add(TILES_INDEXES.get(i));
      TILES_INDEXES.remove(i);
      size--;
    }
  }
}
