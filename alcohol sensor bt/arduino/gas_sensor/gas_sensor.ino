#define Aout A0
int ledPin = 13;

int val = 0;
int yellow = 10;
int green = 11;
int red = 6;
char state;
void setup() {
  // put your setup code here, to run once:

Serial.begin(9600);

pinMode(yellow,OUTPUT);
pinMode(green,OUTPUT);
pinMode(red,OUTPUT);
pinMode(ledPin,OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
val=analogRead(Aout);
Serial.print(val);
Serial.print("\n");


if(val<300){
  
  analogWrite(green,0);
  delay(800);
  analogWrite(green,50);
  delay(800);
  analogWrite(yellow,0);
  analogWrite(red,0);
  
}else if(val>=300 && val<= 400){
  
  analogWrite(yellow,100);
  analogWrite(green,100);
  delay(600);
  analogWrite(yellow,0);
  analogWrite(green,0);
  delay(600);
  analogWrite(red,0);
  
}else{
  analogWrite(red,255);
  analogWrite(green,255);
  analogWrite(yellow,255);
  delay(300);
  analogWrite(red,0);
  analogWrite(green,0);
  analogWrite(yellow,0);
  delay(300);
  
}
delay(50);

/*
if (Serial.available()>0){
  state=Serial.read();
  }

if (state=='0'){
  digitalWrite(ledPin,HIGH);}
  
else if(state=='1'){
  digitalWrite(ledPin,LOW);
}
 
 */

}
