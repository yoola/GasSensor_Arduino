import processing.serial.*;
import java.util.Collections;
import java.awt.Color;
import java.util.concurrent.ThreadLocalRandom;

Serial myPort1, myPort2, myPort3;  // Create object from Serial class
String inString1, inString2, inString3 = null;


User user1 = new User("H01", 1, 0);
User user2 = new User("H02", 2, 0);
User user3 = new User("H03", 3, 0);


void setup(){
  surface.setSize(400, 400);
  showSerialPorts();
  myPort1 = new Serial(this,Serial.list()[9], 9600);
  //myPort2 = new Serial(this,Serial.list()[7], 9600);
  //myPort3 = new Serial(this,Serial.list()[8], 9600);
}

void showSerialPorts() {
  for (int i = 0; i < Serial.list().length; i++) {
    println("[" + i + "] " + Serial.list()[i]);
  }
}

void serialEvent(Serial p) {
 inString1 = p.readStringUntil('\n');
 inString2 = p.readStringUntil('\n');
 inString3 = p.readStringUntil('\n');
}

// creating class User
// attributes: id, alc_level

public class User{
  
  String id_;
  Integer rank_, alc_level_;
  
  public User(String id, Integer rank, Integer alc_level){
    
    this.id_ = id;
    this.rank_ = rank;
    this.alc_level_ = alc_level;
    
  }
}

public void VaryValues(){
  
  if (inString1 != null) {  // If data is available,
    int value_ = int(inString1.substring(0,inString1.length()-1));
    user1.alc_level_ = value_;
  //  user2.alc_level_ = int(inString2.substring(0,inString2.length()-1));
  //  user3.alc_level_ = int(inString3.substring(0,inString3.length()-1;
  }

  long time_ = System.currentTimeMillis(); // a millisec is a thousand of a sec
  
  if((time_ % 122) == 0){
    
    //int rand1 = ThreadLocalRandom.current().nextInt(50, 450 + 1);
    int rand2 = ThreadLocalRandom.current().nextInt(50, 800);
    int rand3 = ThreadLocalRandom.current().nextInt(50, 800);
    //user1.alc_level_ = rand1;
    user2.alc_level_ = rand2;
    user3.alc_level_ = rand3;
  }
}

public User[] Ranking(User[] RankList){
 
  for(int i=0; i<2; i++){
    
    if(RankList[0].alc_level_ < RankList[1].alc_level_){
      
      User user1 = RankList[0];
    
      RankList[0] = RankList[1];
      RankList[1] = user1;      
    }
  
    if(RankList[1].alc_level_ < RankList[2].alc_level_){
    
      User user1 = RankList[1];
    
      RankList[1] = RankList[2];
      RankList[2] = user1;
    }
  }
  
  for(int i = 0; i<3; i++){
    RankList[i].rank_ = i+1; 
  }
  
  return RankList;
}


public void PaintRanking(User[] RankList){
  
  int y = 100;
  
  color[] ColorList = new color[3];
  
  for(int i = 0; i<3; i++){
    
    if(RankList[i].alc_level_ <150){
      
      ColorList[i] = color(0, 250, 0);
    
    }else if (RankList[i].alc_level_ >= 150 && RankList[i].alc_level_ <= 300){
    
      ColorList[i] = color(255, 255, 0);
  
    }else{
    
      ColorList[i] = color(250, 0, 0); 
    }
  }
  
  textSize(30);
  fill(color(250,0,0));
  text("Alcoholmeter", 90, 40); 
  textSize(14);
  for(int i=0; i<3; i++){
    
    fill(0);
    text(RankList[i].rank_+". "+RankList[i].id_+": "+RankList[i].alc_level_, 140, y); 
    fill(ColorList[i]/3);
    ellipse(250, y-5, 20, 20); //ellipse(x,y, width,height) 
    
    y+=50;
  }
}


void draw(){
  
  User[] RankList = new User[3];
  RankList[0] = user1;
  RankList[1] = user2;
  RankList[2] = user3;
 
  background(250); 
 
  VaryValues();
  RankList = Ranking(RankList);
  PaintRanking(RankList); 
  
}