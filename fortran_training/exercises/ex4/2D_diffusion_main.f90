program twoD_diffusion_main
! Predict 2-D temperature field in future time using the explicit finite-difference time derivative
! Boundary condition: T=0
  USE ex4_mod
  implicit none
  integer           :: nx, ny, i, j
  real, allocatable :: T(:,:), dT2(:,:)
  real              :: time, tt=0., dt, dh, a, kappa
  CHARACTER(LEN=13) :: init, output

! Read in control parameters using namelist
  namelist /inputs/ nx, ny, time, init, output, kappa, a, dh

  open(1,file='parameters.nml',status='old')
  read(1,inputs) ! read inputs from file ID 1
  close(1)

  ! echo values to stdout
  write(*,inputs)

! Initialize - set up variables and numerical details
  dt=a*dh**2/kappa
  allocate(T(ny,nx), dT2(ny,nx))

  open(2,file=init,status='old')
  do j=1,nx
    do i=1,ny
      read(2,*) T(i,j)
    end do
  end do
  close(2)

! Compute the temperature field for every time point
  open(3,file=output)

  do while (tt<=time)
     dT2 = del2(T,dh)
     do i=2,ny-1
       do j=2,nx-1
        T(i,j) = T(i,j)+dt*kappa*dT2(i,j)
       end do
     end do
     T(1,:)=0.
     T(ny,:)=0.
     T(:,1)=0.
     T(:,nx)=0.

     tt=tt+dt
  end do

  do j=1,nx
    do i=1,ny
     write(3,*) T(i,j)
    end do
  end do
  close(3)

  deallocate(T,dT2)

end program twoD_diffusion_main
