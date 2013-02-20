
% clear development environment and setup appropriate formats
clear all;
format long;

% calibrate detector and obtain scaling parameters
[m, sig_m] = calibrate();

process_c2h2();