import processing.core.*;
import java.util.ArrayList;

public class Globals{
    private static PApplet app;
    public static ArrayList<Integer> TILES_INDEXES_VALID;
    public static void init(PApplet app){
        Globals.app=app;
        Globals.TILES_INDEXES_VALID=new ArrayList<Integer>();
         Globals.TILES_INDEXES_VALID.add(0);
         Globals.TILES_INDEXES_VALID.add(1);
         //Globals.TILES_INDEXES_VALID.add(2);
         //Globals.TILES_INDEXES_VALID.add(3);
        //Globals.TILES_INDEXES_VALID.add(4);
         //Globals.TILES_INDEXES_VALID.add(5);
        // Globals.TILES_INDEXES_VALID.add(6);
        // Globals.TILES_INDEXES_VALID.add(7);
        // Globals.TILES_INDEXES_VALID.add(8);
       // Globals.TILES_INDEXES_VALID.add(9);
       //  Globals.TILES_INDEXES_VALID.add(10);
       //  Globals.TILES_INDEXES_VALID.add(11);
       //  Globals.TILES_INDEXES_VALID.add(12);
        // Globals.TILES_INDEXES_VALID.add(13);
        // Globals.TILES_INDEXES_VALID.add(14);
      //  Globals.TILES_INDEXES_VALID.add(15);
      //  Globals.TILES_INDEXES_VALID.add(16);
      //  Globals.TILES_INDEXES_VALID.add(17);
      //  Globals.TILES_INDEXES_VALID.add(18);
        
    }
    public static double TILE_PADDING_RATIO=1.0/5.0;
    public static int TILE_SIZE=2500;
    public static int COLS=12;
    public static int ROWS=12;
    public static int SPLIT_THRESHOLD=0;
    public static int PADDING = TILE_SIZE;
    public static int CORNER=3;
    public static int LEVELS=2;
    public static double SPLIT_RATE = 0.5;
    public static int SMOOTH=8;
    public static int WIDTH=2000;
    public static int HEIGHT=2000;
    public static int ALPHA = 200;
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
    public static float DIAMETER = 200;
    // ultimate grey = 949398
    // illuminating = F5DF4D
    
    // living coral = FC766A
    // pacific coast = 5B84B1
    public static int COLOR1=0xC8F93822;
    public static int COLOR2=0xC8FDD20E;
    public static boolean BICOLOR=false;
}
