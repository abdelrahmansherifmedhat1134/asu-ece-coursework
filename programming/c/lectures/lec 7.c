# include  <stdio.h>
/*
struct
    {
        char *engine ;
        float price ;
        int seating_cap ;
    }car1,car2;

int main()
{
    car1.engine= "v8 dual turbo" ;
    car2.engine= "v6 natural breathing" ;
    car1.price= 200 ;
    car2.price= 150 ;
    printf("%s\n",car1.engine) ;
    printf("%s\n",car2.engine) ;
    printf("%f\n",car1.price) ;
    printf("%f\n",car2.price) ;
}
*/

/*
struct employee
{
    char *name ;
    int salary ;
    int age ;
};
int manager()
{
    struct employee manager ;
    printf("please enter manager age: ") ; scanf("%d",&manager.age) ;
    if (manager.age<30)
    {
        manager.salary= 50000 ;
    }
    else{manager.salary=60000 ; }
    return manager.salary ;

}
int main()
{
    struct employee emp1 ;
    struct employee emp2 ;

    printf("please enter employee 1 salary: ") ; scanf("%d",&emp1.salary) ;
    printf("please enter employee 2 salary: ") ; scanf("%d",&emp2.salary) ;

    printf("the manager salary is: %d\n",manager()) ;
    printf("employer 1 \n salary: %d \n",emp1.salary) ;
    printf("employer 2 \n salary: %d \n",emp2.salary) ;

}
*/
/*
typedef struct struct1
{
    int age ;
    int salary ;
}employee;
int main()
{

    employee ahmed= {35,5000};
    employee ali=ahmed ;
    //printf("ahmed's age is: %d\nand his salary is: %d\n",ahmed.age,ahmed.salary) ;
    //printf("ali's age is: %d\nand his salary is: %d\n",ali.age,ali.salary) ;

    employee* ptr1=&ahmed.age ;
    employee* ptr2=&ahmed.salary ;
    employee* ptr3=&ali ;

    ptr1-> age= 30 ;
    ptr2-> salary= 200 ;
    printf("ahmed's new age is: %d\n",*ptr1) ;
    printf("ahmed's new salary is: %d",*ptr2) ;



}

*/
/*
struct emp
{
    int salary ;
    int bonus ;
    int deduction ;
}ahmed , amr , waleed;


int main()
{
    printf("please enter ahmed salary: ") ; scanf("%d",&ahmed.salary) ;
    printf("please enter ahmed bonus: ") ; scanf("%d",&ahmed.bonus) ;
    printf("please enter ahmed deduction: ") ; scanf("%d",&ahmed.deduction) ;
    printf("please enter amr salary: ") ; scanf("%d",&amr.salary) ;
    printf("please enter amr bonus: ") ; scanf("%d",&amr.bonus) ;
    printf("please enter amr deduction: ") ; scanf("%d",&amr.deduction) ;
    printf("please enter waleed salary: ") ; scanf("%d",&waleed.salary) ;
    printf("please enter waleed bonus: ") ; scanf("%d",&waleed.bonus) ;
    printf("please enter waleed deduction: ") ; scanf("%d",&waleed.deduction) ;

    int waleed_tot= waleed.salary + waleed.bonus - waleed.deduction ;
    int ahmed_tot= ahmed.salary + ahmed.bonus - ahmed.deduction ;
    int amr_tot= amr.salary + amr.bonus - amr.deduction ;
    int tot_budget= amr_tot + ahmed_tot + waleed_tot ;

    printf("the total budget needed is: %d",tot_budget) ;
}
*/
/*
typedef struct
{
    int id ;
    int salary ;

}employee ;
int main()
{
    int i ;
    employee arr[10];
    for (i=0;i<10;i++)
    {
        arr[i].id=i+1 ;
        arr[i].salary=1000*(i+1) ;

    }
    printf("hi hello");
    for(i=0;i<10;i++)
    {
        printf("id %d is: %d\n",i+1,arr[i].id);
        printf("salary %d is: %d\n",i+1,arr[i].salary);
    }
}
*/

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
    students arr[10];
    int id;
    arr[10].id={0,1,2,3,4,5,6,7,8,9} ;
    arr[10].math_g= {50,60,70,80,90,95,85,75,65,55} ;
    arr[10].lang_g={50,60,70,80,90,95,85,75,65,55};
    arr[10].phys_g= {50,60,70,80,90,95,85,75,65,55} ;
    arr[10].chem_g= {50,60,70,80,90,95,85,75,65,55} ;

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

