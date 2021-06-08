String val;
char modo;

void setup()
{
  pinMode(3, OUTPUT);      // Fija el pin 3 como salida.
  Serial.begin(9600); // Start serial communication at 9600 bps
}

void loop()
{
  while(Serial.available()) { // If data is available to read,
    val = Serial.readStringUntil(' '); // read it and store it in val
    if (val == "I") {
      int puerto = Serial.readStringUntil(' ').toInt();
      float tono = Serial.readStringUntil('\n').toFloat();
      tone(puerto, tono);
    }
  }
}
