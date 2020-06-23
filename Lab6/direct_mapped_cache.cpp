#include <vector>
#include <iostream>
#include <iomanip>
#include <fstream>
#include <sstream>
#include <cmath> // log2()
using namespace std;

#define CACHE_SIZE (4) // 4K
#define BLOCK_SIZE (16)

typedef string INPUT_T; // change different type may not work
vector<INPUT_T> D_Cache;
vector<INPUT_T> I_Cache;

int hit_num=0, miss_num=0, access_num=0;
int tag_digit = 8 - (int) log2(CACHE_SIZE*1024/BLOCK_SIZE) - (int) log2(BLOCK_SIZE),
    index_digit = (int) log2(CACHE_SIZE*1024/BLOCK_SIZE);

typedef struct element{
    int tag, index;
    element(){}
    element(string in){
        stringstream ss(in);
        ss << hex << in.substr(0, tag_digit);
        ss >> tag;
        ss << hex << in.substr(tag_digit, index_digit);
        ss >> index;
    }
} element;

void input(void){
    ifstream ifs;
    if(ifs.is_open()) throw("ifs has been already opened.\n");
    ifs.open("DCACHE.txt", ifstream::in);

    INPUT_T input;
    while(ifs >> input) D_Cache.push_back(input);
    ifs.close();


    if(ifs.is_open()) throw("ifs has been already opened.\n");
    ifs.open("ICACHE.txt", ifstream::in);
    while(ifs >> input) I_Cache.push_back(input);
    ifs.close();

    return;
}
void memory_access(void){
    vector<pair<bool, element>> map(CACHE_SIZE*1024/BLOCK_SIZE, pair<bool, element>(false, element()));

    for(int i=0; i<I_Cache.size(); i++){
        element access(I_Cache[i]);
        if(map[access.index].first==false){ // compulsory miss
            map[access.index].second = access;
            map[access.index].first = true;
            miss_num++;
        }
        else{
            if(map[access.index].second.tag==access.tag){
                hit_num++;
            }
            else{
                map[accee.index].second.tag = access.tag;
                miss_num++;
            }
        }
        access_num++;
    }

}
void print_result(void){
    float hit_rate = hit_num / access_num, miss_rate = miss_num / access_num;
    cout << "Cache_size: " << CACHE_SIZE << '\n' <<
            "Block_size: " << BLOCK_SIZE << '\n' <<
            "Hit rate: " << fixed << setprecision(2) << hit_rate  << "% (" << hit_num  << "),  " <<
            "Miss rate: " << miss_rate << "% (" << miss_num << ")\n";
    return;
}

int main(void){
    input();
    memory_access();
    print_result();
    return 0;
}