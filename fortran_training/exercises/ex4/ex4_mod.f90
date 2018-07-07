module ex4_mod
  contains

! --------- compute second order derivative in a 2D field,
! with equal spacing in each dimension, using forward finite difference.

! new function that doesn't need number of points as a arguement
  function aaprime2(a,h)
    implicit none
	  real, intent(in)           :: a(:,:), h
	  real, dimension(size(a,1),size(a,2)) :: aaprime2
    ! local variables
    integer                    :: i, j, nx, ny

    ny=size(a,1)
    nx=size(a,2)

	  do i=2,ny-1
      do j=2,nx-1
		    aaprime2(i,j)=(a(i+1,j)+a(i-1,j)+a(i,j+1)+a(i,j-1)-4*a(i,j))/(h**2)
      end do
	  end do
    aaprime2(1,:)=0.
    aaprime2(ny,:)=0.
    aaprime2(:,1)=0.
    aaprime2(:,nx)=0.

  end function aaprime2
! --------- compute second order derivative

end module ex4_mod
