#include<iostream>
#include<string>
using namespace std;

class subject
{
private:
    float grade;
    string name ;
public:
    subject(string n,float m){name=n;grade=m;};
    float get_grade()
    {
        return grade;
    };
    void set_grade(float r)
    {
        grade=r;
    };
};

void raise(subject& s,float r )
{
    s.set_grade(s.get_grade()+ r);
}

/*
int main()
{
    float grade=90;
    string subject_name="c1";
    subject course1(subject_name,grade);
    cout<<course1.get_grade()<<"\n";
    raise(course1,5);
    cout<<course1.get_grade()<<"\n";

}
*/
int main()
{
    char flaag=5;
    cout<<"this is a flag"<<flaag<<"what do you think";
}
