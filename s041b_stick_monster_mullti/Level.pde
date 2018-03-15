class Level {
  int ix, len;
  Stick[] sticks;
  color col;
  float slot, peg, rot;
  float vslot, vpeg, vrot;
  PVector size;
  boolean visible;
  Part part;
  
  Level(Part p, int _ix, int _len, PVector _size){
    part = p;
    ix = _ix;
    len = _len;
    size = _size;
    visible = true;
    
    sticks = new Stick[len];
    for(int i=0; i<len; i++){
      sticks[i] = new Stick(i, size);
      if(ix == 0) sticks[i].parent = part.root;
      else sticks[i].parent = part.levels[ix-1].sticks[i];
    }
  }
  
  void step() {
    for(int i=0; i<len; i++){
      sticks[i].slot = constrain(slot + vslot*i, 0, 1);
      sticks[i].peg = constrain(peg + vpeg*i, 0, 1);
      sticks[i].rot = ix == 0 ? rot + vrot*i : part.levels[ix-1].sticks[i].rot + rot + vrot*i;
      sticks[i].locate();
    }
    //println(ix, slot, peg, rot);
  }
  
  void paint() {
    if(visible || selected == ix) {
      //noFill();
      //stroke(col, 128);
      fill( selected == ix ? color(0, 0, 192, 128) : col );
      //fill(selected == ix ? color(0, 0, 192, 128) : 255 );
      //noStroke();
      stroke(64, 192);
      for(int i=0; i<len; i++){
        sticks[i].paint();
      }
    }
  }
  
  JSONObject getData() {
    JSONObject o = new JSONObject();
    o.setInt("ix", ix);
    o.setInt("len", len);
    o.setInt("col", col);
    o.setFloat("slot", slot);
    o.setFloat("vslot", vslot);
    o.setFloat("peg", peg);
    o.setFloat("vpeg", vpeg);
    o.setFloat("rot", rot);
    o.setFloat("vrot", vrot);
    o.setFloat("width", size.x);
    o.setFloat("length", size.y);
    
    return o;
  }
  
  void setData(JSONObject o) {
    //ix = o.getInt("ix");
    //len = o.getInt("len");
    //col = o.getInt("col");
    slot = o.getFloat("slot");
    vslot = o.getFloat("vslot");
    peg = o.getFloat("peg");
    vpeg = o.getFloat("vpeg");
    rot = o.getFloat("rot");
    vrot = o.getFloat("vrot");
    //size.x = o.getFloat("width");
    //size.y = o.getFloat("length");
  }
}
