%% t_display 

% script to visualize 2D temprature field at initial state and as output of
% Zhihua's simple 2D advection-diffusion FORTRAN program 

% Zhihua Zheng (APL-UW) July 12 2018

clear
ny = 50; % grid points in y
nx = 50; % grid points in x

%% plot the flow field

load '/Users/Danny/Downloads/Practice/fortran_training/exercises/ex5/flow.dat'

psi = reshape(flow(:,1), ny, nx);
x = reshape(flow(:,2), ny, nx);
y = reshape(flow(:,3), ny, nx);
u = reshape(flow(:,4), ny, nx);
v = reshape(flow(:,5), ny, nx);

figure('position', [0, 0, 560, 400])
cmocean('tempo')
contourf(x,y,psi,'LineWidth',0.01,'LineStyle','none')
colorbar

figure('position', [0, 0, 560, 400])
quiver(x,y,u,v,'r')

speed = sqrt(u.^2+v.^2);
figure('position', [0, 0, 560, 400])

contourf(x,y,speed,'LineWidth',0.01,'LineStyle','none')
colorbar

% [vy, vx] = gradient(psi,0.5);
% vy = -vy;
% quiver(vx,vy)

%% plot the initial temperature

load '/Users/Danny/Downloads/Practice/fortran_training/exercises/ex5/initial_T.dat'

initial_T = reshape(initial_T, ny, nx);

figure('position', [0, 0, 560, 400])
contourf(initial_T,'LineWidth',0.01,'LineStyle','none')
colorbar

%% plot the output temperature

load '/Users/Danny/Downloads/Practice/fortran_training/exercises/ex5/final_T.dat'

del2T = reshape(final_T(:,2), ny, nx);
v_gradT = reshape(final_T(:,3), ny, nx);
final_T = reshape(final_T(:,1), ny, nx);

figure('position', [0, 0, 560, 400])
contourf(x,y,final_T,'LineWidth',0.01,'LineStyle','none')
colorbar
