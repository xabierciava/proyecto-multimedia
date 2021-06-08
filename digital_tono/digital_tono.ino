String s, dedo;
char modo;

void setup()
{
  pinMode(3, OUTPUT);      // Fija el pin 3 como salida.
  Serial.begin(9600); // Start serial communication at 9600 bps
}

void loop()
{
  while(Serial.available()) { // If data is available to read,
    s = Serial.readStringUntil('\n'); // read it and store it in val
    
    int puerto = s.substring(0, s.indexOf(',')).toInt();
    Serial.println(puerto);
    float tono = s.substring(s.indexOf(',')+1).toFloat();
    Serial.println(tono);
    tone(puerto, tono);
    
  }
}
