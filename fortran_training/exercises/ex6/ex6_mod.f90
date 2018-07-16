module ex6_mod
  implicit none
  contains

! -------- function and subroutines to do iteratoion for solving 2D Poisson
! equation, with equal spacing in each dimension.
!-------------------------------------------------------------------------------

! --- compute RMS value of a 2D field
real function rmsq(a)
  implicit none
  real, intent(in)  :: a(:,:)
  ! local variables
  integer :: i, j, ny, nx
  real    :: sq_sum

  ny = size(a,1)
  nx = size(a,2)

  sq_sum = 0.
  do i=1,ny
    do j=1,nx
      sq_sum = sq_sum + a(i,j)**2
    end do
  end do
  rmsq = sqrt(sq_sum/(nx*ny))
end function rmsq
! --- compute RMS value of a 2D field


! --- does one iteration on flow 'u' field, returns RMS residue
! same grid spacing 'h' for x, y direction
  real function iteration_2DPoisson(u,f,h,alpha)
    implicit none
    real, intent(inout) :: u(:,:) ! update 'u' after one iteration
    real, intent(in)    :: f(:,:), h, alpha
    ! local variables
    integer :: i, j, nx, ny
    real    :: res(size(u,1),size(u,2)) ! residue

    ny = size(u,1)
    nx = size(u,2)

    ! compute initial residue
    call residue_2DPoisson(u,f,h,res)

    ! apply correction and do one iteration
    do i=1,ny
      do j=1,nx
        u(i,j) = u(i,j) + alpha*res(i,j)*(h**2)/4
      end do
    end do

    call residue_2DPoisson(u,f,h,res) ! new residue

    ! calculate RMS of residue
    iteration_2DPoisson = rmsq(res)

  end function iteration_2DPoisson
! --- does one iteration on flow 'u' field, returns RMS residue


! --- calculate the residue into array 'res'
  subroutine residue_2DPoisson(u,f,h,res)
    implicit none
    real, intent(in)  :: u(:,:), f(:,:), h
    real, intent(out) :: res(size(u,1),size(u,2))
    ! local variables
    integer :: i, j, nx, ny

    ny = size(u,1)
    nx = size(u,2)

    do i=2,ny-1
      do j=2,nx-1
        res(i,j)=(u(i+1,j)+u(i-1,j) + &
                  u(i,j+1)+u(i,j-1)-4*u(i,j))/(h**2) - f(i,j)
      end do
    end do
    res(1,:) = -f(1,:)
    res(ny,:) = -f(ny,:)
    res(:,1) = -f(:,1)
    res(:,nx) = -f(:,nx)
  end subroutine residue_2DPoisson
! --- calculate the residue in array 'res'


! --- copy every other point in fine grid into coarse grid
  subroutine restrict(fine,coarse)
    implicit none
    real, intent(in)  :: fine(:,:) ! the residue array of fine grid
    real, intent(out) :: coarse(:,:) ! the residue of coarse grid
    ! local variables
    integer :: i, j, nx, ny, nx_c, ny_c

    ny = size(fine,1)
    nx = size(fine,2)
    ny_c = 1+(ny-1)/2
    nx_c = 1+(nx-1)/2

    do i=1,ny,2
      do j=1,nx,2
        coarse((1+(i-1)/2),(1+(j-1)/2)) = fine(i,j)
      end do
    end do

  end subroutine restrict
! --- copy every other point in fine grid into coarse grid


! --- get coarse grid correction back to fine grid and interpolate linearly
  subroutine prolongate(coarse,fine)
    implicit none
    real, intent(in)  :: coarse(:,:)
    real, intent(out) :: fine(:,:)
    ! local variables
    integer :: i, j, nx, ny, nx_f, ny_f

    ny = size(coarse,1)
    nx = size(coarse,2)
    ny_f = 1+(ny-1)*2
    nx_f = 1+(nx-1)*2

    !! project values from coarse grid to fine grid
    do i=1,ny
      do j=1,nx
        fine((1+(i-1)*2),(1+(j-1)*2)) = coarse(i,j)
      end do
    end do

    !! perform simple linear interpolation to fill the blank points

    ! fill the rows first
    do i=2,(ny_f-1),2
      do j=1,nx_f,2
        fine(i,j) = (fine(i-1,j)+fine(i+1,j))/2
      end do
    end do
    ! then fill the columns
    do j=2,(nx_f-1),2
      do i=1,ny
        fine(i,j) = (fine(i,j-1)+fine(i,j+1))/2
      end do
    end do

  end subroutine prolongate
! --- get coarse grid correction back to fine grid and interpolate linearly


! --- multigrid V-cycles function
  recursive function Vcycle_2DPoisson(u_f,rhs,h) result(resV)
    implicit none
    real               :: resV
    real, intent(inout):: u_f(:,:)  ! arguments
    real, intent(in)   :: rhs(:,:), h
    integer            :: nx, ny, nx_c, ny_c, i  ! local variables
    real, allocatable  :: res_c(:,:), corr_c(:,:), res_f(:,:), corr_f(:,:)
    real               :: alpha=0.7, res_rms

  !----- from Paul Tackley, ETH Zurich, 2017 -----------------------------------

    ny = size(u_f,1)
    nx = size(u_f,2)
    ! must be power of 2 plus 1
    if( nx-1/=2*((nx-1)/2) .or. ny-1/=2*((ny-1)/2) ) &
         stop 'ERROR: not a power of 2'
    ! coarse grid size
    nx_c = 1+(nx-1)/2
    ny_c = 1+(ny-1)/2

    if (min(nx,ny)>5) then  ! not the coarsest level

       allocate(res_f(ny,nx), corr_f(ny,nx), &
            corr_c(ny_c,nx_c), res_c(ny_c,nx_c))

       !---------- take 2 iterations on the fine grid--------------
       res_rms = iteration_2DPoisson(u_f,rhs,h,alpha)
       res_rms = iteration_2DPoisson(u_f,rhs,h,alpha)

       !---------- restrict the residue to the coarse grid --------
       call residue_2DPoisson(u_f,rhs,h,res_f) ! to get 'res_f'
       call restrict(res_f,res_c) ! to get 'res_c'

       !---------- solve for the coarse grid correction -----------
       corr_c = 0.  ! solution of coarse grid starts from zero
       res_rms = Vcycle_2DPoisson(corr_c,res_c,h*2) ! *RECURSIVE CALL*

       !---- prolongate (interpolate) the correction to the fine grid
       call prolongate(corr_c,corr_f) ! to get 'corr_f'

       !---------- correct the fine-grid solution -----------------
       u_f = u_f - corr_f ! negative sign in corr_f

       !---------- two more smoothing iterations on the fine grid---
       res_rms = iteration_2DPoisson(u_f,rhs,h,alpha)
       res_rms = iteration_2DPoisson(u_f,rhs,h,alpha)

       deallocate(res_f,corr_f,res_c,corr_c)

    else

       !----- coarsest level (ny=5): iterate to get 'exact' solution

       do i = 1,100
          res_rms = iteration_2DPoisson(u_f,rhs,h,alpha)
       end do

    end if

    resV = res_rms   ! returns the rms. residue

  end function Vcycle_2DPoisson
! --- multigrid V-cycles function

end module ex6_mod
