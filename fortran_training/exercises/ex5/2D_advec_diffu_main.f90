program twoD_advec_diffu_main

! Take timesteps to integrate the advection-diffusion equation for the
! specified length of time using UPWIND finite-differences for dT/dx and dT/dy
! (and centered for del2(T))
! Boundary conditions: T=1 at bottom, T=0 at top, dT/dx=0 at sides (no flux)
!-------------------------------------------------------------------------------

  !USE type_gridpoint
  USE ex5_mod

  implicit none
  !type(gridpoint)   :: grid
  integer           :: i, j, nx, ny
  real, allocatable :: dT2(:,:), v_gradT(:,:)
  real, allocatable :: T(:,:), psi(:,:), u(:,:), v(:,:), x(:,:), y(:,:)
  real              :: time, tt=0., dt, a_dif, a_adv, kappa
  real              :: dx, dy, B, u_max, v_max, x_max, y_max
  real, parameter   :: PI = 3.1415926
  character(LEN=13) :: init, output


! Read in control parameters using namelist
  namelist /inputs/ nx, ny, dx, dy, time, init, output, kappa, a_dif, a_adv, B

  open(1,file='para_ad.nml',status='old')
  read(1,inputs) ! read inputs from file ID 1
  close(1)

  init = trim(init)
  output = trim(output)

  ! echo values to stdout
  write(*,inputs)

! Initialize - set up variables and numerical details
  allocate(T(ny,nx), psi(ny,nx), u(ny,nx), v(ny,nx), &
           x(ny,nx), y(ny,nx), dT2(ny,nx), v_gradT(ny,nx))

  ! set initial temperature field
  call random_number(T)
  T(1,:) = 1.
  T(ny,:) = 0.

  open(2,file=init)
  do j=1,nx
    do i=1,ny
      write(2,*) T(i,j)
    end do
  end do
  close(2)

  ! create x-y coordinate and set the streamfunction - simple cellular flow
  x_max = dx*(nx-1)
  y_max = dy*(ny-1)
  do i=1,ny
    do j=1,nx
     x(i,j) = (j-1)*dx
     y(i,j) = (i-1)*dy
     psi(i,j) = B*sin(PI*x(i,j)/x_max)*sin(PI*y(i,j)/y_max)
    end do
  end do

  ! derive velocity from streamfunction psi
  u =  aprime(psi,dy)
  v = -aprime(psi,dx,2)

  ! find the maximum velocity
  u_max = u(1,1)
  v_max = v(1,1)
  do i=1,ny
    do j=1,nx
      if (u(i,j)>u_max) then
         u_max = u(i,j)
      end if

      if (v(i,j)>v_max) then
         v_max = v(i,j)
      end if
    end do
  end do

  ! determine timestep
  dt=min(a_dif*(min(dx,dy))**2/kappa, a_adv*min(dx/u_max,dy/v_max))

! Compute the temperature field for future time point
  open(3,file=output)

  do while (tt<=time)
     dT2 = del2(T,dx,dy)
     v_gradT = upwind(u,v,T,dx,dy)
     do i=2,ny-1
       do j=2,nx-1
        T(i,j) = T(i,j)+dt*(kappa*dT2(i,j) - v_gradT(i,j))
       end do
     end do
     ! satisfy boundary conditions
     T(1,:) = 1.
     T(ny,:) = 0.
     T(:,1) = T(:,2)
     T(:,nx) = T(:,nx-1)

     tt=tt+dt
  end do

  do j=1,nx
    do i=1,ny
     write(3,*) T(i,j)
    end do
  end do
  close(3)

  deallocate(T, psi, u, v, x, y, dT2, v_gradT)

end program twoD_advec_diffu_main
