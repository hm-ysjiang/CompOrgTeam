#include <vector>
#include <iostream>
#include <iomanip>
#include <fstream>
using namespace std;

int cache[] = {4, 16, 64, 256},
    block[] = {16, 32, 64, 128, 256};

vector<unsigned int> D_Cache;
vector<unsigned int> I_Cache;


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
        D_Cache.push_back(input);
    }
    ifs.close();


    if(ifs.is_open()) throw("ifs has been opened already.\n");
    ifs.open("ICACHE.txt", ifstream::in);
    while(ifs >> hex >> input){
        I_Cache.push_back(input);
    }
    ifs.close();

    return;
}
void print_result(const int &hit_num, const int &miss_num, const int &cache_size, const int &block_size){
    float hit_rate = (float) hit_num / (float)(hit_num + miss_num), miss_rate = (float) miss_num / (float)(hit_num + miss_num);
    cout << "Cache_size: " << cache_size << '\n' <<
            "Block_size: " << block_size << '\n' <<
            "Hit rate: " << fixed << setprecision(2) << hit_rate*100  << "% (" << hit_num  << "),  " <<
            "Miss rate: " << miss_rate*100 << "% (" << miss_num << ")\n\n";
    return;
}
void memory_access(const char &C, const unsigned int &cache_size, const unsigned int &block_size){
    int hit_num = 0, miss_num = 0, block_num = cache_size * 1024 / block_size;
    if(C=='I'){
        vector<element> map(block_num, element());
        for(int i=0; i<I_Cache.size(); i++){
            unsigned int in = I_Cache[i] / block_size;
            unsigned int index = in % block_num, tag = in / block_num;
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
    
    }
    else if(C=='D'){
        vector<element> map(block_num, element());
        for(int i=0; i<D_Cache.size(); i++){
            unsigned int in = D_Cache[i] / block_size;
            unsigned int index = in % block_num, tag = in / block_num;
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
    
    }
    else{ return; }
    print_result(hit_num, miss_num, cache_size, block_size);

}

int main(void){
    input();
    cout << "-----I-Cache Access-----\n\n";
    for(int i=0; i<4; i++)
        for(int j=0; j<5; j++){
            memory_access('I', cache[i], block[j]);
        }
    cout << "-----D-Cache Access-----\n\n";
    for(int i=0; i<4; i++)
        for(int j=0; j<5; j++){
            memory_access('D', cache[i], block[j]);
        }
    return 0;
}