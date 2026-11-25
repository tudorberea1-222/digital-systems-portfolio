# Week 1 – System Setup and Environment Verification

[← Project 5 Main Page](../project5.md)

## 1. Introduction

During week 1, our team focused on configuring the software development environment, establishing a reliable programming connection with our Raspberry Pi Pico (RP2040) microcontroller, and verifying basic hardware functionality. The purpose of these intiial setup tests was to confirm that our toolchain can complile, upload, and execute code on the board without errors before integrating external I2S audio peripherals and real time tremolo DSP algorithms in upcoming phases.

## 2. Design Summary

- We installed and configured VS Code with PlatformIO on C++ 
- The Raspberry Pi Pico was connected to the host computer via USB in BOOTSEL mode for inital firmware flashing, confirming proper COM/serial port recognition
- To test GPIO control and the compliation pipeline, we developed a basic blink program targeting the Pico's onboard LED. 

## 3. Testing and Results

- The LED blink sketc compiled with zero errors and uploaded cleanly to the Raspberry Pi Pico over USB
- Upon execution, the onboard green LED blinked continuously at a steady 1 Hz rate, confirming that the microcontroller was powered properly, running at the expected clock speed, and executing flashed firmware reliably.

## 4. Challenges and Solutions

Challenge: We couldn't upload the code on Visual Studio due to not having the right packages and it being locked by the Humber computers
Solution: Just for this week we tested the board on the Arduino IDE

## 5. Individual Contributions

For each group member, state the specific tasks completed and provide a link or other evidence of their contribution. Use short bullet points; no table is required.

- **[Matieu]:** : Configured the development environment, installed RP 2040 board packages, and verified USB flashing.
- **[Tudor]:** : Wrote, uploaded, and tested the onboard LED blink verification program on the Raspberry Pi Pico.


## 6. Next Steps

- Install and configure the Pico with the applicable libraries and add-ons
- Wire the I2S MEMS microphone (BCLK, WS, DOUT) and the MAX98357A Class-D amplifier/speaker (BCLK, WS, DIN, SPK+, SPK-) to the Raspberry Pi Pico using the GPIO pins defined in class
