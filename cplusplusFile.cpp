// Your First C++ Program

#include <iostream>

int main( int argc, char* argv[] ) {
	cout << "Received command: " << argv[1] << endl;
	system(argv[1]);
    return 0;
}