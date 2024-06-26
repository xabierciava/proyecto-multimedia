/*
importar libreria sound
aumentar espacio ram a 4 GB en preferencias
no hacer caso a la nota de jsyn que aparece al ejecutar, no es nada
el color mode está en hsb (usar adobeColor)
para la interfaz https://web.media.mit.edu/~cassiano/projects/cards_ui/index.html#input-text
*/

import processing.serial.*;
import processing.sound.*;

SoundFile file;
PImage img;
Serial myPort;

//ParametrosFondo
int pLifeTime = 150;
ParticleCollection particleCollection;

float bcMaxRadius;
float bcCurrentRadius;

//ParametrosGuante
int xGuante;
int yGuante;
final int anchoGuante=570;
final int altoGuante=988;

//Parametros circulos
boolean flagTrans;
float transparenciaCirculos=100.0;
color colorCirculos;
color colorCirculosVerde;
final int circSize = 90;

//flagsDedos
//pulgar
boolean is1=false;
//Indice
boolean is2=false;
//Corazon
boolean is3=false;
//Anular
boolean is4=false;
//Meñique
boolean is5=false;
//flagCard
boolean isCard=false;


//flagDedoActual
int actual=-1;

//card
//DragDropCard ddc = new DragDropCard();
String title;
final int cardW=600,cardH=200;
int cardX,cardY;


void setup() {
  fullScreen();
  inicializarFondo();
  img = loadImage("guanteBienGirao.png");
  img.resize(anchoGuante, altoGuante);
  xGuante=(width/2)-(anchoGuante/2);
  yGuante=(height/2)-(altoGuante/2);
  // String portName = Serial.list()[0];  // Arduino de Xabi
  String portName = Serial.list()[2];     // Arduino de Ander 
  println(portName);
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  dibujarFondo();
  gestionarTransparencia();
  //Dibujo el guante
  image(img, xGuante, yGuante);
  //Dibujo los circulos
  dibujarCirculos();
  //Dibujamos card (de haberla)
  dibujarCard();  
}

public void gestionarTransparencia(){
  if(transparenciaCirculos<=40.0){
    flagTrans=true;
  }
  if(transparenciaCirculos>=100.0){
    flagTrans=false;
  }
  if(flagTrans){
    transparenciaCirculos+=0.2;
  }else{
    transparenciaCirculos-=0.2;
  }
}

public void dibujarCirculos(){
  PVector centroPulgar = new PVector(xGuante+(anchoGuante*0.068),yGuante+(altoGuante*0.32));
  PVector centroIndice = new PVector(xGuante+(anchoGuante*0.41),yGuante+(altoGuante*0.04));
  PVector centroCorazon = new PVector(xGuante+(anchoGuante*0.61),yGuante+(altoGuante*0.02));
  PVector centroAnular = new PVector(xGuante+(anchoGuante*0.82),yGuante+(altoGuante*0.07));
  PVector centroMenique = new PVector(xGuante+(anchoGuante*0.95),yGuante+(altoGuante*0.18));
  
  //Dibujo las circunferencias
  noFill();
  colorCirculos=color(191,95,99,transparenciaCirculos);
  colorCirculosVerde=color(138,63,100,transparenciaCirculos);
  strokeWeight(10);
  stroke(colorCirculos);
  if(actual==1){
    stroke(colorCirculosVerde);
  }else{
    stroke(colorCirculos);
  }
  ellipse(centroPulgar.x,centroPulgar.y,circSize,circSize);
  if(actual==2){
    stroke(colorCirculosVerde);
  }else{
    stroke(colorCirculos);
  }
  ellipse(centroIndice.x,centroIndice.y,circSize,circSize);
  if(actual==3){
    stroke(colorCirculosVerde);
  }else{
    stroke(colorCirculos);
  }
  ellipse(centroCorazon.x,centroCorazon.y,circSize,circSize);
  if(actual==4){
    stroke(colorCirculosVerde);
  }else{
    stroke(colorCirculos);
  }
  ellipse(centroAnular.x,centroAnular.y,circSize,circSize);
  if(actual==5){
    stroke(colorCirculosVerde);
  }else{
    stroke(colorCirculos);
  }
  ellipse(centroMenique.x,centroMenique.y,circSize,circSize);
  
  strokeWeight(1);
  
  //Dibujo los circulos internos si está el ratón
  float distPulgar = dist(centroPulgar.x,centroPulgar.y,mouseX,mouseY);
  float distIndice = dist(centroIndice.x,centroIndice.y,mouseX,mouseY);
  float distCorazon = dist(centroCorazon.x,centroCorazon.y,mouseX,mouseY);
  float distAnular = dist(centroAnular.x,centroAnular.y,mouseX,mouseY);
  float distMenique = dist(centroMenique.x,centroMenique.y,mouseX,mouseY);
  int margen=10;
  noStroke();
  fill(color(0,0,75,transparenciaCirculos));
  
  is1=distPulgar<circSize/2;
  is2=distIndice<circSize/2;
  is3=distCorazon<circSize/2;
  is4=distAnular<circSize/2;
  is5=distMenique<circSize/2;
  
  if(is1){
    ellipse(centroPulgar.x,centroPulgar.y,circSize-margen,circSize-margen);
  }else if(is2){
    ellipse(centroIndice.x,centroIndice.y,circSize-margen,circSize-margen);
  }else if(is3){
    ellipse(centroCorazon.x,centroCorazon.y,circSize-margen,circSize-margen);
  }else if(is4){
    ellipse(centroAnular.x,centroAnular.y,circSize-margen,circSize-margen);
  }else if(is5){
    ellipse(centroMenique.x,centroMenique.y,circSize-margen,circSize-margen);
  }
}

