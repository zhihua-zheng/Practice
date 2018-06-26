#include<stdio.h>
#include"file2.h"

void callback (int result)
{
    printf("\n Result is : [%d] \n", result);
}

int main(void)
{
    int a=0,b=0;
    printf("\n Enter two numbers to add: ");
    scanf("%d %d",&a, &b);
    add(a,b,callback);
    return 0;
}
