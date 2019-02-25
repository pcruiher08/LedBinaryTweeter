import gohai.simpletweet.*;
import java.math.*;
SimpleTweet simpletweet;

void setup(){
  size(500, 200);
  frameRate(1);
  simpletweet = new SimpleTweet(this);

  simpletweet.setOAuthConsumerKey("8Htu2FxcNcg2DlzMYTksa3WF6");
  simpletweet.setOAuthConsumerSecret("tqGeHPv8sk6IfLqV7b2kHAFGp9ZdiQLPOTVF5uh80lWYN1vK7J");
  simpletweet.setOAuthAccessToken("735237998-MhzepvvH1UY587w1QlnesaM6NYqRP3rIBBK9qxQj");
  simpletweet.setOAuthAccessTokenSecret("OqeIHCqgfXM7anFLolZgU4RNN8eAtqInEuUlsyTX4BFmf");
}

boolean[] bits = new boolean[10];
int suma = 0; 

void draw(){
  
  for(int i = 0; i<10; i++){
    bits[9-i] = (suma++ & (1 << i)) !=0 ;
  }
  
  background(0,255,100);
  noStroke();
  for(int j = 0; j<10; j++){
    if(bits[j])
      fill(0,100,255);
    else
      fill(255,255,255);
    ellipse(width/2-225+50*j, height/2,40,40);
  }

  

    //String tweet = simpletweet.tweetImage(get(),"");
    //println("Posted " + tweet);


}
