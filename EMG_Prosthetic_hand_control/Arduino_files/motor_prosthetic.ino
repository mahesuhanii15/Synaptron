#include <Servo.h>

const int SENSOR_PIN = A0;
const int NUM_SERVOS = 5;

// Define Pins
const int SERVO_PINS[NUM_SERVOS] = {10, 9, 6, 5, 3}; 

// Servo Objects
Servo fingers[NUM_SERVOS];

// Mappings based on your requirements:
// Order: 0:Pinky, 1:Ring, 2:Middle, 3:Index, 4:Thumb
int defaultPos[NUM_SERVOS]  = {90, 0,  90, 90, 90};
int contractPos[NUM_SERVOS] = {0,  90, 0,  0,  0};

bool isContracted = false; // Toggle state

void setup() {
  Serial.begin(115200);
  
  for (int i = 0; i < NUM_SERVOS; i++) {
    fingers[i].attach(SERVO_PINS[i]);
    fingers[i].write(defaultPos[i]); // Move to starting positions
  }
}

void loop() {
Filter your search...
Type:

All
Topic:

All


  // 1. Send EMG data to MATLAB
  int emgVal = analogRead(SENSOR_PIN);
  Serial.println(emgVal);

  // 2. Check for MATLAB command
  if (Serial.available() > 0) {
    char cmd = Serial.read();

    if (cmd == '1') {
      isContracted = true;
    }
    else if (cmd == '0') {
      isContracted = false;
    }
      
      for (int i = 0; i < NUM_SERVOS; i++) {
        if (isContracted) {
          fingers[i].write(contractPos[i]);
        } else {
          fingers[i].write(defaultPos[i]);
        }
      }
    }
  
  
  delay(1); // Small delay for servo stability
}