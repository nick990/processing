

Settings settings;

void settings(){
  settings = new Settings(this, "settings.txt");  
  setSize(settings.WIDTH, settings.HEIGHT);
}

void setup() {
  stroke(255);
  background(settings.BG_COLOR);
  
}

void draw() {
  settings.saveToFile("settings.txt");
  exit();
}

void mousePressed() {
  println(settings);
  println(settings.BG_COLOR);
  background(settings.BG_COLOR);
}
