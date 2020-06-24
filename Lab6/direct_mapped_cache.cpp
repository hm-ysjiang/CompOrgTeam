#include <vector>
#include <iostream>
#include <iomanip>
#include <fstream>
using namespace std;

#define CACHE_SIZE (16) // 4K
#define BLOCK_SIZE (64)

vector<unsigned int> D_Cache;
vector<unsigned int> I_Cache;

int block_num = CACHE_SIZE * 1024 / BLOCK_SIZE;

typedef struct element{
    bool valid;
    int tag, index;
    element(): valid(false), tag(0), index(0) {}
} element;

void input(void){
    ifstream ifs;
    if(ifs.is_open()) throw("ifs has been opened already.\n");
    ifs.open("DCACHE.txt", ifstream::in);

    unsigned int input;
    while(ifs >> hex >> input){
        input /= BLOCK_SIZE;
        D_Cache.push_back(input);
    }
    ifs.close();


    if(ifs.is_open()) throw("ifs has been opened already.\n");
    ifs.open("ICACHE.txt", ifstream::in);
    while(ifs >> hex >> input){
        input /= BLOCK_SIZE;
        I_Cache.push_back(input);
    }
    ifs.close();

    return;
}
void print_result(const int &hit_num, const int &miss_num){
    float hit_rate = (float) hit_num / (float)(hit_num + miss_num), miss_rate = (float) miss_num / (float)(hit_num + miss_num);
    cout << "Cache_size: " << CACHE_SIZE << '\n' <<
            "Block_size: " << BLOCK_SIZE << '\n' <<
            "Hit rate: " << fixed << setprecision(2) << hit_rate*100  << "% (" << hit_num  << "),  " <<
            "Miss rate: " << miss_rate*100 << "% (" << miss_num << ")\n";
    return;
}
void memory_access(char C){
    int hit_num = 0, miss_num = 0;
    if(C=='I'){
        vector<element> map(block_num, element());
        for(int i=0; i<I_Cache.size(); i++){
            unsigned int index = I_Cache[i] % block_num, tag = I_Cache[i] / block_num;
            if(map[index].valid==false){ // compulsory miss
                map[index].valid = true;
                map[index].index = index;
                map[index].tag = tag;
                miss_num++;
            }
            else{
                if(map[index].tag==tag){
                    hit_num++;
                }
                else{
                    map[index].tag = tag;
                    miss_num++;
                }
            }
        }
    
        cout << "I-Cache Access:\n";
    }
    else if(C=='D'){
        vector<element> map(block_num, element());
        for(int i=0; i<D_Cache.size(); i++){
            unsigned int index = D_Cache[i] % block_num, tag = D_Cache[i] / block_num;
            if(map[index].valid==false){ // compulsory miss
                map[index].index = index;
                map[index].tag = tag;
                miss_num++;
            }
            else{
                if(map[index].tag==tag){
                    hit_num++;
                }
                else{
                    map[index].tag = tag;
                    miss_num++;
                }
            }
        }
    
        cout << "D-Cache Access:\n";
    }
    else{ return; }
    print_result(hit_num, miss_num);

}

int main(void){
    input();
    memory_access('I');
    memory_access('D');
    return 0;
}