# VLSI Design Flow RTL to GDS

This project demonstrates a complete VLSI design flow using only open source tools.
The flow starts from RTL design and goes up to synthesis, timing analysis, and logical equivalence checking.

The aim of this project is to understand an industry style digital design flow without using licensed EDA tools.

---

## Project Overview

The design is written in Verilog and consists of multiple logic blocks.
A top level module selects which block is active based on a control input.

The design flow includes:

1. RTL design in Verilog
2. Functional simulation and verification
3. Waveform analysis using GTKWave
4. Code coverage analysis
5. Logic synthesis using Yosys
6. Static Timing Analysis using OpenSTA
7. Logical equivalence checking

---

## Logic Blocks Used

Clock Divider  
Reduces the input clock frequency using a counter.

Barrel Shifter  
Shifts input data left or right in a single clock cycle.

Linear Feedback Shift Register (LFSR)  
Generates pseudo random sequences using feedback logic.

Parity Generator  
Generates a parity bit for error detection.

---

## Design Behavior

- Inputs A and C are stored in registers
- Design operates on the positive edge of the clock
- Reset is synchronous
- Output depends on the value of control input C

Operation selection:

- C < 51 selects Clock Divider
- 51 <= C < 100 selects Barrel Shifter
- 100 <= C <= 128 selects Parity Generator
- C > 128 selects LFSR

---

## Tools Used

- Verilog HDL
- Icarus Verilog for simulation
- GTKWave for waveform viewing
- Covered for code coverage
- Yosys for logic synthesis
- OpenSTA for static timing analysis
- Sky130 standard cell library

All tools used in this project are open source.

---

## How to Run Simulation

Example commands:

iverilog -o sim rtl_topmodule.v clk_divider.v barrel_shifter.v lfsr.v parity_gen.v testbench.v  
vvp sim  
gtkwave dump.vcd

---

## Synthesis and Timing Analysis

- RTL is synthesized using Yosys
- Same gate level netlist is used for all timing constraints
- Timing analysis is performed using OpenSTA
- Area remains constant since Yosys is not timing driven

---

## Logical Equivalence Checking

- RTL design is treated as the golden reference
- Synthesized netlist is treated as the revised design
- Yosys equivalence checking confirms functional correctness

---

## Results Summary

- Functional simulation successful
- Good code coverage achieved
- Timing varies with clock constraints
- Area remains unchanged
- Equivalence check passed

---

## Author

Ishaan Singhal  
