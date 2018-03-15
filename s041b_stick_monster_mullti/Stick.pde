class Stick {
  int id;
  Stick parent;
  PVector a, z, base, prev;
  float slot, peg, rot;
  PVector size;
  Level level;
  
  Stick(int _id, PVector _size){
    id = _id;
    size = _size;
    //println("stick", id, size);
    
    a = new PVector();
    z = new PVector();
    base = new PVector();
    prev = new PVector();
  }
  
  PVector getPos(float p){
   return PVector.lerp(a, z, p); 
  }
  
  void locate() {
    base = parent.getPos(slot);
    //PVector ang = PVector.fromAngle(rot);
    prev.set(z);
        
    a.x = base.x - size.y * (1-peg) * cos(rot);
    a.y = base.y - size.y * (1-peg) * sin(rot);
    z.x = base.x + size.y * peg * cos(rot);
    z.y = base.y + size.y * peg * sin(rot);

  }
  
  void paint() {
    //line(a.x, a.y, z.x, z.y);
    
    //ellipse(base.x, base.y, 8, 8);
    pushMatrix();
    translate((a.x+z.x)/2, (a.y+z.y)/2);
    rotate(rot);
    rect(0, 0, size.y, size.x);
    popMatrix();
    
    //line(prev.x, prev.y, z.x, z.y);
  }
  
}

class RootStick extends Stick {
  PVector p1, p2;
  
  RootStick(PVector _a, PVector _z) {
    super(0, null);
    a.set(_a);
    z.set(_z);
    p1 = new PVector();
    p2 = new PVector();
    p1.set(PVector.lerp(a, z, 0.25));
    p2.set(PVector.lerp(a, z, 0.75));
  }
  
  PVector getPos(float p){
   PVector out = new PVector();
   out.x = bezierPoint(a.x, p1.x, p2.x, z.x, p);
   out.y = bezierPoint(a.y, p1.y, p2.y, z.y, p);
   return out;
  }
  
  void paint() {
    /*pushMatrix();
    translate(width/2, height/2);
    rotate(baseRot);
    translate(-width/2, -height/2);*/
      
    strokeWeight(1);
    stroke(255, 0, 0, 128);
    noFill();
    rect(a.x, a.y, 6, 6);
    rect(z.x, z.y, 6, 6);
    ellipse(p1.x, p1.y, 6, 6);
    ellipse(p2.x, p2.y, 6, 6);
    bezier(a.x, a.y, p1.x, p1.y, p2.x, p2.y, z.x, z.y);
    
    //popMatrix();
  }
  
  /*JSONObject getData() {
    JSONObject r = new JSONObject();
    r.setFloat("a.x", root.a.x);
    r.setFloat("a.y", root.a.y);
    r.setFloat("z.x", root.z.x);
    r.setFloat("z.y", root.z.y);
    r.setFloat("p1.x", root.p1.x);
    r.setFloat("p1.y", root.p1.y);
    r.setFloat("p2.x", root.p2.x);
    r.setFloat("p2.y", root.p2.y);
    
    return r;
  }
  
  void setData(JSONObject r) {
    a.x = r.getFloat("a.x");
    a.y = r.getFloat("a.y");
    z.x = r.getFloat("z.x");
    z.y = r.getFloat("z.y");
    p1.x = r.getFloat("p1.x");
    p1.y = r.getFloat("p1.y");
    p2.x = r.getFloat("p2.x");
    p2.y = r.getFloat("p2.y");
  }*/
}
