#!/bin/bash

echo "===== PART 3(a) : MIN AREA =====" > report_a.txt
echo "" >> report_a.txt

echo "===== YOSYS AREA + CELL REPORT =====" >> report_a.txt
yosys synth_a.ys >> report_a.txt

echo "" >> report_a.txt
echo "===== OPENSTA TIMING REPORT =====" >> report_a.txt
sta sta_a.tcl >> report_a.txt
