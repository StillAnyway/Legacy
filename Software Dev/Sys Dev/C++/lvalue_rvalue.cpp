#include <iostream>
#include <string>

void accept_both_l_and_r_values_as_argument(std::string value){
	std::cout<<value;
}

void accept_only_l_value_as_argument(std::string &value){
	std::cout<<value;
}

void accepts_both_value_as_argument_by_adding_const(const std::string &value){
	std::cout<<value;
}

void accept_only_r_value_as_argument(std::string &&value){
	std::cout<<value;
}

int main(){
	// Principally, values which are stored at locations are called as lvalues

	std::string i = "C+++";
	// Here 'i' is lvalue and 'C+++' is rvalue
	std::string j = i;
	// Here both 'j' and 'i' are lvalues

	accept_both_l_and_r_values_as_argument(i);
	accept_both_l_and_r_values_as_argument("Python");

	accept_only_l_value_as_argument(i);
	// accept_only_l_value_as_argument("Python"); // Gives compile-time error

	// accept_only_r_value_as_argument(i); // Gives compile-time error
	accept_only_r_value_as_argument("Python");

	accepts_both_value_as_argument_by_adding_const(j);
	accepts_both_value_as_argument_by_adding_const("Python");

	return 0;
}
