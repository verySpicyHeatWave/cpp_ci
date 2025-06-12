#include <gtest/gtest.h>
#include "add.hpp"
#include "hello.hpp"

TEST(AdditionTest, PositiveNumbers) {
    EXPECT_EQ(add(2 , 3), 5);
}

TEST(AdditionTest, NegativeNumbers) {
    EXPECT_EQ(add(-2, -3), -5);
}

TEST(AdditionTest, MixedSign) {
    EXPECT_EQ(add(-2, 3), 1);
}

TEST(HelloTest, ReturnsZero) {
    EXPECT_EQ(hello(), 0);
}

int main() {
    ::testing::InitGoogleTest();
    return RUN_ALL_TESTS();
}