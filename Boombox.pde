import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

/* 
Boombox 
Joris Meiklejohn
April 19 2018
Displays a stereo UI that plays songs and has rewind, pause, fast forward and volume functionality
*/

//Calls classes
Dial dial;
Minim minim;
VolumeControl volumeControl;
AudioPlayer[] players = new AudioPlayer[6];

//Global Variables
int i;
boolean paused;
int song = 0;

//PVectors for mouse and buttons
PVector mouse;

PVector button1Pos = new PVector(400, 390);
PVector button1Size = new PVector(80, 50);

PVector button2Pos = new PVector(800, 390);
PVector button2Size = new PVector(80, 50);

PVector button3Pos = new PVector(400, 460);
PVector button3Size = new PVector(80, 50);

PVector button4Pos = new PVector(800, 460);
PVector button4Size = new PVector(80, 50);

PVector button5Pos = new PVector(400, 530);
PVector button5Size = new PVector(80, 50);

PVector button6Pos = new PVector(800, 530);
PVector button6Size = new PVector(80, 50);

PVector buttonPaPos = new PVector(600, 530);
PVector buttonPaSize = new PVector(80, 50);

PVector buttonFfPos = new PVector(700, 530);
PVector buttonFfSize = new PVector(80, 50);

PVector buttonRePos = new PVector(500, 530);
PVector buttonReSize = new PVector(80, 50);

PVector songName = new PVector(600, 304);

void setup() {
  
  size(1200, 800);
  strokeWeight(2);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  textSize(20);
  minim = new Minim(this);
  //Loads song files in an array
  players = new AudioPlayer[6];
  for (i = 0; i < players.length; i++){
    players[i] = minim.loadFile((i+1) + ".mp3");
  }
  init();
}

