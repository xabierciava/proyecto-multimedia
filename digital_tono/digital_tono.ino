char val;

void setup()
{
  pinMode(3, OUTPUT);      // Fija el pin 3 como salida.
  Serial.begin(9600); // Start serial communication at 9600 bps
}

void loop()
{
  while(Serial.available()) { // If data is available to read,
    val = Serial.read(); // read it and store it in val
  }
  
  if (val == 'I'){
    Serial.println(val);
    int c;
    while (Serial.available()){
      c = Serial.read();
      //Serial.println(c);
    }
    
  }
  if(val=='A'){
    tone(3,523.25);
  }
  if(val=='B'){
    tone(3,554.37);
  }
  if(val=='C'){
    tone(3,587.33);
  }
  if(val=='D'){
    tone(3,622.25);
  }
  if(val=='E'){
    tone(3,659.26);
  }
  if(val=='F'){
    tone(3,698.46);
  }
  if(val=='G'){
    tone(3,739.99);
  }
  if(val=='H'){
    tone(3,783.99);
  }
  if(val=='I'){
    tone(3,830.61);
  }
  if(val=='J'){
    tone(3,880.00);
  }
  if(val=='K'){
    tone(3,932.33);
  }
  if(val=='L'){
    tone(3,987.77);
  }
  if(val=='M'){
    tone(3,1046.50);
  }
  if(val=='N'){
    tone(3,1108.73);
  }
  if(val=='O'){
    tone(3,1174.66);
  }
  if(val=='P'){
    tone(3,1244.51);
  }
  if(val=='Q'){
    tone(3,1318.51);
  }
  if(val=='R'){
    tone(3,1396.91);
  }
  if(val=='S'){
    tone(3,1479.98);
  }
  if(val=='T'){
    tone(3,30000);
  }
}