void mouseClicked(){
  checkIfCard();
  if(is1){
    actual=1;
  }else if(is2){
    actual=2;
  }else if(is3){
    actual=3;
  }else if(is4){
    actual=4;
  }else if(is5){
    actual=5;
  }else if(isCard){
    //actual no cambia
  }else{
    actual=-1;
  }
  
  /*if (actual == 2) {
    float tono = calcularTono();
    myPort.write("3," + Float.toString(tono) + "\n");
  }
  
  if (actual == 3) {
    float tono = calcularTono();
    myPort.write("5," + Float.toString(tono) + "\n");
  }
  
  if (actual == 4) {
    float tono = calcularTono();
    myPort.write("6," + Float.toString(tono) + "\n");
  }
  
  if (actual == 5) {
    float tono = calcularTono();
    myPort.write("9," + Float.toString(tono) + "\n");
  }*/
}

public void checkIfCard(){
  if(mouseX>cardX && mouseY>cardY && mouseX<cardX+cardW && mouseY<cardY+cardH){
    isCard=true;
  }else{
    isCard=false;
  }

}

boolean tierra1=true,tierra2=false,tierra3=false,tierra4=false,tierra5=false;

public void dibujarCard(){
  cardX=width/2-(cardW/2);
  cardY=height*3/4;
  
  switch(actual){
    case 1:
      title="pulgar";
      cardDedo();
      break;
    case 2:
      title="indice";
      cardDedo();
      break;
    case 3:
      title="corazon";
      cardDedo();
      break;
    case 4:
      title="anular";
      cardDedo();
      break;
    case 5:
      title="chikito";
      cardDedo();
      break;
    default:
      title="";
      break;
  }
}

String avisoPulgar= "Este dedo actua como tierra";
void cardPulgar(){
  beginCard(title,cardX,cardY,cardW,cardH);
  fill(color(255));
  textSize(30);
  text(avisoPulgar,card_x+textWidth(avisoPulgar)/2+cardW/6,card_y+cardH/3);
  endCard();
}

int xInicial=10;
int espaciado = 120;
int interlineado = 40;

void cardDedo(){
  beginCard(title,cardX,cardY,cardW,cardH+20);
  
  if (Button("DO", cardX+xInicial, cardY+50))
    myPort.write(actual+","+523.26+"\n");
  if (Button("DO#", cardX+xInicial+espaciado, cardY+50))
    myPort.write(actual+","+554.37+"\n");
  if(Button("RE", cardX+xInicial+espaciado*2, cardY+50))
    myPort.write(actual+","+ 587.33+"\n");
  if(Button("RE#", cardX+xInicial+espaciado*3, cardY+50))
    myPort.write(actual+","+622.25+"\n");
  if(Button("MI", cardX+xInicial+espaciado*4, cardY+50))
    myPort.write(actual+","+659.26+"\n");
  if(Button("FA", cardX+xInicial, cardY+50+interlineado))
    myPort.write(actual+","+698.46+"\n");
  if(Button("FA#", cardX+xInicial+espaciado, cardY+50+interlineado))
    myPort.write(actual+","+739.99+"\n");
  if(Button("SOL", cardX+xInicial+espaciado*2, cardY+50+interlineado))
    myPort.write(actual+","+783.99+"\n");
  if(Button("SOL#", cardX+xInicial+espaciado*3, cardY+50+interlineado))
    myPort.write(actual+","+830.61+"\n");
  if(Button("LA", cardX+xInicial+espaciado*4, cardY+50+interlineado))
    myPort.write(actual+","+880.00+"\n");
  if(Button("LA#", cardX+xInicial, cardY+50+interlineado*2))
    myPort.write(actual+","+932.33+"\n");
  if(Button("SI", cardX+xInicial+espaciado, cardY+50+interlineado*2))
    myPort.write(actual+","+987.77+"\n");
  if(Button("DO (agudo)", cardX+xInicial+espaciado*2, cardY+50+interlineado*2))
    myPort.write(actual+","+1046.50+"\n");
  if(Button("DO# (agudo)", cardX+xInicial+espaciado*3, cardY+50+interlineado*2))
    myPort.write(actual+","+1108.73+"\n");
  if(Button("RE (agudo)", cardX+xInicial+espaciado*4, cardY+50+interlineado*2))
    myPort.write(actual+","+1174.66+"\n");
  if(Button("RE# (agudo)", cardX+xInicial, cardY+50+interlineado*3))
    myPort.write(actual+","+1244.51+"\n");
  if(Button("MI (agudo)", cardX+xInicial+espaciado, cardY+50+interlineado*3))
    myPort.write(actual+","+1318.51+"\n");
  if(Button("FA (agudo)", cardX+xInicial+espaciado*2, cardY+50+interlineado*3))
    myPort.write(actual+","+1396.91+"\n");
  if(Button("FA# (agudo)", cardX+xInicial+espaciado*3, cardY+50+interlineado*3))
    myPort.write(actual+","+1479.98+"\n");
  if(Button("PAUSA", cardX+xInicial+espaciado*4, cardY+50+interlineado*3))
    myPort.write(actual+","+30000+"\n");
  
  endCard();
}

