
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

- **Design source:** [Link]
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

- **Synthesized design:** Schematic and explanation
- **Implementation:** Implementation results and observations
- **Resource utilization:** FPGA resource usage
- **Hardware testing:** Observed behaviour on the Basys3 board compared with expected functionality

Include screenshots, tables, or photographs where appropriate.

## 6. Reflection

Discuss:

- Technical challenges encountered and how they were resolved
- What you learned from the project
- How the work relates to digital design concepts and theory covered in the course
