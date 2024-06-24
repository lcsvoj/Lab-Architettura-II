// C++ program for recursive implementation 
// of Bubble sort 

// main idea: instead of scan the array in bubbles (sliding 
// windows of two elements) and sort their content we can scan
// the entire array and push the largest item to the end *. 
// We then repeat the procedure (move on the largest element)
// from its first position to the one preceding the largest
// element moved on in the previous recursion step. Base case
// is when we should look only at the first element (in this 
// case sorting is impossible: the array is sorted and we can
// exit the recursion (and print the sorted array).
//
// *: we push to the end bound of the array if we want to sort
// in increasing order. To sort in deacreasing order we must 
// move the largest element toward the first position of the
// array.
//
// We need three functions:
// 	- the recursive sorting function
// 	- a function that prints the array
// 	- a generic main function 
//

#include <bits/stdc++.h> 
using namespace std; 
  
// A function to implement bubble sort 
void bubbleSort(int arr[], int n) 
{ 
    // Base case 
    if (n == 1) 
        return; 
  
    int count = 0; 
    // One pass of bubble sort. After 
    // this pass, the largest element 
    // is moved (or bubbled) to end. 
    for (int i=0; i<n-1; i++) 
        if (arr[i] > arr[i+1]){ 
            swap(arr[i], arr[i+1]); 
            count++; 
        } 
  
      // Check if any recursion happens or not 
      // If any recursion is not happen then return 
      if (count==0) 
           return; 
  
    // Largest element is fixed, 
    // recur for remaining array 
    bubbleSort(arr, n-1); 
} 
  
/* Function to print an array */
void printArray(int arr[], int n) 
{ 
    for (int i=0; i < n; i++) 
        cout<<arr[i]<<" "; 
    cout<<"\n"; 
} 
  
// Driver program to test above functions 
int main() 
{ 
    int arr[] = {55, 39, 23, 15, 49, 8, 95}; 
    int n = sizeof(arr)/sizeof(arr[0]); 
    bubbleSort(arr, n); 
    cout<<"Sorted array : \n"; 
    printArray(arr, n); 
    return 0; 
} 
  
