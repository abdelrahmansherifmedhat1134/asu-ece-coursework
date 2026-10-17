#include<iostream>
#include<string>
using namespace std ;

//upper condition x[i]>='A' && x[i]<='Z'
//lower condition x[i]>='a' && x[i]<='z'

string lowercase(string x)
{
    string y ;

    for(int i=0;i<x.length();i++)
    {
        if(x[i]>='A' && x[i]<='Z' && x[i]!=' ')
            y+=(x[i]+32) ;
        else y+=x[i];
    }
    return y ;
}


string sentencecase(string x)
{
    string y ;

    for(int i=0;i<x.length();i++)
    {
        if(x[i]>='a' && x[i]<='z' && i==0)
            y+=(x[i]-32) ;
        else if(x[i]>='A' && x[i]<='Z' && i!=0 )
            y+=(x[i]+32);
        else y+=x[i];
    }


    return y ;

}


string uppercase(string x)
{
    string y ;

    for(int i=0;i<x.length();i++)
    {
        if(x[i]>='a' && x[i]<='z' )
            y+=(x[i]-32) ;
        else y+=x[i];
    }
    return y ;
}



string titlecase(string x)
{
    string y ;

    for(int i=0;i<x.length();i++)
    {
        if(x[i]>='a' && x[i]<='z' && i==0 )
            y+=(x[i]-32);
        else if(x[i]>='A' && x[i]<='Z' && x[i-1]!=' ')
            y+=(x[i]+32);
        else if(x[i]>='a' && x[i]<='z' && x[i-1]==' ')
            y+=(x[i]-32) ;
        else y+=x[i];
    }
    return y ;
}


string togglecase(string x)
{
    string y ;

    for(int i=0;i<x.length();i++)
    {
        if(x[i]>='a' && x[i]<='z')
            y+=(x[i]-32) ;
        else if(x[i]>='A' && x[i]<='Z')
                y+=(x[i]+32);
        else y+=x[i];
    }
    return y ;
}


/*

int main()
{
    string str,y ;
    int n;

    getline(cin,str);
    cin>>n;

    switch(n){

    case 1:
        y=sentencecase(str) ;
        break ;

    case 2:
        y=lowercase(str) ;
        break ;
    case 3:
        y=uppercase(str);
        break;
    case 4:
        y=titlecase(str);
        break;
    case 5:
        y=togglecase(str);
        break;

    }

    cout<<y;
    return 0;
}
*/
