program mean_std_sub

  implicit none
  integer           :: i=1, n=0
  real, allocatable :: a(:)
  real              :: mean, std, sum=0., sq_sum=0.

  allocate(a(n))

  do while (n<=0)
     print*, 'Enter the number of values (positive) you want to investigste'
     read*, n
  end do

  print*, 'Please enter a series of values you want to deal with:'

! enable positive number restrict
  do while (i<=n)
      read*, a(i)
      if (a(i)<=0) then
         print*, 'Please enter a positive one!'
         cycle
      else
         i=i+1
      end if
  end do
! enable positive number restrict

! no positive number limitation
!
! read*, (a(i), i=1,n)
!
! no positive number limitation

  call calculation(mean,std,a)

  deallocate(a)
  print*, 'The mean value of this series of numbers you entered is: ', mean
  print*, 'The standard deviation of this series of numbers you entered is: ', std


  contains
  subroutine calculation(mean,std,a)

    implicit none
    real, intent(in)  :: a(n)
    real, intent(out) :: mean, std

    do i=1,n
       sum = sum + a(i)
       sq_sum = sq_sum + a(i)**2
    end do

    mean = sum/n
    std = sqrt(sq_sum/n - mean**2)

  end subroutine calculation

end program mean_std_sub