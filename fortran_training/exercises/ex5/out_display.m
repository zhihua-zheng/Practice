%% t_display 

% script to visualize 2D temprature field at initial state and as output of
% Zhihua's simple 2D advection-diffusion FORTRAN program 

% Zhihua Zheng (APL-UW) July 12 2018

clear
ny = 100; % grid points in y
nx = 100; % grid points in x

%% plot the initial field

load '/Users/Danny/Downloads/Practice/fortran_training/exercises/ex5/initial_T.dat'

initial_T = reshape(initial_T, ny, nx);

figure('position', [0, 0, 400, 400])
contourf(initial_T)
colorbar

%% plot the output

load '/Users/Danny/Downloads/Practice/fortran_training/exercises/ex5/final_T.dat'

final_T = reshape(final_T, ny, nx);

figure('position', [0, 0, 400, 400])
contourf(final_T)
colorbar
