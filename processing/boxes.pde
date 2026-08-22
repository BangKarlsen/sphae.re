// TWEAK THESE THREE PARAMS
int numberOfBoxes = 23;
float rotationSpeed = 0.0001;
int blinkTimeInMillis = 40;


float rotationRadians = 0.0;
int blinkBoxIndex = 0;
int lastTime = 0;
color white;
color pink;
color black;

boolean isPaused = false;
void togglePause() {
    if (isPaused) {
        loop();
        isPaused = false;
    } else {
        noLoop();
        isPaused = true;
    }
}

void setupPalette() {
    colorMode(HSB, 360, 100, 100, 255);
    white = color(0, 0, 100);
    pink = color(328, 100, 100);    // RGB= 255,0,128
    black = color(0, 0, 0);    
}

void setup() {
    console.log('sketch size: ' + canvasSize.width + ' x ' + canvasSize.height);
    size(canvasSize.width, canvasSize.height, OPENGL);
    frameRate(60);
    setupPalette();
    background(white);
    noFill();
    smooth();
}

void draw() {
    updateTime();
    background(white);
    
    translate(width / 2.0, height / 2.0, 0);
    numberOfBoxes = (int)(23 * (width / 410.0) + 2); 

    rotationRadians += rotationSpeed;    
    for (int boxNo = 0; boxNo < numberOfBoxes; boxNo++) {
        pushMatrix();
        float shift = (float)boxSize / 250.0;
        float time = millis() / 1000;
        rotateX(0.005 * rotationRadians + shift * 4.3 * sin(time * 0.23) + 0.445 * 0.85 * time);
        rotateY(0.005 * rotationRadians + shift * 6.9 * sin(time * 0.03) + 0.045 * 0.65 * time);
        rotateZ(0.005 * rotationRadians + shift * 1.1 * sin(time) + 2.445 * 0.75 * time);
        if (blinkBoxIndex == boxNo) {
            stroke(pink);
        } else {
            stroke(black);
        }
        int boxSize = boxNo * 8;
        box(boxSize);
        popMatrix();
    }
}

void updateTime() {
    int currentTime = millis();
    if (currentTime > lastTime + blinkTimeInMillis) {
        updateBlink();
        lastTime = currentTime;
    }
}

void updateBlink() {
    blinkBoxIndex++;
    blinkBoxIndex %= numberOfBoxes;
}
