#!/bin/gnuplot
set title "Diagama de birfurcacion x_{n+1}= r * x_n(1-x_n)"
set xlabel "r"
set ylabel "x"
set terminal postscript
set output 'diagrama_difuración.ps'
plot "logistic.data" u 1:2 t "" pt 12

set terminal png size 1280,720
set output 'diagrama_difuración.png'
plot "logistic.data" u 1:2 t "" pt 12