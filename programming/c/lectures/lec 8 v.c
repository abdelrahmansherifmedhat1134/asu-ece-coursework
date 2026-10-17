#include <stdio.h>
/*
typedef struct
{
    int id;
    int math_g;
    int lang_g;
    int phys_g;
    int chem_g;
}students;

int main()
{
    int id;
    students arr[10];
    int i;
    for(i=0;i<10;i++)
    {
        printf("please enter student %d id: ",i+1); scanf("%d",&arr[i].id);
    }
    students arr[].id={0,1,2,3,4,5,6,7,8,9} ;
    students arr[].math_g= {50,60,70,80,90,95,85,75,65,55} ;
    students arr[].lang_g={50,60,70,80,90,95,85,75,65,55};
    students arr[].phys_g= {50,60,70,80,90,95,85,75,65,55} ;
    students arr[].chem_g= {50,60,70,80,90,95,85,75,65,55} ;

    printf("please enter your id: ") ; scanf("%d",&id);
    int i ;
    for(i=0;i<10;i++)
    {
        if (id==arr[i].id)
        {
            printf("math grade: %d",arr[i].math_g);
            printf("language grade: %d",arr[i].lang_g);
            printf("chemistry grade: %d",arr[i].chem_g);
            printf("physics grade: %d",arr[i].phys_g);
            break ;

        }
        else if(id!=arr[i].id && i=9)
        {
            printf("student id is not correct");
        }
        else {continue ; }
    }



}

*/
typedef struct
{
    char name[50];
}student;

int main()
{
    student arr[3];
    int i;
    for(i=0;i<3;i++)
    {
        printf("enter name of student %d: ",i+1); fgets(arr[i].name,sizeof(arr[i].name),stdin);
        arr[i].name[strcspn(arr[i].name,"\n")]='\0' ;

    }
    printf("%s",arr[0].name) ;
}
