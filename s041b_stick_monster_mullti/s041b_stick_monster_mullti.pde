import processing.pdf.*;


PVector changeRate = new PVector(0.03, 0.003, 0.01);
PVector size = new PVector(30, 120);

float baseRot = PI/2;
int sides = 2;
boolean mirror = true;

//int cols[] = {#A6293B, #F2AE03, #FFDD5E, #B0C727, #6B9C95, #ADABFF, #A15785};
//int cols[] = {0, #222222, #444444, #666666, #888888, #AAAAAA, #DDDDDD, #FFFFFF};
//int cols[] = {#000000, #FFFFFF, #000000, #FFFFFF, #000000, #FFFFFF, #000000, #FFFFFF};
//int cols[] = {#333333, #666666, #999999, #CCCCCC, #FFFFFF};
int cols[] = {#FFFFFF, #FFFFFF, #FFFFFF, #FFFFFF, #FFFFFF, #FFFFFF, #FFFFFF, #FFFFFF};

String out_folder = "C:/Leo/1_work/capturas/processing/s041b_stick_monster_multi/";

Part[] parts;
int selected = -1;
int dragging = -1;
boolean go = true;
boolean changeVar = false;
boolean capture = false;
boolean pdf = false;
boolean makeMovie = false;
int t, sd;

void setup() {
  size(900, 900, P2D);
  
  strokeCap(MITER);
  rectMode(CENTER);
  background(255);
  
  parts = new Part[2];
  parts[0] = new Part(0, 2, 13, new PVector(100,100), new PVector(100, height-100));
  parts[1] = new Part(1, 2, 6, new PVector(200,200), new PVector(200, height-200));

  
  randomize();
  //loadData("C:/Leo/1_work/capturas/processing/s041_stick_monster/s041_170419.174435.json");
  //go = false;


}

void randomize() {
  /*for(int l=0; l<nLevels; l++){
    levels[l].slot = l == 0 ? 0 : random(1);
    levels[l].vslot = l == 0 ? 1.0/float(nSticks) : random(-0.1, 0.1);
    levels[l].peg = random(1);
    levels[l].vpeg = random(-0.1, 0.1);
    levels[l].rot = random(PI)-PI/2;
    levels[l].vrot = random(-0.2, 0.2);
  }*/
  
  sd = int(random(999999));
  noiseSeed(sd);
  println("seed", sd);
  background(255);
  t = 0;
}

void draw() {
  //if(go) {
    if(pdf) {
      beginRecord(PDF, out_folder + makeName() + ".pdf");
    }
    
    if(changeVar) background(255, 255, 240);
    else background(255);

    stroke(255, 0, 0);
    line(25, 0, 25, 120);
    
    for(Part p : parts){
      p.step();
      p.paint();
    }
    
    if(go) t++;
    
    if(pdf) {
      endRecord();
      println("pdf captured");
      pdf = false;
    }
  //}
  
  /*if(dragging > 0) {
    if(dragging == 1) root.a.set(mouseX, mouseY);
    else if(dragging == 2) root.z.set(mouseX, mouseY);
    else if(dragging == 3) root.p1.set(mouseX, mouseY);
    else if(dragging == 4) root.p2.set(mouseX, mouseY);
  }*/
  
  if(capture){
    save( out_folder + makeName() + ".jpg" );
    saveData();
    println("capture saved");
    capture = false;
  }
  
  if(makeMovie){
     saveFrame( out_folder + "movie2/sd"+ sd +"_#####.jpg" );
  }
  
}

void saveData() {
  JSONObject o = new JSONObject();
  
  //o.setInt("nLevels", nLevels);
  //o.setInt("nSticks", nSticks);
  o.setFloat("baseRot", baseRot);
  o.setInt("sides", sides);
  o.setBoolean("mirror", mirror);
  
  //o.setJSONObject("root", root.getData());
  
  /*JSONArray ls = new JSONArray();
  for(int i=0; i<nLevels; i++){
    ls.setJSONObject(i, levels[i].getData());
  }
  o.setJSONArray("levels", ls);*/

  saveJSONObject(o, out_folder + makeName() + ".json");
}

void loadData(String url) {
  JSONObject o = loadJSONObject(url);
  
  baseRot = o.getFloat("baseRot");
  sides = o.getInt("sides");
  mirror = o. getBoolean("mirror");
  
  /*JSONObject r = o.getJSONObject("root");
  root.setData(r);
  
  JSONArray ls = o.getJSONArray("levels");
  for(int i=0; i<ls.size(); i++) {
    levels[i].setData(ls.getJSONObject(i));
  }*/
  
  go = false;
}

void keyPressed(){
  switch(key){
    case ' ':
      go = !go;
      break;
    case 's':
      capture = true;
      break;
    case 'p':
      pdf = true;
      break;
     case 'm':
      if(makeMovie) {
        makeMovie = false;
        println("end capture at"+ t);
      }else {
        makeMovie = true;
        println("start capture at"+ t);
      }
      break;
    case 'b':
      background(255);
      break;
    case 'r':
      randomize();
      break;
    /*case 'l':
      selected ++; selected %= nLevels + 1;
      break;
    case 'v':
      changeVar = !changeVar;
      break;
    case ',':
      if(selected >= 0 && selected < nLevels){
        Level l = levels[selected];
        if(changeVar) l.vrot += 0.01;
        else l.rot += 0.1;
        println("rot", l.rot, l.vrot);
      }
      break;
    case '.':
      if(selected >= 0 && selected < nLevels){
        Level l = levels[selected];
        if(changeVar) l.vrot -= 0.01;
        else l.rot -= 0.1;
        println("rot", l.rot, l.vrot);
      }
      break;
    case '0':
    case '1':
    case '2':
    case '3':
    case '4':
    case '5':
    case '6':
      levels[int(str(key))].visible = ! levels[int(str(key))].visible;
      break;
    case '+':
      for(int l=0; l<nLevels; l++) levels[l].visible = true;
      break;
    case '-':
      for(int l=0; l<nLevels; l++) levels[l].visible = false;
      break;*/
  }
  
  /*if (key == CODED) {
    if (keyCode == UP) {
      if(selected >= 0 && selected < nLevels){
        Level l = levels[selected];
        if(changeVar) l.vslot = min(l.vslot + 0.01, 0.2);
        else l.slot = min(l.slot + 0.05, 1);
        println("slot", l.slot, l.vslot);
      }
    } else if(keyCode == DOWN) {
      if(selected >= 0 && selected < nLevels){
        Level l = levels[selected];
        if(changeVar) l.vslot = max(l.vslot - 0.01, -0.2);
        else l.slot = max(l.slot - 0.05, 0);
        println("slot", l.slot, l.vslot);
      }
    } else if(keyCode == LEFT) {
      if(selected >= 0 && selected < nLevels){
        Level l = levels[selected];
        if(changeVar) l.vpeg = max(l.vpeg - 0.01, -0.2);
        else l.peg = max(l.peg - 0.05, 0);
        println("peg", l.peg, l.vpeg);
      }
    } else if(keyCode == RIGHT) {
      if(selected >= 0 && selected < nLevels){
        Level l = levels[selected];
        if(changeVar) l.vpeg = min(l.vpeg + 0.01, 0.2);
        else l.peg = min(l.peg + 0.05, 1);
        println("peg", l.peg, l.vpeg);
      }
    }
  }*/
}

/*void mousePressed() {
  float r = 10;
  if( dist(mouseX, mouseY, root.a.x, root.a.y) < r ) dragging = 1;
  else if( dist(mouseX, mouseY, root.z.x, root.z.y) < r ) dragging = 2;
  else if( dist(mouseX, mouseY, root.p1.x, root.p1.y) < r ) dragging = 3;
  else if( dist(mouseX, mouseY, root.p2.x, root.p2.y) < r ) dragging = 4;
}

void mouseReleased() {
  dragging = -1;
}*/

String makeName() {
  String out = "s041_"+ str(year()).substring(2) + nf(month(), 2) + nf(day(), 2) +".";
  out += nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  //out += "_links"+ links.length +"_nodes"+ nid;

  return out;
}
