#include <iostream>
#include "add.hpp"
#include "hello.hpp"

int main() {
    hello();
    std::cout << "12 + 14 = " << add(12, 14) << "\n";
}