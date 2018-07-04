program mean_std

! input check (iostat) added on July 1 2018, Zhihua Zheng

  implicit none
  integer :: i=1, io, num=0
  real :: mean, std, sum=0., sq_sum=0., tmp

  print*, 'How many numbers do you want to input?'
  do while (num<=0)
     read(*,*,iostat=io) num
     if (io/=0) then
        print*, 'Check input, something is wrong!'
        print*
        print*, 'How many numbers do you want to input?'
     end if
  end do

  print*, 'Please enter', num, 'real numbers to proceed:'
  do while (i<=num)
      read(*,*,iostat=io) tmp
      if (io==0) then
         i=i+1
	     sum = sum + tmp
	     sq_sum = sq_sum + tmp**2
	  else
	     print*, 'Please only enter numbers! Try again...'
	     cycle
	  end if
  end do

  mean = sum/num
  std = sqrt(sq_sum/num - mean**2)

  print*, 'The mean value of this series of numbers you entered is: ', mean
  print*, 'The standard deviation of this series of numbers you entered is: ', std
end program mean_std
