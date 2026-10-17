#include<iostream>
#include<string>
using namespace std;



//get number from string
float str_num(string x,int &a)
{
    float num=0;
    int i=0;
    while(x[i]>='0' && x[i]<='9' && i<x.length())
    {
        num= (num*10)+(x[i]-'0');
        i++;
    }
    float decimal=0;
    int m=1;
    if(x[i]=='.')
    {
        i++;
        while(x[i]>='0' && x[i]<='9' && i<x.length())
        {
            decimal= (decimal*10)+(x[i]-'0');
            i++;
            m*=10;
        }
        decimal=decimal/m;

    }
    a+=i;
    return num+decimal;

}
//recursive circuit solving function
float circuit(string x,int &i)
{
    float result=0;

    if(x[i]=='s'||x[i]=='S')//handling series case
    {
        int check=0;
        i++;
        while(x[i]!='e' && i < x.length())
        {
            if((x[i]>='a'&& x[i]<='z' && x[i]!= 's' &&x[i]!= 'p')||(x[i]>='A'&& x[i]<='Z' && x[i]!= 'S' &&x[i]!= 'P'))
            {cout<<"Wrong Description"<<endl;exit(0);}//check for another circuit connections
            if(x[i]>='0' && x[i]<='9')
                {result+=str_num(x.substr(i),i);check=1;}//adding resistor in series and ensuring 1 resistor or more is present
            else if(x[i]=='s'||x[i]=='S'||x[i]=='p'||x[i]=='P')//handle another child circuits using recursion
                    {result+=circuit(x,i);check=1;}
            i++;//move to next position
        }
        if (check==0){cout<<"Incorrect Input"<<endl;exit(0);}
        i++;
        return result;
    }

    else if(x[i]=='p'||x[i]=='P')//handle parallel connection
    {
        int check=0;
        i++;
        while(x[i]!='e'&& i < x.length())
        {
            if((x[i]>='a'&& x[i]<='z' && x[i]!= 's' &&x[i]!= 'p')||(x[i]>='A'&& x[i]<='Z' && x[i]!= 'S' &&x[i]!= 'P'))
            {cout<<"Wrong Description"<<endl;exit(0);}//checking for other circuit connections
            if(x[i]>='0' && x[i]<='9')
            {
                float y = str_num(x.substr(i),i);
                if(result==0)result=y;
                else{ result=(result*y)/(result+y);check=1;};
            }
            else if(x[i]=='s'||x[i]=='S'||x[i]=='p'||x[i]=='P')
            {
                float y=circuit(x,i);
                if(result==0)result=y;
                else {result=(result*y)/(result+y);check=1;};
            }

            i++;
        }
        if (check==0){cout<<"Incorrect Input"<<endl;exit(0);}
        i++;
        return result;

    }
    if((x[i]>='a'&& x[i]<='z' && x[i]!= 's' &&x[i]!= 'p')||(x[i]>='A'&& x[i]<='Z' && x[i]!= 'S' &&x[i]!= 'P'))
    {cout<<"Wrong Description"<<endl;exit(0);}

    return result;
}


int main()
{
    string x;
    getline(cin,x);
    int i=0;
    float y=0;
    y=circuit(x,i);
    cout<<"The total resistance = "<<y<<endl;
}

