# Synaptron
EMG based hand gesture recognition device
A 3-channel EMG based prosthetic hand control system that processes muscle signals, classifies gestures, and converts them into servo motor commands for controlling a prosthetic hand.

The system implements a complete pipeline:
EMG Sensors → Signal Processing → Feature Extraction → Gesture Classification → Motor Commands → Prosthetic Hand
Project Overview

Human muscles generate small electrical signals when they contract. These signals are called Electromyography (EMG) signals.

This project captures EMG signals from three forearm muscle groups, processes them in MATLAB, and uses the processed signals to control a 5-finger prosthetic hand.

Instead of controlling each finger individually (which is difficult with surface EMG), the system uses muscle synergies to classify gestures such as:

Open Hand<br>
Close Fist<br>
Pinch Grip<br>

These gestures are then mapped to motor commands controlling the prosthetic fingers.

Hardware Components

Sensors<br>
3 × Surface EMG Sensors (Muscle Sensor v3)<br>
Microcontroller<br>
Arduino Uno / Raspberry Pi Pico / ESP32<br>
Actuators<br>
5 × Servo Motors<br>
Other Components<br>
EMG electrodes<br>
Power supply<br>
Prosthetic hand structure<br>

Sensor Placement
Three sensors are placed on different forearm muscle groups:
| Sensor   | Muscle Group         | Function             |
| -------- | -------------------- | -------------------- |
| Sensor 1 | Flexor compartment   | Close fingers (fist) |
| Sensor 2 | Extensor compartment | Open hand            |
| Sensor 3 | Thumb muscles        | Pinch grip           |

Methodology
Step 1: Signal Acquisition

EMG sensors capture analog voltages proportional to muscle activity. These signals are sampled at 1000 Hz using a microcontroller ADC and transmitted to MATLAB for processing. This sampling rate satisfies the Nyquist requirement for EMG signals (20–450 Hz).

Step 2: EMG Signal Preprocessing

Raw EMG signals are noisy and require preprocessing to extract meaningful information:

DC Offset Removal: Eliminates baseline drift.
Bandpass Filtering (20–200 Hz): Removes motion artifacts and high-frequency noise.
Notch Filtering (50 Hz, 100 Hz): Suppresses power-line interference.
Rectification: Converts bipolar signals into positive values.
RMS Envelope Extraction (~50 ms window): Produces a smooth representation of muscle activation.

The output consists of three EMG envelopes, each corresponding to a muscle group.

Step 3: Normalization

Signals are normalized to a 0–1 range to reduce variability across users and sessions, where 0 indicates relaxation and 1 indicates maximum contraction.

Step 4: Feature Extraction

EMG signals are processed using sliding windows (200 ms with overlap). Key features such as Mean Absolute Value (MAV) and Root Mean Square (RMS) are extracted to represent muscle activation intensity.

Step 5: Gesture Classification

A lightweight rule-based classifier identifies gestures based on dominant muscle activation:

Flexor activation → Close Fist
Extensor activation → Open Hand
Thumb activation → Pinch Grip

This approach is computationally efficient and suitable for real-time control.

Step 6: Gesture to Motor Mapping

Each detected gesture is mapped to predefined servo positions controlling the prosthetic fingers:

Open: All fingers extended
Fist: All fingers flexed
Pinch: Thumb and index flexed

Motor commands are represented in a normalized range (0–1).

Step 7: Communication

MATLAB streams motor commands to the microcontroller via serial communication, enabling real-time control.

Step 8: Actuation

The microcontroller converts incoming commands into servo angles (0–180°) to actuate the prosthetic hand and perform the desired gesture.
