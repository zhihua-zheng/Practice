program Deriv2

  implicit none
  integer           :: n,i
  real, allocatable :: x(:), y(:), z(:), dydx2(:), dzdx2(:)
  real              :: dx

  write(*,'(a,$)') 'Input number of grid points:'
  read*, n
  allocate(x(n), y(n), z(n), dydx2(n), dzdx2(n))

  dx=10.0/(n-1)
  do i=1,n
     x(i)=(i-1)*dx
     y(i)=sin(x(i))
     z(i)=x(i)**2
  end do

  call derivative2(y,n,dx,dydx2)
  call derivative2(z,n,dx,dzdx2)

  print*
  print*, 'TEST-sin(x):'
  do i=1,n
     print*,'finite difference: ',dydx2(i),'theoretical value: ',-sin(x(i)),'error: ',-sin(x(i))-dydx2(i)
  end do

  print*
  print*, 'TEST-x**2:'
  do i=1,n
     print*,'finite difference: ',dzdx2(i),'theoretical value: ',2,'error: ',2-dzdx2(i)
  end do

  deallocate(x,y,z,dydx2,dzdx2)
  contains
    subroutine derivative2(a,np,h,aprime2)
      implicit none
      integer, intent(in) :: np
      real, intent(in)    :: a(np), h
      real, intent(out)   :: aprime2(np)

      do i=2,np-1
         aprime2(i)=(a(i+1)-2*a(i)+a(i-1))/(h**2)
      end do
      aprime2(1)=0.
      aprime2(np)=0.
     end subroutine derivative2

end program Deriv2