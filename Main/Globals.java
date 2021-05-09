import processing.core.*;
import java.util.ArrayList;

public class Globals{
    private static PApplet app;
    public static ArrayList<Integer> TILES_INDEXES_VALID;
    public static void init(PApplet app){
        Globals.app=app;
        Globals.TILES_INDEXES_VALID=new ArrayList<Integer>();
        // Globals.TILES_INDEXES_VALID.add(14);
        // Globals.TILES_INDEXES_VALID.add(11);
        // Globals.TILES_INDEXES_VALID.add(2);
    }
    public static double TILE_PADDING_RATIO=1.0/5.0;
    public static int TILE_SIZE=400;
    public static int COLS=10;
    public static int ROWS=10;
    public static int CORNER=3;
    public static int LEVELS=3;
    public static double SPLIT_RATE = 0.5;
    public static int BLUE=255/2;
    public static int SMOOTH=8;
    public static int WIDTH=200;
    public static int HEIGHT=200;
    public static int SPLIT_THRESHOLD=25;
    public static int LAYER_COLOR_TH=1;
    public static int FRAME_RATE=60;
    public static double CHANGE_TILE_RATE=0.2;
    public static int CHANGE_TILE_NUM=1;
    public static double COLOR_FACTOR=0.6;
    public static int mosaic_width;
    public static int mosaic_height;
}