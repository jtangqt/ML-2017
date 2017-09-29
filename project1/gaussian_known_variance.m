%%Project 1%%
%%Gaussian Known Variance%%

clc; clear all; close all;

X = randn(100); 
N = 1:1:100;
a = [0.1; 1; 2; 8]; 
b = [0.1; 1; 3; 4];
a_n = zeros(1,100);
b_n = zeros(1,100); 
var_ml = zeros(100);
sigma_cp = zeros(100);
mse_ml = zeros(1, 100);
mse_cp = zeros(4,100);
mu = 0;
sigma = 1; 
a_o = [0.1, 1, 2, 4];
b_o = sqrt([0.1, 1, 2, 4]);

