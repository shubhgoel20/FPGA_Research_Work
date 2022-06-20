#include<bits/stdc++.h>
using namespace std;

//Sample input and output is shown at the end of the code

int main(){
    //Input Image
    int n,m;
    cin>>n>>m;
    int img[n][m];
    for(int i = 0;i<n;i++){
        for(int j = 0;j<m;j++){
            cin>>img[i][j];
        }
    }
    //-----------------------------------------------------
    //Algorithm start
    bool contour[n][m] = {};
    for(int i = 0;i<n;i++){
        for(int j = 0;j<m;j++){
            if(!img[i][j]){
                if(j+1<m){
                    if(img[i][j+1]) contour[i][j+1] = 1;
                }
                if(i+1<n){
                    if(img[i+1][j]) contour[i+1][j] = 1;
                }
            }
            else{
                if(!contour[i][j]){
                    if(j+1<m){
                        if(!img[i][j+1]) contour[i][j] = 1;
                    }
                    if(i+1<n){
                        if(!img[i+1][j]) contour[i][j] = 1;
                    }
                }
            }
        }
    }
    //Algorithm End
    //Display Contour
    for(int i = 0;i<n;i++){
        for(int j = 0;j<m;j++){
            cout<<contour[i][j]<<" ";
        }
        cout<<"\n";
    }
return 0;
}
//Sample Input-
// 10 10
// 0 0 0 0 0 0 0 0 0 0
// 0 1 1 1 0 0 1 1 1 0
// 0 1 1 1 0 0 1 1 1 0
// 0 1 1 1 0 0 1 1 1 0
// 0 1 1 1 1 1 1 1 1 0
// 0 1 1 1 1 1 1 1 1 0
// 0 1 1 1 0 0 1 1 1 0
// 0 1 1 1 0 0 1 1 1 0
// 0 1 1 1 0 0 1 1 1 0
// 0 0 0 0 0 0 0 0 0 0

//Output-
// 0 0 0 0 0 0 0 0 0 0 
// 0 1 1 1 0 0 1 1 1 0 
// 0 1 0 1 0 0 1 0 1 0 
// 0 1 0 1 0 0 1 0 1 0 
// 0 1 0 0 1 1 0 0 1 0 
// 0 1 0 0 1 1 0 0 1 0 
// 0 1 0 1 0 0 1 0 1 0 
// 0 1 0 1 0 0 1 0 1 0 
// 0 1 1 1 0 0 1 1 1 0 
// 0 0 0 0 0 0 0 0 0 0