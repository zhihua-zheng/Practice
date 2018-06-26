file : file1.o file2.o
	gcc -Wall file2.o file1.o -o file

file1.o : file1.c file2.h
	gcc -c -Wall file1.c -o file1.o

file2.o : file2.c file2.h
	gcc -c -Wall file2.c -o file2.o
