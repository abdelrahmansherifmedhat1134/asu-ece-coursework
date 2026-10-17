#include<iostream>
#include<vector>
using namespace std;

int main() {
    int n, x;
    cin >> n;
    vector<int> v;
if(n==0)exit(0);

    for (int i = 0; i < n; i++) {
        cin >> x;
        v.push_back(x);
    }

    int arr1[50];

    for (int i = 0; i < n; i++) {
        int counter = 0;
        for (int j = 0; j < n; j++) {
            if (v[i] == v[j]) {
                counter++;
            }
        }
        arr1[i]=counter;
    }
     vector<bool> printed(n, false);

   for (int i = 0; i < n; i++) {
        // If the element has already been printed, skip it
        if (printed[i]) continue;

        // Print the current element and its frequency
        cout << v[i] << " " << arr1[i] << endl;

        // Mark the element as printed
        for (int j = i + 1; j < n; j++) {
            if (v[i] == v[j]) {
                printed[j] = true;  // Mark all subsequent identical elements as printed
            }
        }
}
}
