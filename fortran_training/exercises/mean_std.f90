program mean_std

  implicit none
  integer :: i
  real :: mean, std, sum, sq_sum, tmp
  integer, parameter :: num = 10

  i = 0
  sum = 0
  sq_sum = 0
  print*, 'Please enter ', num, ' positive real numbers:'

  do while (i<num)
      read*, tmp

      if (tmp<=0) then

         print*, 'Please enter a positive one!'
         cycle
      else

          sum = sum + tmp
          sq_sum = sq_sum + tmp**2
          i = i + 1
      end if
  end do

  mean = sum/num
  std = sqrt(sq_sum/num - mean**2)

  print*, 'The mean value of this series of numbers you entered is: ', mean
  print*, 'The standard deviation of this series of numbers you entered is: ', std

end program mean_std
