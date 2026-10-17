#include<iostream>
#include<string>
using namespace std;

class person {
private:
string name;
string gender;
float age;
public:
void store_data(string p_name,string p_gender, float p_age)
{
    name=p_name;
    gender=p_gender;
    age=p_age;

}
void print_data ()
{
    cout<<"person's name: "<<name<<endl<<"age: "<<age<<endl<<"gender: "<<gender<<endl;

}
};



class tollbooth
{
private:
    int cars;
    double cash;
public:
    tollbooth():cars(0),cash(0){}
    void paying_car()
    {
        cars++;
        cash+=5;
    }
    void no_pay_car()
    {
        cars++;
    }
    void display()
    {
        cout<<cars<<" passed and "<<cash<<" total cash present";
    }

};



int main()
{
    person p1;
    string name,gender;
    int age;
    cout<<"enter name: ";cin>>name;
    cout<<"enter gender: ";cin>>gender;
    cout<<"enter age: ";cin>>age;
    p1.store_data(name,gender,age);
    p1.print_data();
}


