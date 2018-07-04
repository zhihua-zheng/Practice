program oneD_diffusion_main
! Calculate T at the next timestep using the explicit finite-difference
! time derivative, assuming kappa=1
! Boundary condition: T=0
  USE ex3_mod
  implicit none
  integer           :: n, i
  real, allocatable :: x(:), T(:), dTdx2(:)
  real              :: L, time, tt=0., dx, dt

! Input
  write(*,'(a,$)') 'Please specify the length of domain: '
  read*, L
  write(*,'(a,$)') 'Please specify the number of grid points (odd number preferred): '
  read*, n
  write(*,'(a,$)') 'Please specify the integration time: '
  read*, time

! Initialize
  dx=L/(n-1); dt=0.4*dx**2
  allocate(x(n), T(n), dTdx2(n))
  Print*, 'Please enter the initial temperature field with', n, 'numbers (random or spike):'
  read*, (T(i), i=1,n)

  open(1,file='initial_T.dat')
  do i=1,n
     x(i)=(i-1)*dx
     write(1,*) x(i), T(i)
  end do
  close(1)

! Compute the temperature field for every time point
  open(2,file='final_T.dat')

  do while (tt<=time)
     dTdx2 = aprime2(T,n,dx)
     do i=2,n-1
        T(i) = T(i)+dt*dTdx2(i)
     end do
     T(1)=0;
     T(n)=0;

     write(2,*) 'At time t=', tt, 'the temperature field is:'
     do i=1,n
        write(2,*) x(i), T(i)
     end do
     write(2,*)

     tt=tt+dt
  end do

  close(2)
  deallocate(x,T,dTdx2)

end program oneD_diffusion_main