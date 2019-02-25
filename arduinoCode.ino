int SER_Pin = 8;
int RCLK_Pin = 9;
int SRCLK_Pin = 10;
volatile byte state = LOW;

const int inputPin = 2;
const int debounceDelay = 20;

#define number_of_74hc595s 2

#define numOfRegisterPins number_of_74hc595s * 8

boolean registers[numOfRegisterPins];

boolean debounce(int pin)
{
 boolean state;
 boolean previousState; 

 previousState = digitalRead(pin);
 for(int counter=0; counter < debounceDelay; counter++){
     delay(1);
     state = digitalRead(pin);  
     if( state != previousState){
        counter = 0; 
        previousState = state; 
     }
 }     
 return state;   
}


void setup(){
    pinMode(SER_Pin, OUTPUT);
    pinMode(RCLK_Pin, OUTPUT);
    pinMode(SRCLK_Pin, OUTPUT);
    clearRegisters();
    writeRegisters();
    Serial.begin(9600);
    pinMode(2, OUTPUT);
   //pinMode(interruptPin, INPUT_PULLUP);
   //attachInterrupt(digitalPinToInterrupt(interruptPin), changeState, CHANGE);
}

void clearRegisters(){
    for(int i= numOfRegisterPins-1; i>=0; i--)
        registers[i] = LOW;

}

void writeRegisters(){
    digitalWrite(RCLK_Pin, LOW);
    for(int i= numOfRegisterPins-1; i>=0; i--){
    digitalWrite(SRCLK_Pin, LOW);
    int val = registers[i];
    digitalWrite(SER_Pin, val);
    digitalWrite(SRCLK_Pin, HIGH);

}
    digitalWrite(RCLK_Pin, HIGH);

}

void setRegisterPin(int index, int value){
    registers[index] = value;
}



    bool bits[10];


unsigned long long suma = 0; 
void loop(){

     if(debounce(inputPin) == true){
   //  call your function to change values here 
   changeState();
 }

     for (int i = 9; i >= 0; i--) {
        bits[i] = (suma & (1 << i)) != 0;
    }

    //System.out.println(input + " = " + Arrays.toString(bits));
    //if(state) suma++;
    int button = digitalRead(2);
    Serial.println(button);
    clearRegisters();
    //setRegisterPin(suma%10, HIGH);
    for(int i=10; i>=0; i--){
        setRegisterPin(i, bits[i]?HIGH:LOW);
    }
    writeRegisters();
    delay(100);
}

void changeState(){
    state = !state;
    if(state)suma++;
}






