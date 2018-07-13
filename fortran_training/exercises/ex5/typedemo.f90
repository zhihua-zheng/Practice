program typedemo
  implicit none

  type person
    character(len=10) :: name
    integer          :: birthyear
    integer, allocatable :: childyear(:)
  end type person

  type(person) :: beatle(1)
  character(len=5) :: a='one two three'

  beatle(1)%name = 'John'
  beatle(1)%birthyear = 1940
  allocate(beatle(1)%childyear(2))
  beatle(1)%childyear(1) = 1963
  beatle(1)%childyear(2) = 1970

  print*, beatle(1)%name, beatle(1)%birthyear, beatle(1)%childyear
  print*, ichar('a')

end program typedemo