void serialEvent(Serial p) {
  try {
    // get message till line break (ASCII > 13)
    String message = p.readStringUntil(13);
    // just if there is data
    if (message != null) {
      println("message received: "+trim(message));
    }
  }
  catch (Exception e) {
  }
}






























void inicializarFondo(){
  background(10);
  noFill();
  colorMode(HSB, 360, 100, 100, 100);
  particleCollection = new ParticleCollection();
  file = new SoundFile(this, "ambiente.wav");
  file.loop();
}

void dibujarFondo(){
  background(10);
  particleCollection.update();
  particleCollection.addParticles(int(random(3,5)), random(width), random(height));
}




class Particle {
  PVector location;
  PVector direction;
  int lifeTime;
  int age;
  float speed;
  ParticleCollection collection;
  int generation;
  ArrayList<Particle> children;

  Particle(ParticleCollection pc, float x, float y) {
    this.age = 1;
    this.generation = 0;
    this.collection = pc;
    this.lifeTime = pLifeTime + int(random(-pLifeTime * 0.5, pLifeTime * 0.5));
    this.speed = random(0.5, 2);
    this.location = new PVector(x, y);
    this.direction = PVector.random2D();
    this.children = new ArrayList<Particle>();
  }

  void update() {
    this.location.add(PVector.mult(this.direction, this.speed));
    this.age++;

    if (generation != 1 && random(1000) > 999) this.spawnParticle();

    if (this.age > this.lifeTime) this.collection.removeParticle(this);
  }

  void spawnParticle() {
    int nrOfChildren = 3;
    for (int i = 0; i < nrOfChildren; i++) {
      Particle p = collection.addParticle(this.location.x, this.location.y);
      p.generation = this.generation + 1;
      PVector directionMod = PVector.random2D();
      p.direction = this.direction.get();
      directionMod.mult(0.3);
      p.direction.add(directionMod);
      p.direction.normalize();
      this.children.add(p);
    }
  }

  void display() {
    float lifeProgress = float(this.age) / float(this.lifeTime);
    float alpha = 100 - 100 * lifeProgress;
    color c = color(100 + 100 * lifeProgress, 100, 40 + lifeProgress * 300, alpha);
    stroke(c);
    fill(c);

    point(this.location.x, this.location.y);
    if (this.children.size() > 0) this.displayChildPolygons();

  }
  
  void displayChildPolygons() {
      PVector vector = this.location;
      beginShape();

      for (Particle p : this.children) {
        vertex(vector.x, vector.y);
        vector = p.location;
      }

      endShape(CLOSE);
  }
}

class ParticleCollection {
  ArrayList<Particle> particles;
  ArrayList<Particle> removedParticles;
  ArrayList<Particle> newParticles;

  ParticleCollection() {
    this.particles = new ArrayList<Particle>();
    this.newParticles = new ArrayList<Particle>();
    this.removedParticles = new ArrayList<Particle>();
  }

  void update() {
    for (Particle p : particles) {
      p.update();
      p.display();
    }
    this.addNewParticles();
    this.purgeParticles();
  }

  Particle addParticle(float x, float y) {
    Particle p = new Particle(this, x, y);
    this.newParticles.add(p);
    return p;
  }
  
  void addParticles(int nrOfParticles, float x, float y) {
    for (int i = 0; i < nrOfParticles; i++) {
      this.addParticle(x, y);
    }
  }

  void addNewParticles() {
    for (Particle p : this.newParticles) {
      this.particles.add(p);
    }
    this.newParticles.clear();
    
  }

  void purgeParticles() {
    for (Particle p : this.removedParticles) {
      int pKey = this.particles.indexOf(p);
      this.particles.remove(pKey);
    }
    this.removedParticles.clear();
  }

  void removeParticle(Particle p) {
    this.removedParticles.add(p);
  }
}
