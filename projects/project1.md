
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

The VHDL code defines an entity with four sensor input ports (door_closed, key_in, seat_pressure, seat_belt_closed) and one output port (light_en) mapped via dataflow logic to trigger the warning light when a safety hazard is detected. The complete setup connects this hardware behavior to a binary sweep testbench and routes the signals directly to physical Basys3 FPGA board switches and LEDs

- **Design source:** [[Link]](https://github.com/tudorberea1-222/digital-systems-portfolio/blob/main/projects/project_1/car_warnlight.vhd)
- **Testbench:** [[Link]](https://github.com/tudorberea1-222/digital-systems-portfolio/blob/main/projects/project_1/car_warnlight_tb.vhd)
- **Constraints (XDC):** [[Link]](https://github.com/tudorberea1-222/digital-systems-portfolio/blob/main/projects/project_1/car_warnlight.xdc)



## 4. Simulation

<img width="1044" height="381" alt="image" src="https://github.com/user-attachments/assets/c0a1bdf7-0160-4590-98ea-79023fec60de" />


- What was tested : The entire combinatorial logic function for both the door hazard (K = 1, D = 0) and seat belt hazard. 
- Expected behavior : The warning light should trigger HIGH only during the door-open violation windows and the unbuckled belt window. It should stay LOW for all other safe configurations. 
- Observed results : The output waveform matches the logic perfectly, showing a solid HIGH block from 200-400 ns and a single isolated pulse from 700-750 ns.
- Any discrepancies and their resolution : None. 

## 5. Hardware


- **Elaborated design:**
  
<img width="1191" height="519" alt="image" src="https://github.com/user-attachments/assets/a701a95c-9f72-41ce-8232-947e64ebd752" />

 - Top Branch: Inverts door_closed and ANDs it with key_in to catch an open door hazard
 - Bottom Branch: ANDS key_in, seat_pressure, and an inverted seat_belt_closed to catch an unbuckled passenger hazard
 - Output: Feeds both hazard paths into a final OR gate to drive the master warning light (light_en)
  
- **Synthesized design:**

<img width="458" height="459" alt="image" src="https://github.com/user-attachments/assets/cc022d2b-34ec-4579-9bff-fb00e86f832e" />

 -I/O Buffers: It illustrates the mapping of system ports to specific physical silison input pads
 -Hardware Routing: The block highlights primitive cells X0Y0 and X0Y1 assigned to package pins A12 and B13 to interface the digital logic directly with external circuitry
  
- **Implementation:**

<img width="448" height="304" alt="image" src="https://github.com/user-attachments/assets/02933dfa-4624-4d76-b1d6-7a5e4ed7d4c3" />

 -Placement & Routing: The device view displays the physical layout inside the FPGA chip, showing exactly where the circuit's gates are placed and how the copper traces are routed
 -I/O Ports: The green blocks on the left edge show the configured Input/Output blocks linked directly to the board's switches and LED

- **Resource utilization:**

<img width="821" height="257" alt="image" src="https://github.com/user-attachments/assets/9992bfca-ed48-4c9f-b40e-a2480b4210f0" />

 -Logic Elements: The design uses only 1 Slice LUT as combinational logic out of the 20,800 available
 -Hardware Pins: The design utilizes 5 bonded IOBs (4 input switches and 1 output LED) out of the 106 pins available

- **Hardware testing:** 

 -Physical Verification: Testing on the Basys3 board shows the sliding the designated switches triggers the green LED0 precisely as verified in the simulation. Flipping the door-open/key-in combination or the running/unbuckled-passenger combination immediately lights up the LED

## 6. Reflection

Technical Challenges & Resolutions:
 - Pin Mapping Errors: Solved initial hardware mismatch by explicitly verifying switch and LED names against the Basys3 master XDC constraints file
 - Boolean Minimization: Resolved gate-overhead risks by using dataflow concurrent VHDL to let Vivado optimize the combinational expressions
What I Learned:
 - Xilinx Design Flow: Gained hand-on experience navigating the complete toolchain from VHDL behavioral entry through synthesis and final hardware implementation
Connection to Theory:
 - Combinatorial Logic: Applied core concepts of Boolean algebra, truth tables, and SOP expressions to solve a real-world multi-variable automotive safety problem
