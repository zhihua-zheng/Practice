module ex5_mod
  implicit none
  contains

! -------- functions computing several derivatives in a 2D field for solving 2D
! advection-diffusion equation, with unequal spacing in each dimension.
!-------------------------------------------------------------------------------

! --- compute first order derivative, using centered finite difference.
  function aprime(a,h,dim)
    implicit none
    real, intent(in)              :: a(:,:), h
    real                          :: aprime(size(a,1),size(a,2))
    integer, intent(in), optional :: dim ! default is 1 (column dimension)
    ! local variables
    integer :: i, j, nx, ny

    ny = size(a,1)
    nx = size(a,2)

    if (present(dim) .and. dim==2) then ! for row direction
      do i=1,ny
        do j=2,nx-1
         aprime(i,j)=(a(i,j+1)-a(i,j-1))/(2*h) ! positive to the right
        end do
      end do
      aprime(:,1) = 0.
      aprime(:,nx) = 0.
    else ! for column direction
      do j=1,nx
        do i=2,ny-1
          aprime(i,j) = (a(i+1,j)-a(i-1,j))/(2*h) ! positive upward, down matrix column
        end do
      end do
      aprime(1,:) = 0.
      aprime(ny,:) = 0.
    end if
  end function aprime
! --- compute first order derivative, using centered finite difference.


! --- compute second order gradient (Laplacian), centered finite difference.
  function del2(a,dx,dy)
    implicit none
	  real, intent(in)           :: a(:,:), dx, dy
	  real, dimension(size(a,1),size(a,2)) :: del2
    ! local variables
    integer :: i, j, nx, ny

    ny = size(a,1)
    nx = size(a,2)

	  do i=2,ny-1
      do j=2,nx-1
		    del2(i,j)=(a(i+1,j)+a(i-1,j)-2*a(i,j))/(dy**2) + &
                  (a(i,j+1)+a(i,j-1)-2*a(i,j))/(dx**2)
      end do
	  end do
    del2(1,:) = 0.
    del2(ny,:) = 0.
    del2(:,1) = 0.
    del2(:,nx) = 0.
  end function del2
! --- compute second order gradient (Laplacian), centered finite difference.


! --- compute advection term, using upwind finite difference
  function upwind(vx,vy,a,dx,dy)
    implicit none
    real, intent(in) :: vx(:,:), vy(:,:), a(:,:), dx, dy
    real             :: upwind(size(a,1), size(a,2))
    ! local variables
    real, dimension(size(a,1),size(a,2)) :: vx_dTdx, vy_dTdy
    integer :: i, j, nx, ny

    ny = size(a,1)
    nx = size(a,2)

    do i=1,ny
      do j=2,nx-1
        if (vx(i,j) > 0) then
          vx_dTdx = vx(i,j)*(a(i,j)-a(i,j-1))/dx
        else
          vx_dTdx = vx(i,j)*(a(i,j+1)-a(i,j))/dx
        end if
      end do
    end do
    vx_dTdx(:,1) = 0.
    vx_dTdx(:,nx) = 0.

    do j=1,nx
      do i=2,ny-1
        if (vy(i,j) > 0) then
          vy_dTdy = vy(i,j)*(a(i,j)-a(i-1,j))/dy
        else
          vy_dTdy = vy(i,j)*(a(i+1,j)-a(i,j))/dy
        end if
      end do
    end do
    vy_dTdy(1,:) = 0.
    vy_dTdy(ny,:) = 0.

    upwind = vx_dTdx + vy_dTdy
  end function upwind
! --- compute advection term, using upwind finite difference

end module ex5_mod
