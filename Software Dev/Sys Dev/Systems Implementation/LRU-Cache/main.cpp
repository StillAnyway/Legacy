#include <iostream>
#include <list>
#include <unordered_map>
#define CACHE_SIZE 5
using namespace std;

int main(){
	list<int> cache;
	unordered_map<int, list<int>::iterator > cache_reference;
	while(true){
		int num;
		cin>>num;
		auto it = cache_reference.find(num);
		if(it != cache_reference.end()){
			cout<<"Cache hit: ";
			cout<<*it->second<<endl;
			if(cache.front() != num){
				cache.splice(cache.begin(), cache, it->second);
			}
		}
		else{
			cout<<"Cache miss!\n";
			if(cache.size() == CACHE_SIZE){
				cache_reference.erase(cache.back());
				cache.pop_back();
			}
			cache.push_front(num);
			cache_reference.emplace(num, cache.begin());
		}
		// for(auto l: cache){cout<<l<<" ";}
		cout<<endl;
	}
	return 0;
}
