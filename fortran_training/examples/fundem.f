      PROGRAM FUNDEM
*     Declarations for main program
      REAL A,B,C
      REAL AV, AVSQ1, AVSQ2
      REAL AVRAGE
*     Enter the data
      DATA A,B,C/5.0,2.0,3.0/

*     Calculate the average of the numbers
      AV = AVRAGE(A,B,C)
      AVSQ1 = AVRAGE(A,B,C) **2
   	  AVSQ2 = AVRAGE(A**2,B**2,C**2)

	    PRINT *,'Statistical Analysis'
      PRINT *,'The average of the numbers is:',AV
      PRINT *,'The average squared of the numbers: ',AVSQl
      PRINT *,'The average of the squares is: ', AVSQ2
      END

      REAL FUNCTION AVRAGE(X,Y,Z)
      REAL X,Y,Z,SUM
      SUM = X + Y + Z
      AVRAGE = SUM /3.0
      RETURN
      END
