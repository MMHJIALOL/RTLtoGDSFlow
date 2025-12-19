#!/bin/bash

echo "===== PART 3(b) : MINIMUM TIME =====" > report_b.txt
echo "" >> report_b.txt

echo "===== YOSYS AREA (SAME NETLIST) =====" >> report_b.txt
yosys synth_a.ys >> report_b.txt

echo "" >> report_b.txt
echo "===== OPENSTA TIMING REPORT =====" >> report_b.txt
sta sta_b.tcl >> report_b.txt
