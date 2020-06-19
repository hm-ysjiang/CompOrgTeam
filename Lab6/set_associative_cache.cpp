#include <iostream>
#include <iomanip>
#include <fstream>
using namespace std;

#define N (1)
#define CACHE_SIZE (32) // 32K
#define BLOCK_SIZE (64)


void print_result(const float &hit_rate, const int &hit_num, const float &miss_rate, const int &miss_num){
    cout << N << "-N Way\n" <<
            "Cache_size: " << CACHE_SIZE << '\n' <<
            "Block_size: " << BLOCK_SIZE << '\n' <<
            "Hit rate: " << fixed << setprecision(2) << hit_rate  << "% (" << hit_num  << "),  " <<
            "Miss rate: " << miss_rate << "% (" << miss_num << ")\n";
    return;
}

int main(void){

    print_result();
    return 0;
}