#include <fstream>
#include <iomanip>
#include <iostream>
#include <vector>

#define BLOCK_SIZE 64
#define SIZ_SIZE   8
#define TABLE_OUTPUT

using namespace std;

vector<uint32_t> _data;
int siz[] = {1, 2, 4, 8, 16, 32, 64, 128},
    associa[] = {1, 2, 4, 8};
float res[SIZ_SIZE][4];

void readData() {
    ifstream in("LRU.txt", ios::in);
    uint32_t t;
    while (in >> hex >> t) {
        _data.push_back(t);
    }
    in.close();
}

void test(int _cache_size_K, int _associa_WAY) {
    int cache_size_K = siz[_cache_size_K], associa_WAY = associa[_associa_WAY];
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
    res[_cache_size_K][_associa_WAY] = (float)(miss) / (float)(hit + miss);
}

int main(void) {
    readData();
    for (int i = 0; i < 4; i++) {
        cout << "-------------------------\n";
        for (int j = 0; j < SIZ_SIZE; j++) {
            test(j, i);
        }
        cout << "-------------------------\n";
    }

#ifdef TABLE_OUTPUT
    ofstream csv("set_asscia.csv", ios::out | ios::binary);
    csv << fixed << setprecision(4);
    csv << "/,1K,2K,4K,8K,16K,32K,64K";
    if (SIZ_SIZE == 8)
        csv << ",128K";
    csv << '\n';
    for (int i = 0; i < 4; i++) {
        csv << associa[i] << "-way";
        for (int j = 0; j < SIZ_SIZE; j++) {
            csv << ',' << res[j][i];
        }
        csv << '\n';
    }
    csv.flush();
    csv.close();
#endif

    return 0;
}