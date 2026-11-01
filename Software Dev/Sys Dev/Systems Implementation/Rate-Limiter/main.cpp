// Improve memory management, keep it bounded
// Either introduce mutex or keep single-threaded (on-demand clean up)
#include <algorithm>
#include <cstddef>
#include <ctime>
#include <functional>
#include <iostream>
#include <deque>
#include <map>
#include <string>
#include <thread>
#include <vector>
#define RATE_LIMIT_WINDOW 30
#define RATE_LIMIT_LOGIN_THRESHOLD 3
#define RATE_LIMIT_API_THRESHOLD 10
#define REQUEST_DELIMITER ':'
#define RLE "429: Rate limit exceeded\n"
#define SUCCESS "200: Request served successfully\n"
#define BAD "400: Bad request\n"
using namespace std;

void shrink_window(map<time_t, pair<vector<string>, vector<string> >  > &timestampIPAddressesMapper, map<string, int> &ipAddressCountMapper, map<string, int> &loginCounts){
	time_t now = time(nullptr);
	while(true){
		time_t then = time(nullptr);
		if(now != then){
			for(auto const &ip: timestampIPAddressesMapper[now-RATE_LIMIT_WINDOW].first){
				ipAddressCountMapper[ip]--;
			}
			for(auto const &username: timestampIPAddressesMapper[now-RATE_LIMIT_WINDOW].second){
				loginCounts[username]--;
			}
			now = then;
		}
	}
}

bool parse_request(string const &request, string &ip, string &method, string &username){
	auto pos = request.find(REQUEST_DELIMITER);
	if(pos == request.npos){
		cout<<BAD;
		return false;
	}
	ip = request.substr(0, pos);
	method = request.substr(pos+1, request.size());
	pos = method.find(REQUEST_DELIMITER);
	if(pos != method.npos){
		username = method.substr(pos+1, method.size());
		while(method[method.size()-1] != REQUEST_DELIMITER){
			method.pop_back();
		}
		method.pop_back();
	}
	return true;
}

void server(map<time_t, pair<vector<string>, vector<string> > > &timestampIPAddressesMapper, map<string, int> &ipAddressCountMapper, map<string, int> &loginCounts){
	cout<<"Server starts as a thread\n";
	while(true){
		string s, ip, method, username;
		cin>>s;
		if(parse_request(s, ip, method, username)){
			time_t now = time(nullptr);
			timestampIPAddressesMapper[now].first.push_back(ip);
			ipAddressCountMapper[ip]++;
			if(ipAddressCountMapper[ip] > RATE_LIMIT_API_THRESHOLD){
				cout<<RLE;
			}
			else{
				if(username.empty()){
					cout<<SUCCESS;
				}
				else{
					timestampIPAddressesMapper[now].second.push_back(username);
					loginCounts[username]++;
					if(loginCounts[username] > RATE_LIMIT_LOGIN_THRESHOLD){
						cout<<RLE;
					}
					else{
						cout<<SUCCESS;
					}
				}
			}
		}
	}
}

int main(){
	map<time_t, pair<vector<string>, vector<string> > > timestampIPAddressesMapper;
	map<string, int> ipAddressCountMapper;
	map<string, int> loginCounts;
	thread t1(server, ref(timestampIPAddressesMapper), ref(ipAddressCountMapper), ref(loginCounts));
	thread t2(shrink_window, ref(timestampIPAddressesMapper), ref(ipAddressCountMapper), ref(loginCounts));
	while(true){}
	return 0;
}
