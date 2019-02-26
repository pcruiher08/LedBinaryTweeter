import gohai.simpletweet.*;
import java.math.*;
SimpleTweet simpletweet;
import processing.serial.*;
Serial myPort; 

void setup(){
  size(500, 200);
  frameRate(1);
  simpletweet = new SimpleTweet(this);
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);

  simpletweet.setOAuthConsumerKey("5fnwFIsXywz3x29VP6wSMlLtm");
  simpletweet.setOAuthConsumerSecret("4FJUbUop1xPc5Rohok77omD7Ah3HzTQ4eqMppRQdvW5bSGfpXq");
  simpletweet.setOAuthAccessToken("735237998-MhzepvvH1UY587w1QlnesaM6NYqRP3rIBBK9qxQj");
  simpletweet.setOAuthAccessTokenSecret("OqeIHCqgfXM7anFLolZgU4RNN8eAtqInEuUlsyTX4BFmf");
}

boolean[] bits = new boolean[10];
int suma = 0; 
int sumaAnterior = 0; 
boolean flagToTweet = false; 
void draw(){
  flagToTweet = false;
  while(myPort.available()>0){
    sumaAnterior = suma;
    suma = myPort.read();
    if(suma!=sumaAnterior) flagToTweet = true; else flagToTweet = false;
    println("suma: " + suma + ", suma anterior: "+ sumaAnterior);
  }
  
  for(int i = 0; i<10; i++){
    bits[9-i] = (suma & (1 << i)) !=0 ;
  }
  
  println(suma);
  background(0,255,100);
  noStroke();
  for(int j = 0; j<10; j++){
    if(bits[j])
      fill(0,100,255);
    else
      fill(255,255,255);
    ellipse(width/2-225+50*j, height/2,40,40);
  }

  
  if(flagToTweet){
    String tweet = simpletweet.tweetImage(get(),"LED Array " + suma + " \n #ILoveCircuits");
    println("Posted " + tweet);
  }


}