//Draws the stereo's main shape
void drawStereo() {
  
  strokeWeight(3);
  stroke(0);
  background(255);
  fill(0);
  ellipse(330, 400, 500, 360);
  ellipse(870, 400, 500, 360);
  fill(100);
  ellipse(600, 240, 460, 200);
  fill(255);
  ellipse(600, 270, 400, 200);
  fill(0);
  rect(600, 400, 540, 360);
  //speakers
  fill(255);
  ellipse(205, 400, 210, 210);
  ellipse(995, 400, 210, 210);
  stroke(#FF0000);
  fill(0);
  ellipse(205, 400, 198, 198);
  ellipse(995, 400, 198, 198);
  noStroke();
  fill(0);
  ellipse(205, 400, 185, 185);
  ellipse(995, 400, 185, 185);
  fill(255);
  ellipse(205, 400, 56, 56);
  ellipse(995, 400, 56, 56);
  fill(0);
  stroke(#FF0000);
  ellipse(205, 400, 48, 48);
  ellipse(995, 400, 48, 48);
  //Display box
  stroke(255);
  fill(0);
  rect(600, 290, 480, 90);
  stroke(#FF0000);
  rect(600, 290, 472, 82);
}

void init(){
  
  //Sets the dial parameters
  mouse = new PVector(); 
  dial = new Dial(0, 10, 10, true);
  dial.setTitle("Volume");
  
  while(players[5]==null) {
    
  }
  
  volumeControl = new VolumeControl(players, dial); 
}

//Does the button detection for all the song playing buttons
void buttonDetector() {
  
  if ((abs(mouse.x - button1Pos.x) < button1Size.x/2 && abs(mouse.y - button1Pos.y) < button1Size.y/2 && mousePressed)){
    songChange();
    players[0].play();
    song = 1;
  }

  else if ((abs(mouse.x - button2Pos.x) < button2Size.x/2 && abs(mouse.y - button2Pos.y) < button2Size.y/2 && mousePressed)){
    songChange();
    players[1].play();
    song = 2;
  }

  else if ((abs(mouse.x - button3Pos.x) < button3Size.x/2 && abs(mouse.y - button3Pos.y) < button3Size.y/2 && mousePressed)){
    songChange();
    players[2].play();
    song = 3;
  }

  else if ((abs(mouse.x - button4Pos.x) < button4Size.x/2 && abs(mouse.y - button4Pos.y) < button4Size.y/2 && mousePressed)){
    songChange(); 
    players[3].play();
    song = 4;
  }
  
  else if ((abs(mouse.x - button5Pos.x) < button5Size.x/2 && abs(mouse.y - button5Pos.y) < button5Size.y/2 && mousePressed)){
    songChange();
    players[4].play();
    song = 5;
  }
  
  else if ((abs(mouse.x - button6Pos.x) < button6Size.x/2 && abs(mouse.y - button6Pos.y) < button6Size.y/2 && mousePressed)){
    songChange();
    players[5].play();
    song = 6;
  }
}

//Tracks when the mouse is released and detects whether the functionality buttons where pressed
public void mouseReleased(){
  
  
  if ((abs(mouse.x - buttonPaPos.x) < buttonPaSize.x/2 && abs(mouse.y - buttonPaPos.y) < buttonPaSize.y/2)){
    
    //Whether the boolean is true or false determines whether the song pauses or plays
    if(!paused){
      pause();
    }
    
    else if(paused){
      play(); 
    } 
  }
  
  else if ((abs(mouse.x - buttonFfPos.x) < buttonFfSize.x/2 && abs(mouse.y - buttonFfPos.y) < buttonFfSize.y/2)){
    
    fastForward();
  }
  
  else if ((abs(mouse.x - buttonRePos.x) < buttonReSize.x/2 && abs(mouse.y - buttonRePos.y) < buttonReSize.y/2)){
    
    rewind();
  }
}

//Checks whether or not a song is currently playing or not and sets the boolean
void checkPause() {

  if(players[0].isPlaying()||players[1].isPlaying()||players[2].isPlaying()||players[3].isPlaying()||players[4].isPlaying()||players[5].isPlaying()){
      paused = false;
  }
  
  else if(!players[0].isPlaying()&&!players[1].isPlaying()&&!players[2].isPlaying()&&!players[3].isPlaying()&&!players[4].isPlaying()&&!players[5].isPlaying()){
      paused = true;
  }
}

//When a new song begins playing, this function pauses the previous one and rewinds it 
void songChange() {
  
  if (players[0].isPlaying()) {
    players[0].pause();
    players[0].rewind();
  }
  
  else if (players[1].isPlaying()) {
    players[1].pause();
    players[1].rewind();
  }
  
  else if (players[2].isPlaying()) {
    players[2].pause();
    players[2].rewind();
  }
  
  else if (players[3].isPlaying()) {
    players[3].pause();
    players[3].rewind();
  }
  
  else if (players[4].isPlaying()) {
    players[4].pause();
    players[4].rewind();
  }
  
  else if (players[5].isPlaying()) {
    players[5].pause();
    players[5].rewind();
  }
}

//When the pause button is clicked and the boolean is false the current song is paused 
void pause() {
  
  if(players[0].isPlaying()) {
    players[0].pause();
  }
  
  else if(players[1].isPlaying()) {
    players[1].pause();
  }
  
  else if(players[2].isPlaying()) {
    players[2].pause();
  }
  
  else if(players[3].isPlaying()) {
    players[3].pause();
  }
  
  else if(players[4].isPlaying()) {
    players[4].pause();
  }
  
  else if(players[5].isPlaying()) {
    players[5].pause();
  }
}

//When a song is selected or unpaused this function plays the song
void play(){
  
    if(song==1){
      players[0].play();
    }
    else if(song==2){
      players[1].play();
    }
    else if(song==3){
      players[2].play();
    }
    else if(song==4){
      players[3].play();
    }
    else if(song==5){
      players[4].play();
    }
    else if(song==6){
      players[5].play();
    }
}

//This function pauses and rewinds the current song then plays the following song in the array
void fastForward() {
  
  if(players[0].isPlaying()) {
    songChange();
    players[1].play();
    song = 2;
  }
  else if(players[1].isPlaying()) {
    songChange();
    players[2].play();
    song = 3;
  }
  else if(players[2].isPlaying()) {
    songChange();
    players[3].play();
    song = 4;
  }
  else if(players[3].isPlaying()) {
    songChange();
    players[4].play();
    song = 5;
  }
  else if(players[4].isPlaying()) {
    songChange();
    players[5].play();
    song = 6;
  }
  else if(players[5].isPlaying()) {
    songChange();
    players[0].play();
    song = 1;
  }
}

//This funciton pauses and rewinds the current song that is playing and then plays the previous song in the array
void rewind() {
  
  if(players[0].isPlaying()) {
    songChange();
    players[5].play();
    song = 6;
  }
  else if(players[1].isPlaying()) {
    songChange();
    players[0].play();
    song = 1;
  }
  else if(players[2].isPlaying()) {
    songChange();
    players[1].play();
    song = 2;
  }
  else if(players[3].isPlaying()) {
    songChange();
    players[2].play();
    song = 3;
  }
  else if(players[4].isPlaying()) {
    songChange();
    players[3].play();
    song = 4;
  }
  else if(players[5].isPlaying()) {
    songChange();
    players[4].play();
    song = 5;
  }
}

//Function draws every button at its PVector position
void drawButtons() {
  
  fill(0);
  stroke(255);
  rect(button1Pos.x, button1Pos.y, button1Size.x, button1Size.y);
  rect(button2Pos.x, button2Pos.y, button2Size.x, button2Size.y);
  rect(button3Pos.x, button3Pos.y, button3Size.x, button3Size.y);
  rect(button4Pos.x, button4Pos.y, button4Size.x, button4Size.y);
  rect(button5Pos.x, button5Pos.y, button5Size.x, button5Size.y);
  rect(button6Pos.x, button6Pos.y, button6Size.x, button6Size.y);
  rect(buttonPaPos.x, buttonPaPos.y, buttonPaSize.x, buttonPaSize.y);
  rect(buttonFfPos.x, buttonFfPos.y, buttonFfSize.x, buttonFfSize.y);
  rect(buttonRePos.x, buttonRePos.y, buttonReSize.x, buttonReSize.y);
}

//This function draws the numbers and icons
void drawText() {
  
  fill(#FF0000);
  textSize(35);
  text("1", button1Pos.x, button1Pos.y - 3);
  text("2", button2Pos.x, button2Pos.y - 3);
  text("3", button3Pos.x, button3Pos.y - 3);
  text("4", button4Pos.x, button4Pos.y - 3);
  text("5", button5Pos.x, button5Pos.y - 3);
  text("6", button6Pos.x, button6Pos.y - 3);
  //Logo
  text("J", 490, 420);
  text("M", 705, 420);
  stroke(#FF0000);
  //Pause/play button
  line(buttonPaPos.x + 5, buttonPaPos.y - 10, buttonPaPos.x + 5, buttonPaPos.y + 10);
  line(buttonPaPos.x + 15, buttonPaPos.y - 10, buttonPaPos.x + 15, buttonPaPos.y + 10);
  triangle(buttonPaPos.x - 15, buttonPaPos.y - 8, buttonPaPos.x - 15, buttonPaPos.y + 8, buttonPaPos.x - 5, buttonPaPos.y);
  //Fast forward button
  triangle(buttonFfPos.x - 10, buttonFfPos.y - 8, buttonFfPos.x - 10, buttonFfPos.y + 8, buttonFfPos.x, buttonFfPos.y);
  triangle(buttonFfPos.x + 5, buttonFfPos.y - 8, buttonFfPos.x + 5, buttonFfPos.y + 8, buttonFfPos.x + 15, buttonFfPos.y);
  //Rewind button
  triangle(buttonRePos.x - 3, buttonRePos.y - 8, buttonRePos.x - 3, buttonRePos.y + 8, buttonRePos.x - 13, buttonRePos.y);
  triangle(buttonRePos.x + 12, buttonRePos.y - 8, buttonRePos.x + 12, buttonRePos.y + 8, buttonRePos.x + 2, buttonRePos.y);
  stroke(255);
  fill(255);
}

//This funciton displays the current songs name and singer
void songTitle() {
  
  textAlign(CENTER);
  
  if (song == 0) {
    text("Select a song", songName.x, songName.y);
  }
  
  else if (song == 1) {
    text("Despacito by Justin Bieber", songName.x, songName.y);
  }
  
  else if (song == 2) {
    text("Sorry by Justin Bieber", songName.x, songName.y);
  }
  
  else if (song == 3) {
    text("Havana by Camila Cabello", songName.x, songName.y);
  }
  
  else if (song == 4) {
    text("Wake me up by Avicii", songName.x, songName.y);
  }
  
  else if (song == 5) {
    text("Roar by Katy Perry", songName.x, songName.y);
  }
  
  else if (song == 6) {
    text("Dark Horse by Katy Perry", songName.x, songName.y);
  }
}

//Draw function
void draw() {
 
  checkPause();
  drawStereo();
  drawButtons();
  drawText();
  buttonDetector();
  songTitle();
  //Tracks mouse position while the program runs
  mouse = new PVector(mouseX, mouseY); 
  dial.update(mouse);
  volumeControl.update();
}
