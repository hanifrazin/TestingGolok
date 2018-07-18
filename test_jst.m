clear all;clc;close all

input = [0 0
         1 0
         0 1
         2 1
         2 2
         1 2
         3 0
         3 2
         4 1
         1 4
         5 1
         5 2
         5 3
         5 4
         5 5]

input = transpose(input)

target = [0
          1
          1
          3
          4
          3
          3
          4
          5
          5
          5
          6
          7
          8
          9
          10]

target = transpose(target) 
      