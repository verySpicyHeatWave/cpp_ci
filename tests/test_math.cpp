#include <gtest/gtest.h>
#include "inc/math.h"

TEST(AdditionTest, PositiveNumbers) {
    EXPECT_EQ(add(2, 3), 5);
}

TEST(AdditionTest, NegativeNumbers) {
    EXPECT_EQ(add(-2, -3), -5);
}

TEST(AdditionTest, MixedSign) {
    EXPECT_EQ(add(-2, 3), 1);
}