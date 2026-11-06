
---
layout: default
title: Project 1
---

# Project 1: Car Seat Belt Warning System

## 1. Introduction

The Car Seat Belt Warning System project focuses on designing, optimizing, and testing a digital control circuit that illuminates an alarm light based on automotive sensor inputs like ignition key status, seat pressure, and seat belt engagement. The objectives of the project are to be able to design a digital logic circuit for a car seat belt alarm using a traditional design approach and to execute the steps in the Xilinx design flow to implement the same circuit on FPGA.

## 2. Design

Door Warning Logic Block:
 - Inputs Received: Key in ignition (K=1) and Door open (D=0)
 - Function: Generates an internal door_warning signal if a driver leaves the car door open while the ignition key is inserted

Seat-Belt Warning Logic Block:
 - Inputs Received: Key in ignition (K=1), Person on seat (P=1), and Seat belt unfastened (S=0)
 - Function: Generates an internal belt_warning signal if a passenger is detected sitting on the seat without their belt buckled while the car is running

Output Priority & Interference Mixer:
 - Warning Light (L): Combines both internal blocks via an OR logic condition. The warning light turns on if either safety violation occurs
 - System Status Vector (STATUS): Uses conditional assignments to output a 2-bit diagnostic code (00 to 11) to your Basys3 LEDs, explicitly flagging exactly which safey hazard is active  

<img width="655" height="378" alt="image" src="https://github.com/user-attachments/assets/8d1e24de-0c05-44c2-af21-9ac3315f82c6" />


## 3. Code

Explain the key sections of your VHDL code and how they implement the required functionality.

Provide links to the relevant design files:

- **Design source:** [[Link]](https://github.com/tudorberea1-222/digital-systems-portfolio/blob/main/projects/project_1/car_warnlight.vhd)
- **Testbench:** [[Link]](https://github.com/tudorberea1-222/digital-systems-portfolio/blob/main/projects/project_1/car_warnlight_tb.vhd)
- **Constraints (XDC):** [[Link]](https://github.com/tudorberea1-222/digital-systems-portfolio/blob/main/projects/project_1/car_warnlight.xdc)

Include relevant code snippets where appropriate.

## 4. Simulation

Present simulation waveforms covering all required test scenarios.

For each scenario, explain:

<img width="1044" height="381" alt="image" src="https://github.com/user-attachments/assets/c0a1bdf7-0160-4590-98ea-79023fec60de" />


- What was tested : The entire combinatorial logic function for both the door hazard (K = 1, D = 0) and seat belt hazard. 
- Expected behavior : The warning light should trigger HIGH only during the door-open violation windows and the unbuckled belt window. It should stay LOW for all other safe configurations. 
- Observed results : The output waveform matches the logic perfectly, showing a solid HIGH block from 200-400 ns and a single isolated pulse from 700-750 ns.
- Any discrepancies and their resolution : None. 

## 5. Hardware


- **Elaborated design:**
  
<img width="1191" height="519" alt="image" src="https://github.com/user-attachments/assets/a701a95c-9f72-41ce-8232-947e64ebd752" />

Top Branch: Inverts door_closed and ANDs it with key_in to catch an open door hazard
Bottom Branch: ANDS key_in, seat_pressure, and an inverted seat_belt_closed to catch an unbuckled passenger hazard
Output: Feeds both hazard paths into a final OR gate to drive the master warning light (light_en)
  
- **Synthesized design:**

<img width="458" height="459" alt="image" src="https://github.com/user-attachments/assets/cc022d2b-34ec-4579-9bff-fb00e86f832e" />


  
- **Implementation:**

<img width="448" height="304" alt="image" src="https://github.com/user-attachments/assets/02933dfa-4624-4d76-b1d6-7a5e4ed7d4c3" />


- **Resource utilization:**

<img width="821" height="257" alt="image" src="https://github.com/user-attachments/assets/9992bfca-ed48-4c9f-b40e-a2480b4210f0" />


- **Hardware testing:** Observed behaviour on the Basys3 board compared with expected functionality

Include screenshots, tables, or photographs where appropriate.

## 6. Reflection

Technical Challenges & Resolutions:
 - 
What I Learned:
 -
Connection to Theory:
 -
