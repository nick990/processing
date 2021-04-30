import processing.core.*;
import java.util.ArrayList;

public class Constants{
    private static PApplet app;

    public static void init(PApplet app){
        Constants.app=app;
    }
    public static double TILE_PADDING_RATIO=1.0/5.0;
    public static int TILE_SIZE=250;
    public static int COLS=12;
    public static int ROWS=12;
    public static int CORNER=3;
    public static int LEVELS=3;
    public static Double SPLIT_RATE = 0.5;
    public static int BLUE=255/2;
    public static int SMOOTH=8;

}