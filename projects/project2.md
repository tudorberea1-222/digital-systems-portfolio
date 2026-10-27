

---
layout: default
title: Project 2
---

# Project 2: Event Counter

## 1. Introduction

The Event Counter project is supposed to be a digital circuit or software routine that tracks and records how many times a specific action or event occurs. The objectives of this project are:
  - to design and implement sequential circuits in VHDL, including modulo-M counters and button event counters
  - implement using configurable frequency dividers with VHDL generic and generic maps
  - Implement and test counter-based applications on the Basys3 FPGA board using push buttons and 7-degment displays 

## 2. Design

Overall System Design: The system is a structural VHDL design that captures input triggers, increments a numeric tally, and displays the running total on physical hardware. It is designed to work in two modes: automatically counting every second using a clock, or manually counting every time a physical button is pressed.

Major Functionals Blocks:
1. Input Conditiong (Clock Divider/Debouncer)
2. Modulo-M Counter
3. Hex-to-7-Segment Decoder

Include a labelled block diagram showing the system architecture.

## 3. Code

Explain the key sections of your VHDL code and how they implement the required functionality.

Provide links to the relevant design files:

Part 1 and 2 files: [MP2Projectfiles (1).zip](https://github.com/user-attachments/files/33997009/MP2Projectfiles.1.zip)


- **Design source:** Part 1: [Link]library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity count_display is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           leds : out STD_LOGIC_VECTOR (3 downto 0);
           sevenseg : out STD_LOGIC_VECTOR (6 downto 0);
           anode: out STD_LOGIC_VECTOR (3 downto 0));
end count_display;

architecture Behavioral of count_display is
 signal count_sig: STD_LOGIC_VECTOR (3 downto 0) := "0000";
 signal slow_clk: STD_LOGIC := '0';
begin
    --complete the architecture
    -- instantiate and port map the three components - clk_div, modMcounter and hex_7seg modules
    --refer to the block diagram in lab handout
    -- use the signals declared above in this architecture to wire between components (internally)
    --dont forget to include the generic map in addition to port map
    
    
 onesec: entity work.clk_div
 generic map (
 clk_in_freq => 100000000,
 clk_out_freq => 1
 )
 port map (
 reset => reset,
 clk_in => clock,
 clk_out => slow_clk
 );
 
ModM: entity work.modMcounter
generic map (
n => 4
)
port map(
reset => reset,
clk => slow_clk,
count => count_sig
);

Hex7: entity work.hex_7seg
port map(
hexdigit => count_sig,
seg => sevenseg
);
 
 leds <= count_sig;
 anode <= "1110";
end Behavioral;

- **Testbench:** [Link]
- **Constraints (XDC):** [Link]


Include relevant code snippets where appropriate.

## 4. Simulation

Present simulation waveforms covering all required test scenarios.

For each scenario, explain:
- What was tested
- Expected behaviour
- Observed results
- Any discrepancies and their resolution

## 5. Hardware

Include and discuss:

- **Elaborated design:** <img width="1213" height="436" alt="image" src="https://github.com/user-attachments/assets/4eaaed22-5d21-42e5-9b83-36b998aadc69" />

The figure shows the top-level RTL schematic of the design. The system clock feeds a clock divider module (clk_div) to generate a one-second enable signal. This signal drives a modulo-M counter module (modMCounter), whose 4-bit output simultaneously drives the diagnostic LEDs (leds) and a hexadecimal-to-7-segment decoder (hex_7seg) to drive the physical display outputs.
- **Synthesized design:** <img width="171" height="237" alt="image" src="https://github.com/user-attachments/assets/20e7220c-d95c-4c5a-93cc-88b46df3bbb5" />

The figure shows a close-up of the Vivado Device View after synthesis, verifying the physical pin assignments for the top level input ports. The design correctly instantiates the IPAD hardware primitives mapped to physical package pins B13 and A12.
- **Implementation:** <img width="742" height="319" alt="image" src="https://github.com/user-attachments/assets/8934236a-5522-4860-b4c7-67b9c3e54af2" />

The figure shows the final Implemented design floorplan. The cyan clusters in regions X0Y0 and X1Y0 represent the physical placement of the synthesized LUTs and flip flops within the FPGA fabric slices, establishing the spatial footprint of the design.
- **Resource utilization:** <img width="558" height="153" alt="image" src="https://github.com/user-attachments/assets/7603f0b6-9e0b-45f2-83f6-a7fc3d247a4a" />

- **Hardware testing:**
     Clock Divider (onesec) - Expected: To scale the 100 MHz board clock down to 1 Hz
                              Observed: The display updated steadily exactly once per second

     Counter Logic (ModM) - Expected: To count sequentially up to M-1 and instantly roll over to 0.
                            Observed: The circuit successfully counted through the states in order and wrapped around cleanly without skipping numbers

     Outputs (leds & sevenseg) - Expected: To show the binary value on 4 LEDs and the alphanumeric character on one digit of the 7-segment display.
                                 Observed: The LEDs tracked the binary progression perfectly, and the display correctly illuminated matching numbers

     Asynchronous Reset - Expected: To force the entire system back to zero immediately when pressed
                        Observed: Pressing the Basys3 push button instantly cleared the LEDs, reset the display to '0', and releasing it resumed counting normally.


## 6. Reflection

Technical Challenges & Resolutions:
- Display Anode Management: Initially, all four digits were active or blinking. Resolving this required forcing a static bit vector mask ("1110") directly to the anode port to lock logic down to a single display window
- Active-Low Cathodes: The segment patterns origionally inverted what numbers should look like. This was resolved by adjusting the truth table logic inside the hex_7seg entity

What I Learned:
- Structural VHDL Realities: Component wiring relies completely on correctly configuring generic map boundaries alongside internal interconnect signals (count_sig, slow_clk)
- Constraint Synchronization: Port names in structural code must precisely match the case-sensitive string handles declared in the active lines of the xdc files

  Connection to Theory:
- Sequential Networks: Applied multi stage clock division to orchestrate state updates across independent register slices
- Combinational Mapping: Leveraged a static lookup architecture to continuously map 4-bit bus lines directly into a alphanumeric display structures
