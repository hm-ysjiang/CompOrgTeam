#include <fstream>
#include <iomanip>
#include <iostream>
#include <vector>

#define BLOCK_SIZE 64

using namespace std;

vector<uint32_t> _data;
int siz[] = {1, 2, 4, 8, 16, 32, 64},
    associa[] = {1, 2, 4, 8};

void readData() {
    ifstream in("LRU.txt", ios::in);
    uint32_t t;
    while (in >> hex >> t) {
        _data.push_back(t);
    }
    in.close();
}

void test(int cache_size_K, int associa_WAY) {
    int block_count = cache_size_K * 1024 / BLOCK_SIZE;
    int set_count = block_count / associa_WAY;
    vector<vector<uint32_t>> cache(set_count, vector<uint32_t>());
    int hit = 0, miss = 0;
    for (int i = 0; i < _data.size(); i++) {
        uint32_t t = _data[i];
        t /= BLOCK_SIZE;
        uint32_t cache_idx = t % set_count, tag = t / set_count;
        bool done = false;
        for (int j = 0; j < cache[cache_idx].size(); j++) {
            if (cache[cache_idx][j] == tag) {
                cache[cache_idx].erase(cache[cache_idx].begin() + j);
                cache[cache_idx].push_back(tag);
                done = true;
                hit++;
                break;
            }
        }
        if (!done && cache[cache_idx].size() < associa_WAY) {
            miss++;
            cache[cache_idx].push_back(tag);
            done = true;
        }
        else if (!done) {
            miss++;
            cache[cache_idx].erase(cache[cache_idx].begin());
            cache[cache_idx].push_back(tag);
        }
    }
    float hit_rate = (float)(hit) / (float)(hit + miss) * 100;
    cout << associa_WAY << "-Way" << endl
         << "Cache_size: " << cache_size_K << 'K' << endl
         << "Block_size: " << BLOCK_SIZE << endl
         << "Hit rate: " << fixed << setprecision(2) << hit_rate << "% (" << hit << "), Miss rate: " << (100.0F - hit_rate) << "% (" << miss << ")" << endl;
}

int main(void) {
    readData();
    for (int i = 0; i < 4; i++) {
        cout << "-------------------------\n";
        for (int j = 0; j < 7; j++) {
            test(siz[j], associa[i]);
        }
        cout << "-------------------------\n";
    }
    return 0;
}