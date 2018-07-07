%% init_out_display 

% script to build initial 2D temprature field and display output file for
% Zhihua's simple 2D diffusion FORTRAN program 

% July 6 2018

clear
ny = 21; % grid points in y
nx = 43; % grid points in x


%% random
clear
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


%% spike

clear
T = zeros(ny,nx);
T(11,22) = 1;

figure('position', [0, 0, 800, 400])
contourf(T)
colorbar

T = reshape(T, ny*nx, 1);
fileID = fopen('/Users/Danny/Downloads/Practice/fortran_training/exercises/ex4/initial_T.dat','w');
fprintf(fileID,'%5.2f\n',T);
fclose(fileID);

%% plot the output

fileID = fopen('/Users/Danny/Downloads/Practice/fortran_training/exercises/ex4/initial_T.dat','w');
fprintf(fileID,'%5.2f\n',T);
fclose(fileID);


final_T = reshape(final_T, ny, nx);

figure('position', [0, 0, 800, 400])
contourf(final_T)
colorbar
