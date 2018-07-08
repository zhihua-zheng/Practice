%% init_out_display 

% script to build initial 2D temprature field and display output file for
% Zhihua's simple 2D diffusion FORTRAN program 

% July 6 2018

clear
ny = 43; % grid points in y
nx = 87; % grid points in x


%% initial random

T = rand(ny,nx);
T(1,:) = 0;
T(end,:) = 0;
T(:,1) = 0;
T(:,end) = 0;

figure('position', [0, 0, 800, 400])
contourf(T)
colorbar

T = reshape(T, ny*nx, 1);

fileID = fopen('/Users/Danny/Downloads/Practice/fortran_training/exercises/ex4/initial_T.dat','w');
fprintf(fileID,'%5.2f\n',T);
fclose(fileID);


%% initial spike


T = zeros(ny,nx);
T((ny+1)/2,(nx+1)/2) = 1;

figure('position', [0, 0, 800, 400])
contourf(T)
colorbar

T = reshape(T, ny*nx, 1);
fileID = fopen('/Users/Danny/Downloads/Practice/fortran_training/exercises/ex4/initial_T.dat','w');
fprintf(fileID,'%5.2f\n',T);
fclose(fileID);

%% plot the output

load '/Users/Danny/Downloads/Practice/fortran_training/exercises/ex4/final_T.dat'

final_T = reshape(final_T, ny, nx);

figure('position', [0, 0, 800, 400])
contourf(final_T)
colorbar
