#include<iostream>
#include<cmath>
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
        cout<<"("<<x<<","<< y<<")"<<endl;
    }

    void mid_point(point m,point n)//member function midpoint
    {
        x=(n.x+m.x)/2;
        y=(n.y+m.y)/2;
    }
};

float slope(point  p1,point p2)
{
    if(p1.x==p2.x)
        return INFINITY;
    else
        return (p2.y-p1.y)/(p2.x-p1.x) ;

}
int main()
{
    point p1;
    point p2;
    cin>>p1.x;cin>>p1.y;
    cin>>p2.x;cin>>p2.y;

    point mid_point;
    mid_point.mid_point(p1,p2);

    p1.dist(p2);

    mid_point.display();

    cout<<slope(p1,p2);
}
