# GasSensor_Arduino

This repository contains the code for a Arduino version on the computer:
 - run the code in the folder alcohol_sensor/processing/AlcSensor_PC/AlcSensor_PC.pde
 
 and the code for an Android version:
 
 - run the code in the folder alcohol_sensor/processing/AlcSensor_Android/AlcSensor_Android.pde
 
 When running the Android version make sure:
 
 - you are in Andriod mode in the Processing IDE when debugging it
- to select the right number of the arduino usb device in myPort1 = new Serial(this,Serial.list()[7], 9600); (here it has number 7)
  => if you don't know the number, run it once, so you find the number listed in the console 
  
In the menu: 
- go to Android-> sketch permission -> select BLUETOOTH and BLUETOOTH_ADMIN 
- go to Sketck -> import library -> add library -> select Ketai library
