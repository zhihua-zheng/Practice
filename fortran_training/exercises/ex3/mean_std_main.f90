program mean_std_main
  USE ex3_mod
  implicit none
  integer             :: num=0, io, i
  real, allocatable   :: val(:)
  real                :: b
  real, dimension(2) :: m

  open(1,file='test_data.dat',status='old')

  do ! loop to check how many values
    read(1,*,iostat=io) b
    if (io<0) exit ! reaches end-of-file mark
    if (io/=0) stop 'error reading data'
    num=num+1
  end do

  print*, 'found',num,"values in 'test_data.dat'"
  allocate(val(num))
  rewind(1) ! moves file pointer back to start
  do i=1,num
     read(1,*) val(i)
  end do
  close(1)

  m = mean_std(val,num)
  print*, "The mean of values in 'test_data.dat' is: ", m(1)
  print*, "The standard deviation of values in 'test_data.dat' is: ", m(2)

end program mean_std_main