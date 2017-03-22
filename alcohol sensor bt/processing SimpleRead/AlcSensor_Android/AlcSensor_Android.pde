import android.content.Intent;
import android.os.Bundle;
import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;


PFont fontMy;
boolean bReleased = true; //no permament sending when finger is tap
KetaiBluetooth bt;
boolean isConfiguring = true;
String info = "";
String newinfo ="";
int alc_level, save_data, number_of_drinks = 0;

boolean rectOver = false;
int rectX = 340;
int rectY = 105;
int rectWidth = 105;
int rectHeight = 70;
color rect_color = color(255);

KetaiList klist;
ArrayList devicesDiscovered = new ArrayList();

//********************************************************************
// The following code is required to enable bluetooth at startup.
//********************************************************************

void onCreate(Bundle savedInstanceState) {
 super.onCreate(savedInstanceState);
 bt = new KetaiBluetooth(this);
}

void onActivityResult(int requestCode, int resultCode, Intent data) {
 bt.onActivityResult(requestCode, resultCode, data);
}

void setup() {
 size(displayWidth, displayHeight);
 frameRate(10);
 orientation(PORTRAIT);
 background(0);
 
 //start listening for BT connections
 bt.start();
 //at app start select device…
 isConfiguring = true;
 //font size
 fontMy = createFont("SansSerif", 40);
 textFont(fontMy);
}

void draw() {
 //at app start select device
 if (isConfiguring)
 {
  background(78, 93, 75);
  klist = new KetaiList(this, bt.getPairedDeviceNames());
  isConfiguring = false;
 }
 else
 {
  background(0,50,0);
  update(mouseX, mouseY);

 //send with BT
  byte[] data = {};
  bt.broadcast(data);


  textSize(60);
  fill(255);
  text("Alcoholmeter", 70, 60);
  stroke(0);
  strokeWeight(4);
  fill(rect_color);
  rect(rectX, rectY, rectWidth, rectHeight);
  fill(0);
  textSize(40);
  text("SAVE", rectX+5, rectY+ rectHeight -20);
  fill(255);
  text("Drinks: ", 70, 250);
  text(number_of_drinks, 220, 250);
  ellipse(320, 235, 60, 60); //ellipse(x,y, width,height) 
  ellipse(400, 235, 60, 60); //ellipse(x,y, width,height) 
  fill(0);
  textSize(50);
  text("+", 305, 250);
  text("-", 385, 250);
  
  
  
  
  // Get rid of old data in the stream
  if( info.length() >= 5 ){
    
    CutString(info);  
  }
  
  // Paint and convert info String to Integer number and
  if(newinfo.length()>=2){
       
    newinfo = newinfo.substring(1,newinfo.length()-1);
    
    if(!(newinfo.length() == 1)){
      
       //print received data
      textSize(60);
      text(newinfo, 200, 160);
      alc_level = PApplet.parseInt(newinfo);
      println("newinfo: "+newinfo);
      println("newinfo length: " +newinfo.length());
      println("alc level int: " +alc_level);
      PaintEllipse(alc_level);
      if (rectOver) {
        text(save_data, 200,height/2);
      }
      
    } 
  }  
  
  
  
  
 }
}

void onKetaiListSelection(KetaiList klist) {
 String selection = klist.getSelection();
 bt.connectToDeviceByName(selection);
 //dispose of list for now
 klist = null;
}

//Call back method to manage data received
void onBluetoothDataEvent(String who, byte[] data) {
 if (isConfiguring)
 return;
 //received
 info += new String(data);
 //clean if string to long
 if(info.length() > 150)
 info = "";
}

void CutString(String info_){

 int i = info_.length();
 i = info_.lastIndexOf('\n', info_.length()-1);
 
 if(i == info.length()-1){
   
   i = info_.lastIndexOf('\n', info_.length()-2);
   newinfo = info_.substring(i,info_.length());
 
 }
}

public void PaintEllipse(int alc_level){
  
  color Color_ = color(0);
  
  for(int i = 0; i<3; i++){
    
    if(alc_level <150){
      
      Color_ = color(0, 250, 0);
    
    }else if (alc_level >= 150 && alc_level <= 300){
    
      Color_ = color(255, 255, 0);
  
    }else{
    
      Color_ = color(250, 0, 0); 
    }
  }

  fill(Color_);
  ellipse(100, 140, 80, 80); //ellipse(x,y, width,height) 
  println("width: "+width);
  println("heigth: "+height);
  
}



void update(int x, int y) {
  if(overRect(rectX, rectY, rectWidth, rectHeight) ) {
    rectOver = true;
  } else {
    rectOver = false;
  }
}


void mousePressed() {
  
  if (rectOver) {
    save_data = alc_level;
    rect_color = color(94,101,96);
  }
}

void mouseReleased() {
  
  rect_color = color(255);
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}


// Arduino+Bluetooth+Processing 
// Arduino-Android Bluetooth communication