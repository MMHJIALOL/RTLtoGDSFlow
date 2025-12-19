#!/bin/bash

echo "===== PART 3(c) : BALANCED =====" > report_c.txt
echo "" >> report_c.txt

echo "===== YOSYS AREA (SAME NETLIST) =====" >> report_c.txt
yosys synth_a.ys >> report_c.txt

echo "" >> report_c.txt
echo "===== OPENSTA TIMING REPORT =====" >> report_c.txt
sta sta_c.tcl >> report_c.txt
