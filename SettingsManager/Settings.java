import processing.core.*;
import java.util.ArrayList;

public class Settings{
  private static Settings instance;
  
  private PApplet app;
  
  public int WIDTH;
  public int HEIGHT;
  public int BG_COLOR;
  
  
  public Settings(PApplet app, String file){
    this.app = app;
    String[] textLines = this.app.loadStrings(file);
      for(String line : textLines){
        var tokens = line.split("=");
        var key = tokens[0];
        var value = tokens[1];
        app.println(key+" : "+value);
        switch(key){
          case "WIDTH":
            this.WIDTH = Integer.parseInt(value);
            break;
          case "HEIGHT":
            this.HEIGHT = Integer.parseInt(value);
            break;
          case "BG_COLOR":
            this.BG_COLOR = this.app.unhex(value);
            break;
        }
      }
  }
  
  public void saveToFile(String path){
    ArrayList<String> settingsAsStringList = new ArrayList<String>();
    settingsAsStringList.add("WIDTH="+this.WIDTH);
    settingsAsStringList.add("HEIGHT="+this.HEIGHT);
    settingsAsStringList.add("BG_COLOR="+this.app.hex(this.BG_COLOR));
    String[] settingsAsStringArray = new String[settingsAsStringList.size()];
    settingsAsStringArray = settingsAsStringList.toArray(settingsAsStringArray);
    this.app.saveStrings(path, settingsAsStringArray);
  }  
}
