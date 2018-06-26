#include<stdio.h>
#include"file2.h"

void add(int a, int b, void(*f)(int))
{
    int c  = a+b;
    f(c);
}
