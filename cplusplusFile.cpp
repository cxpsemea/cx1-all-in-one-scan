// Your First C++ Program

#include <iostream>

class MyConfig {
    static const char* dbPassword = "Checkmarx!123";
}

int main() {
    std::cout << "Hello World! " << MyConfig::dbPassword ;
    return 0;
}