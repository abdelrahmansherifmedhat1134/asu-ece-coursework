#include<iostream>
#include<cmath>
#include<string>
using namespace std;


class point
{
public:
    double x;
    double y;
    point()//constructor 1
    {
        x=0;
        y=0;
    }
    point(float m,float n)//constructor 2
    {
        x=m;
        y=n;
    }
    void dist(point p2)
    {
        float i=x-p2.x;
        float j=y-p2.y;
        cout<<sqrt((i*i)+(j*j))<<endl;
    }
    void display()
    {
        cout<<"("<<x<<","<< y<<")";
    }

   point mid_point(point m,point n)//member function midpoint
    {
        x=(n.x+m.x)/2;
        y=(n.y+m.y)/2;
    }
};




class circle
{

public:
    point circle_mid;
    double radius;

    //constructors
    circle():radius(0),circle_mid(0,0){}
    circle(double r):radius(r){}
    circle(float m,float n):circle_mid(m,n){}
    circle(float m,float n,double r):circle_mid(m,n),radius(r){}

    //member functions

    void dist(circle c2)
    {
        float dist=sqrt(pow((circle_mid.x-c2.circle_mid.x),2)+pow((circle_mid.y-c2.circle_mid.y),2));
        cout<<dist<<endl;
    }
    void intersect(circle c2)
    {
        float dist=sqrt(pow((circle_mid.x-c2.circle_mid.x),2)+pow((circle_mid.y-c2.circle_mid.y),2));
        float maxi=radius+c2.radius;
        if(dist<=maxi)
            cout<<" intersect";
        else cout<<" don't intersect";

    }
     void display(circle c2)
    {
        cout<<"circle at ";
        circle_mid.display();
        cout<<" with radius "<<radius;
};


int main()
{
    circle c1;
    circle c2;

    cin>>c1.circle_mid.x; cin>>c1.circle_mid.y;
    cin>>c1.radius;
    if(c1.radius<=0)
        c1.radius=0;

    cin>>c2.circle_mid.x; cin>>c2.circle_mid.y;
    cin>>c2.radius;
    if(c2.radius<=0)
        c2.radius=0;
    c1.dist(c2);
    c1.display();



}
