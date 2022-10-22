import processing.core.*;
import java.util.ArrayList;

public class Globals{
    private static PApplet app;
    public static ArrayList<Integer> TILES_INDEXES_VALID;
    public static void init(PApplet app){
      Globals.app=app;
      Globals.TILES_INDEXES_VALID=new ArrayList<Integer>();
//      Globals.TILES_INDEXES_VALID.add(0);
      Globals.TILES_INDEXES_VALID.add(1);
      Globals.TILES_INDEXES_VALID.add(2);
      //Globals.TILES_INDEXES_VALID.add(3);
      // Globals.TILES_INDEXES_VALID.add(4);
      // Globals.TILES_INDEXES_VALID.add(5);
      // Globals.TILES_INDEXES_VALID.add(6);
       //Globals.TILES_INDEXES_VALID.add(7);
       Globals.TILES_INDEXES_VALID.add(8);
       Globals.TILES_INDEXES_VALID.add(9);
       Globals.TILES_INDEXES_VALID.add(10);
      // Globals.TILES_INDEXES_VALID.add(11);
       Globals.TILES_INDEXES_VALID.add(12);
       Globals.TILES_INDEXES_VALID.add(13);
      // Globals.TILES_INDEXES_VALID.add(14);
      // Globals.TILES_INDEXES_VALID.add(15);
      // Globals.TILES_INDEXES_VALID.add(16);
      // Globals.TILES_INDEXES_VALID.add(17);
      // Globals.TILES_INDEXES_VALID.add(18);

    }
    //public static int MAX_TILES_INDEX = 15;
    // public static int MAX_TILES_INDEX = 19;
    public static int MAX_TILES_INDEX = 4;
    /// 1: painting from image
    /// 2: generate with split
    /// 3: frame
    /// 4: Q1,Q4
    /// 5: Split on columns
    /// 6: BottomRight
    /// 7: Pattern
    public static int ALG = 7;
    /// 1:
    /// ↑ ←
    /// → ↓
    /// 2:
    /// ↑ ↓
    /// ↓ ↑
    public static int PATTERN = 2;
    public static int BG = 0x00000000;
    public static String BASE_IMAGE="images/bg.png";
    public static boolean USE_BASE_IMAGE=true;
    public static String TILES_FOLDER="tiles/pattern/A";
    //public static String TILES_FOLDER="tiles/tiles_transparent";
    // 0 per pattern
   // public static double TILE_PADDING_RATIO=1.0/5.0;
    public static double TILE_PADDING_RATIO=0.0;
    public static int TILE_SIZE=200;
    public static int COLS=12;
    public static int ROWS=12;
    public static int SPLIT_THRESHOLD=30;
    public static int PADDING = TILE_SIZE/2;
    public static int CORNER=4;
    public static int LEVELS=2;
    public static double SPLIT_RATE = 0.5;
    public static int SMOOTH=8;
    public static int WIDTH=200;
    public static int HEIGHT=200;
    public static int ALPHA = 230;
    public static boolean STARTING_NEGATIVE=false;

    public static int LAYER_COLOR_TH=0;
    public static int FRAME_RATE=30;
    public static double CHANGE_TILE_RATE=0.2;
    public static int CHANGE_TILE_NUM=1;
    public static double COLOR_FACTOR=0.6;
    public static int BLUE=127;
    public static int mosaic_width;
    public static int mosaic_height;
    public static float STROKE_WEIGHT = 1;
    public static float DIAMETER = 220;
    // ultimate grey = 949398
    // illuminating = F5DF4D
    
    // living coral = FC766A
    // pacific coast = 5B84B1
    public static int COLOR1=0xff0063B2;
    public static int COLOR2=0xffADEFD1;
    public static boolean BICOLOR=false;
    public static int GREEN_SCREEN = 0xFFFFFFFF;
    public static boolean ORDER_BY_LAYER_ASC = false;
    
}
