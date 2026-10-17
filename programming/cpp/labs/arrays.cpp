#include<iostream>
#include<vector>
#include<string>
using namespace std;








/*
int main()
{
    string name;
    string names[]{"ahmed","ali","doaa","mohamed","osama"};
    int grades[]{15,17,10,12,16};
    cout<<"whoms grade do you want? ";cin>>name;
    int m, h_grade=0;

    for(int i=0;i<5;i++)
    {
        if(names[i]==name)
        {
            cout<<grades[i];
            break;
        }
    }
    for(int i=0;i<5;i++)
    {
        if(h_grade<grades[i])
           {

            h_grade=grades[i];
            m=i;
           }
    }
    cout<<"the student with highest grade is "<<names[m];
}
*/


/*
int main()
{
    vector<float> v1;
    float x;
    for(int i=0;i<10;i++)
    {
        cin>>x;
        v1.push_back(x) ;
    }

    float n_max,n_min,avg;
    for(int i=0;i<10;i++)
    {
        if(n_max<v1[i])
            n_max=v1[i];
        if(n_min>v1[i])
            n_min=v1[i];
    }
    cout<<"min is "<<n_min<<"max is "<<n_max<<endl ;
    cout<<"avg is " <<(n_max-n_min)/2 ;
}


*/


int main()
{
            vector<int> v;
            int x,temp;
    while(1)
    {
        cin>>x;
        if(x<0)
            break;
        v.push_back(x);
    }
    for(int i=0;i<v.size();i++)
    {
        for(int i=0;i<v.size()-1;i++)
            if(v[i]<v[i+1])
        {
            temp=v[i];
            v[i]=v[i+1];
            v[i+1]=temp;
        }
    }
    cout<<"largest 3 numbers: ";
    for(int i=0;i<3;i++)
    {
        cout<<v[i]<<" ";
    }
}




