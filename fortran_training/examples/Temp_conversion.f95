program Temp_conversion

  implicit none
  real :: Deg_F, Deg_C, K

  print*, 'Please type in the temperature in F'
  read*, Deg_F

  Deg_C = 5.*(Deg_F-32.)/9.
  print*, 'This is equal to', Deg_C, 'C'

  K = Deg_C + 273.15
  print*, 'and', K, 'K'

end program Temp_conversion
