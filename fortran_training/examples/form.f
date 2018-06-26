      program form

* Program calculates the average of three exam scores for a
* person. The data is either read not using formatting from
* the file, record.dat, or is read using formatting from
* the file record.dat. The output is written to the screen
* and to the file result.out. NAME is student name. NUMBER is
* the student's seat number. exam1, 2, 3 are exam results.
* ave is the average of the results.

* DECLARATIONS

      real exam1, exam2, exam3, ave
      character*10 name
      integer number

* FILE OPENING AND VARIABLE INITIALIZATION

      open(unit=9, file='record.dat', status='old')
      open(unit=10, file='result.out', status='unknown')

* INPUT DATA FROM record.dat WITH AN UNFORMATTED READ
* STATEMENT

      read(9,15) name, number, exam1, exam2, exam3

* This is how you would write a formatted read statement
* even though the program doesn't use it. You would replace
* the * in the READ statement above with 15. Also, you
* would have to change the data file structure as shown
* in RESLT-F.DAT. NOTE THERE IS NO CARRIAGE CONTROL
* INDICATOR IN FORMATTED READS

15    format(a10,1x, i2,1x, f4.1,1x, f4.1,1x, f4.1,1x)

* CALCULATION

      ave=(exam1 + exam2 + exam3)/3.0

* PRINT RESULTS TO SCREEN
      print 20, name, number
20    format(1x,9x,'EXAM RESULTS FOR:',a10,/1x,/1x,9x,
     +'SEAT NUMBER: ',i2,/1x)

      print 25
25    format(1x,9x,'TEST 1',5x,'TEST 2',5x,'TEST 3',5x,
     +'AVERAGE',/,1x)

      print 30, exam1, exam2, exam3, ave
30    format(1x,9x, f4.1, 7x, f4.1, 7x, f4.1, 7x, f4.1)
31    format(1x, 4(7x,f4.1) )

* PRINT RESULTS TO OUTPUT FILE

      write(10,20) name, number
      write(10,25)
      write(10,30) exam1, exam2, exam3, ave

* CLOSE FILES

      close(unit=9)
      close(unit=10)
      end
