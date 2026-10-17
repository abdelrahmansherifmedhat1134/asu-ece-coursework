#include <stdio.h>
#include <string.h>
/*
int main()
{
    int add (int x , int y)
    {
        int z= x+y ;
        return z ;
    }
    int sum= add(3,4) ;
    printf("the sum is: %d",sum) ;




    return 0 ;
}

*/
/*
int main()
{
    int get_max(int x , int y)
    {
        if(x>y){printf("the max is %d",x) ; }
        else{printf("the max is %d",y) ; }
    }
    int x ;
    int y ;
    printf("enter first number: ") ; scanf("%d",&x) ;
    printf("enter second number: ") ; scanf("%d",&y) ;
    get_max(x,y) ;
}
*/

/*
int main()
{
    int i ;
    int array[10] ;
    for(i=0;i<10;i++)
    {
        printf("enter item number %d: ",i+1) ; scanf("%d",&array[i]) ;

    }
    int sum= 0 ;
    int x= 0 ;
    while(x<10)
    {
        sum= sum + array[x] ;
        x++;
    }
    printf("the sum of the array elements is: %d",sum) ;
}

*/
/*
int main()
{
    int array[4] ;
    int i ;
    for(i=0;i<4;i++)
    {
        printf("enter item number %d: ",i+1) ; scanf("%d",&array[i]) ;

    }
    int x ;
    for(x=0;x<4;x++)
    {
        int y ;
        for(y=0;y<4;y++)
        {
        if (array[y]>array[y+1])
        {
            int z=array[y] ;
            array[y]=array[y+1] ;
            array[y+1]=z ;
        }
        else{continue ; }
        }
    }


    for(i=0;i<4;i++)
    {
        printf("%d \n",array[i]) ;
    }


    return 0 ;
}
*/

/*
int main()
{
    int array[10]= {0,1,2,3,4,1,6,7,8,1} ;
    int x ;
    int i ;
    int rep= 0 ;
    printf("enter the number: ") ; scanf("%d",&x) ;
    for(i=0;i<10;i++)
    {
        if(array[i]==x)
        {
            rep++ ;
            continue ;
        }
        else{continue ; }
    }
    printf("your number is repeated %d times",rep) ;
    return 0 ;
}
*/

/*
int main()
{
    int x= 5 ;
    int* ptr ;
    ptr= &x ;
    printf("before change: %d \n",x) ;
    *ptr= 6 ;
    printf("after change: %d\n",x) ;
    return 0 ;
}
*/
/*
int chartoint(char c)
{
    return c - '0';
}
#define print(x) printf("%d",x)
void main()
{
   /* int x= chartoint('3') ;
    int z= x+3 ;
    print(z) ;


    char str[]= "12345" ;
    int num= atoi(str) ;
    printf("%d\n",num) ;
    int z= 3+ num ;
    printf("%d",z) ;
    return 0 ;

}
*/
#include<stdlib.h>
void print_int(int num)
{
	int i ;
	char str[20] ;
	sprintf(str,"%d",num) ;
	printf("the integer as string %s\n",str);
	/*for(i=0;i<=strlen(str);i++)
	{
		printf("%c\n",str[i]) ;
	}*/
}

int number_former(int digits[],int num_digits)
{
    int result=0 ;
    for(int i=0;i<num_digits;i++)
    {
        result= (result*10) + digits[i]  ;
    }
    return result ;

}
int main()
{
    int digits[]={5,6,7,8,9} ;
    int num_digits= sizeof(digits) / sizeof(digits[0]) ;
    int res=number_former(digits,num_digits) ;
    printf("%d",res) ;
}



/*
void print_int(int num)
{
	int i ;
	char str[20] ;
	sprintf(str,"%d",num) ;
	for(i=0;i<=strlen(str);i++)
	{
		CLCD_voidSendData(str[i]) ;
	}
}





void print_str(char string[])
{

	int i;
	for(i=0;i<=strlen(string);i++)
	{

		CLCD_voidSendData(string[i]);
	}

}
*/
