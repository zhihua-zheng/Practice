module ex3_mod
  implicit none
  integer :: im
  contains

! --------- compute mean and standard deviation
  function mean_std(a,n)
    implicit none
    integer, intent(in) :: n
    real, intent(in)    :: a(n)
    real                :: sum=0., sq_sum=0.
    real, dimension(2)  :: mean_std

    do im=1,n
       sum=sum+a(im)
       sq_sum=sq_sum+a(im)**2
    end do
    mean_std(1)=sum/n
    mean_std(2)=sqrt(sq_sum/n - mean_std(1)**2)
  end function mean_std
! --------- compute mean and standard deviation

! --------- compute second order derivative, forward finite difference
  function aprime2(a,np,h)
      implicit none
	  integer, intent(in) :: np
	  real, intent(in)    :: a(np), h
	  real, dimension(np) :: aprime2

	  do im=2,np-1
		 aprime2(im)=(a(im+1)-2*a(im)+a(im-1))/(h**2)
	  end do
	  aprime2(1)=0.
	  aprime2(np)=0.
  end function aprime2
! --------- compute second order derivative, forward finite difference

end module ex3_mod
