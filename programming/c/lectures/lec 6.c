#include <stdio.h>
/*
int main()
{
    int x= 10 ;
    int* ptr= &x ;
    printf("before: %d \n",x) ;
    *ptr= 50 ;
    printf("after: %d",x) ;





    return 0;
}
*/
/*
int main()
{
    int x= 10 ;
    printf("the address of x is: %p \n",&x) ;
    int* ptr= &x ;
    printf("the address of pointer: %p \n",ptr) ;
    printf("its value is: %d \n",*ptr) ;
    int array[10]={0,1,2,3,4,5,6,7,8,9} ;

    int i ;
    for(i=0;i<10;i++)
    {
        printf("address %d: %p \n",i+1,&array[i]) ;
    }
    return 0 ;
}
*/

/*
int main()
{
    int array[10]={0,1,2,3,4,5,6,7,8,9} ;
    int i ;
    int* ptr =&array ;
    for(i=0;i<10;i++)
    {
        printf("address %d: %d \n",i+1 , *(ptr+i)) ;
    }
}
*/
/*
int main()
{
    int x ;
    int y ;
    printf("enter variable 1: ") ; scanf("%d",&x) ;
    printf("enter variable 2: ") ; scanf("%d",&y) ;
    int* ptr1 ;
    int* ptr2 ;
    int func (int* ptr1,int* ptr2)
    {

        int sum= *ptr1 + *ptr2 ;
        return sum ;
    }

    int sum= func(&x,&y) ;
    printf("the sum is: %d \n",sum) ;
    return 0 ;

}
*/

/*
int main()
{
    int x,y,sum,sub ;
    printf("enter first number: ") ; scanf("%d",&x) ;
    printf("enter srcond number: ") ; scanf("%d",&y) ;
    int func(int x,int y,int* ptr1,int* ptr2)
    {
       *ptr1= x+y ;
       *ptr2= x-y ;
    }
    func(x,y,&sum,&sub) ;
    printf("the sum is: %d \n",sum ) ;
    printf("the subtract is: %d \n",sub ) ;
}
*/
/*
int main()
{
    int array[10]={0,1,2,3,4,5,6,7,8,9} ;
    int i ;
    for(i=0;i<10;i++)
    {
        printf("element %d: %d \n",i+1,*array+i) ;
    }
}
*/
/*
int main()
{
    int array[10]={2,2,2,2,2,2,2,2,2,2} ;
    int funct(int* array)
    {
        int sum=0 ;
        int i ;
        for(i=0;i<10;i++)
        {
            sum=sum+ *(array+i) ;
        }
        return sum ;
    }
    int sum=funct(array) ;

    printf("the sum of array elements: %d",sum );
}
*/
/*
int main()
{
    int array1[5]={5,6,7,8} ;
    int array2[5]={1,2,3,4} ;
    int i ;
    int result ;
    int func(int array1[5],int array2[5])
    {
        int sum=0 ;
        for(i=0;i<5;i++)
        {

            int m= array1[i] ;
            int n= array2[i] ;
            sum= sum + (m*n) ;
        }
        return sum ;
    }
    result=func(array1,array2) ;
    printf("the scalar multiplication betn the matrices is: %d",result) ;
    return 0 ;

}
*/
/*
int main()
{
    int x=5 ;
    int y=7 ;

    void func(int* ptr1,int* ptr2)
    {
        int z= *ptr1;
        *ptr1= *ptr2 ;
        *ptr2= z ;

    }
    printf("x : %d , y: %d\n",x,y)

}
*/
/*
int main()
{
    int array[4]={9,4,7,2} ;
    void func(int array[4])
    {
        int i ;
        for(i=0;i<3;i++)
        {
            int r;
            for(r=0;r<4;r++)
            {
                if(array[r]>array[r+1])
                {
                    int z=array[r] ;
                    array[r]=array[r+1] ;
                    array[r+1]=z ;
                    continue ;
                }
                else{continue ;}
            }
        }
        for(i=0;i<4;i++)
        {
            printf("element %d: %d\n",i+1,array[i]) ;
        }
    }
    func(array) ;



    return 0 ;
}
*//*
int main()
{
    short int m ;
    printf("short: %d \n",sizeof(m)) ;
    long int n ;
    printf("long: %d \n",sizeof(n)) ;
    int x ;
    float y ;
    double z ;
    char r ;
    printf("the size of char  is: %d\n",sizeof(r)) ;
    printf("the size of int  is: %d\n",sizeof(x)) ;
    printf("the size of float  is: %d\n",sizeof(y)) ;
    printf("the size of double  is: %d\n",sizeof(z)) ;
    return 0 ;
}
*/

int main()
{
    int i;
    while (1)
    {
        printf("enter no: "); scanf("%d",&i);
        if(i)
        {
            printf("succeed");
        }
        else {printf("wrong");}
    }
}
