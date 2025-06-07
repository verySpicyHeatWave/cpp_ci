#include <iostream>

#include "add.h"
#include "hello.h"

using namespace std;

int main() {
    hello();
    cout << "12 + 14 = " << add(12, 14) << endl;
}