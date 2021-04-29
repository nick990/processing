import processing.core.*;
import java.util.ArrayList;

public class Constants{
    private static PApplet app;

    public static void init(PApplet app){
        Constants.app=app;
    }
    public static double TILE_PADDING_RATIO=1.0/5.0;
    public static int TILE_SIZE=200;
    public static int COLS=15;
    public static int ROWS=15;
    public static int LEVELS=2;
    public static Double SPLIT_RATE = 0.3;

}