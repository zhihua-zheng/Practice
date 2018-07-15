%% solution_vi

% Script to visualize the solution of 2D Poisson equation from
% Zhihua's simple FORTRAN solver 'Poisson_2D_solver.f90' 

% Zhihua Zheng (UW-APL) July 14 2018

clear
ny = 17; % grid points in y
nx = 17; % grid points in x

load '/Users/Danny/Downloads/Practice/fortran_training/exercises/ex6/f_u_Poisson.dat'
f = reshape(f_u_Poisson(:,1), ny, nx);
u = reshape(f_u_Poisson(:,2), ny, nx);
res = reshape(f_u_Poisson(:,3), ny, nx);

%% plot the source field

figure('position', [0, 0, 560, 400])
contourf(f,'LineWidth',0.01,'LineStyle','none')
colorbar

f_rms = rms(reshape(f,ny*nx,1));

%% plot the solution field

figure('position', [0, 0, 560, 400])
contourf(u,'LineWidth',0.01,'LineStyle','none')
colorbar

%% plot the residue field

figure('position', [0, 0, 560, 400])
contourf(res,'LineWidth',0.01,'LineStyle','none')
colorbar

res_rms = rms(reshape(res,ny*nx,1));
