program test
  implicit none

  type t_test
      integer :: I
      real    :: R
  end type t_test

  type(t_test) :: T

  namelist /oups/ T

  open(1,file='test_nml.nml',status='old')
  read(1,oups) ! read inputs from file id 1
  close(1)

  print*, T%I
  print*, T%R

end program test
