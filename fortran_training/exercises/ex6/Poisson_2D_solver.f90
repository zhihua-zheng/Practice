program Poisson_2D_solver_main

  USE ex6_mod

  implicit none
  integer           :: i, j, nx, ny, it=0
  real              :: h, alpha, res_rms, f_rms, err=1e-5
  real, allocatable :: u(:,:), f(:,:), res(:,:)
  character(len=20) :: source, iteration, output

! Read in control parameters using namelist
  namelist /inputs/ nx, ny, source, iteration, alpha, output

  open(1,file='para_Poisson.nml',status='old')
  read(1,inputs) ! read inputs from file ID 1
  close(1)

  source = trim(source)
  iteration = trim(iteration)

  ! echo values to stdout
  write(*,inputs)

! Initialize - set up variables and numerical details
  allocate(u(ny,nx), f(ny,nx), res(ny,nx))
  h = 1./(ny-1)
  u = 0.

  ! set source function
  if (source .eq. 'random') then
    call random_number(f)

  else if (source .eq. 'spike') then
    f = 0.
    f((ny/2+1),(nx/2+1)) = 1./h**2

  else
    stop 'ERROR: unsupported source function, please try again!'
  end if

  ! compute rms value of source field
  f_rms = rmsq(f)

  ! compute initial residue field
  call residue_2DPoisson(u,f,h,res)

  ! compute rms value of initial residue field
  res_rms = rmsq(res)

! Solve the Poisson equation using iteration relaxation

  ! determine which iteration method to use
  if (iteration .eq. 'V_cycle') then

    do while (res_rms/f_rms >= err)
      res_rms = Vcycle_2DPoisson(u,f,h)
      it = it+1 ! record the number of iterations
    end do
    print*
    print*, 'It takes', it-1, 'iterations for ', iteration, ' iteration method.'

  else if (iteration .eq. 'regular') then

    do while (res_rms/f_rms >= err)
      res_rms = iteration_2DPoisson(u,f,h,alpha)
      it = it+1 ! record the number of iterations
    end do
    print*
    print*, 'It takes', it, 'iterations for ', iteration, ' iteration method.'

  else
    stop 'ERROR: unsupported iteration method, please try again!'
  end if

! Write 'f' and 'u' to file for visualization
  open(3,file=output)
  do j=1,nx
    do i=1,ny
     write(3,*) f(i,j), u(i,j)
    end do
  end do
  close(3)

  print*
  print*, 'res_rms =', res_rms, 'f_rms =', f_rms

  deallocate(f, u, res)

end program Poisson_2D_solver_main
