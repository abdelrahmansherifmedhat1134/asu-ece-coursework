#include<iostream>
#include<vector>
using namespace std;

/*
int a [10];
int i;
for(i =0; i<10; i++)
a[i] = i*i;
for(i =0; i<10; i+=2)
cout << a[i];
*/
//this fragment displays the square of even numbers
/*
int a[5][5];
int i,j;
for(i=0;i<5;i++) {
for(j=0;j<5;j++)
a[i][j]=i*j;
for(i=0;i<5;i++)
cout<< a[i][i];
*/
//this fragment displays each position number in array multiplied by the same position number in sub array
/*
int main(){
vector<int> v {1,2,4};
v.pop_back();
for(int i=3; i<=5; i++)
v.push_back(i);
for(int i=0; i<v.size(); i++)
cout<< v.at(i) <<endl;
return 0;
}
*/
//this progran displays counting numbers from 1 to 5

int main()
{
    int a [10];
    int i,sum;
    for(i =0; i<10; i++)
        a[i] = i*i;
    for(i =0; i<10; i++)
    {
        cout << a[i]<<"+";
        sum+=a[i];
    }
    cout<<"="<<sum<<endl;

    int b[10][10];
    int j;
    for(i=0;i<10;i++)
        for(j=0;j<10;j++)
            b[i][j]=i*j;

    cout<<"the multiplication table"<<endl ;
    for(i=0;i<10;i++)
    {
        for(j=0;j<10;j++)
        {
            cout<<i<<"*"<<j<<"="<< b[i][j]<<"   ";
        }
    cout<<endl;
    }

    sum =0 ;
    vector<int> v ={0,1,2,4};
    v.pop_back();
    for(int i=3; i<=10; i++)
        v.push_back(i);
    for(int i=0; i<v.size(); i++)
        sum+=v[i] ;
    cout<<"average is = "<<sum/v.size();

    return 0;
}


