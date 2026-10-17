using namespace std;


class student
{
    string name;
    int age ;
    int grade ;

    void display(student s)
    {
        cout<<"name: "<<s.name<<\n<<"age: "<<s.age<<\n<<"grade: "<<s.grade<<endl;
    }

};

int main()
{
    student current_student;
    student max_grade_student;

    int more=1;
    int i=0;
    while(more)
    {
        cout<<"enter name of student: ";
        cin>>current_student.name;
        cout<<"enter age of student: ";
        cin>>current_studeent.age;
        cout<<"enter student grade: ";
        cin>>current_student.grade ;
        if(max_grade_student.grade<current_student.grade)
            max_grade_student = current_student

    }
    student.display(max_grade_student);
}
