#include <iostream>
#include <string>
#include <memory>

// Use a struct only for passive objects that carry data; everything else is a class.

class Hollow_Knight {
	private:
		// Add __ prefix to private variables
		int __level;
		std::string __name;
	public:
		// This is member initialisation list constructor
		Hollow_Knight(int level, std::string name) : __level(level), __name(name.append("_san")){}

		// This is destructor
		~Hollow_Knight(){std::cout<<this->name()<<" destroyed\n";}

		// Prefer declaring methods as const
		int level() const {return this->__level;}

		virtual std::string name(){
			return this->__name;
		}

		// Operator overloading
		Hollow_Knight operator+(const Hollow_Knight &h){
			Hollow_Knight returner(0, this->name().append(h.__name));
			returner.__level = h.level()+this->level();
			return returner;
		}
};

class Player: public Hollow_Knight {
	// Constructors and Destructors aren't inherited by default
	using Hollow_Knight::Hollow_Knight;
};

class Enemy: private Hollow_Knight {
	public:
		Enemy(int level) : Hollow_Knight(level, ""){}

		// Overriding base class function
		std::string name(){return "Enemy";}
};

int main(){
	// 3 ways to create an object

	Hollow_Knight hk(10, "Wall");
	std::unique_ptr<Player> p = std::make_unique<Player>(5, "Pranav");
	Enemy e = 5;

	// I am going to prefer the first one and the second one
	std::cout<<hk.name()<<std::endl;
	std::cout<<p->level()<<") "<<e.name()<<std::endl;

	// Operator Overloading in action
	Hollow_Knight hk2(5, "_appended");
	Hollow_Knight hk_add = hk+hk2;
	std::cout<<hk_add.name()<<" "<<hk_add.level()<<std::endl;

	return 0;
}
