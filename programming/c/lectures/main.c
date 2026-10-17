/*#include <stdio.h>


int main()
{
    int i ;
    int ahmedid= 1234 ;
    int amrid= 5678 ;
    int waelid= 9870 ;

    int id ;

    int ahmedpass= 7788 ;
    int amrpass= 5566 ;
    int waelpass= 1122 ;
    int pass ;

    printf("please enter your id: ") ; scanf("%d",&id) ;
    if (id==amrid || id==waelid || id==ahmedid)
    {

        for(i=0;i<3;i++)
        {
            printf("enter your password: ") ; scanf("%d",&pass) ;
            if (id==ahmedid && pass==ahmedpass)
            {
                printf("welcome Ahmed") ;
                break ;
            }
            else if(id==amrid && pass==amrpass)
            {
                printf("welcome amr") ;
                break ;
            }
            else if(id==waelid && pass==waelpass)
            {
                printf("welcome wael") ;
                break ;
            }
            else if(i==2)
            {


                printf("no more tries") ;
                break ;
            }

            else
            {
                printf("try again\n") ;
                continue ;
            }

            }
        }

    else
    {
        printf("your id is not registered") ;
    }

    return 0 ;

}


*/
