program test_input_sum

implicit none
INTEGER :: io, x, sum

sum = 0
DO
   READ(*,*,IOSTAT=io)  x
   IF (io > 0) THEN
      WRITE(*,*) 'Check input.  Something was wrong'
      cycle
   ELSE IF (io < 0) THEN    ! control-D --> end-of-file mark
      WRITE(*,*)  'The total is ', sum
      EXIT
   ELSE
      sum = sum + x
   END IF
END DO

end program test_input_sum
