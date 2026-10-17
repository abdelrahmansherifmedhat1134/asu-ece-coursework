#include<iostream>
#include<vector>
using namespace std;

int main() {
    int n, x;
    cin >> n;
    vector<int> v;
if(n==0)exit(0);
    // Input the elements into the vector
    for (int i = 0; i < n; i++) {
        cin >> x;
        v.push_back(x);
    }

    int mfe = v[0];  // Initialize most frequent element to the first element
    int highest_rep = 0;

    // Count frequency of each element
    for (int i = 0; i < n; i++) {
        int counter = 0;
        // Count occurrences of v[i]
        for (int j = 0; j < n; j++) {
            if (v[i] == v[j]) {
                counter++;
            }
        }

        // If current element has higher or equal frequency, update the most frequent element
        if (counter >= highest_rep) {
            highest_rep = counter;
            mfe = v[i];
        }
    }

    // Output the most frequent element
    cout << mfe;
}
