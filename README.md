VLSI Design Flow RTL to GDS

This project shows a complete VLSI design flow using only open source tools.
The flow starts from RTL design and goes up to synthesis, timing analysis, and equivalence checking.

The main goal is to understand how industry style digital design works without using paid EDA tools.

Project Overview

The design is written in Verilog and includes multiple logic blocks.
A top level module selects which block to use based on a control input.

The flow followed is:

RTL design in Verilog

Simulation and functional verification

Waveform analysis using GTKWave

Code coverage analysis

Logic synthesis using Yosys

Static Timing Analysis using OpenSTA

Logical equivalence checking

Logic Blocks Used

Clock Divider
Reduces the input clock frequency using a counter.

Barrel Shifter
Shifts input data left or right in a single cycle.

LFSR
Generates pseudo random numbers using feedback logic.

Parity Generator
Generates a parity bit for error detection.

Design Behavior

Inputs A and C are stored in registers.

The design works on the positive edge of the clock.

Reset is synchronous.

Based on value of C:

C < 51 selects Clock Divider

51 ≤ C < 100 selects Barrel Shifter

100 ≤ C ≤ 128 selects Parity Generator

C > 128 selects LFSR

Tools Used

Verilog for RTL design

Icarus Verilog for simulation

GTKWave for waveform viewing

Covered for code coverage

Yosys for synthesis

OpenSTA for timing analysis

Sky130 standard cell library

All tools are open source.

How to Run Simulation

Example command:

iverilog -o sim rtl_topmodule.v clk_divider.v barrel_shifter.v lfsr.v parity_gen.v testbench.v
vvp sim
gtkwave dump.vcd

Synthesis and Timing

RTL is synthesized using Yosys.

Same netlist is used for all timing constraints.

Timing is analyzed using OpenSTA with different clock periods.

Area remains constant because Yosys is not timing driven.

Equivalence Checking

RTL is treated as the golden design.

Synthesized netlist is treated as the revised design.

Yosys equivalence checking confirms both designs are functionally identical.

Results Summary

Functional simulation passed

Good code coverage achieved

Timing varies with constraints

Area remains unchanged

Equivalence check passed successfully

Author

Ishaan Singhal
Delhi Technological University
