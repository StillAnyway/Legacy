#include <iostream>

class Car {
	public:
		char m;
		Car(char x){
			m = x;
		}
};

int main(){
	Car a1 = Car('a');
	std::cout<<a1.m; // output = a
	Car b1 = a1;
	b1.m = 'b';
	std::cout<<a1.m; // output = a
	std::cout<<b1.m; // output = b
	std::cout<<std::endl;

	Car *a2 = new Car('a');
	std::cout<<a2->m; // output = a
	Car *b2 = a2;
	b2->m = 'b';
	std::cout<<a1.m; // output = b
	std::cout<<b1.m; // output = b
	std::cout<<std::endl;

	return 0;
}
