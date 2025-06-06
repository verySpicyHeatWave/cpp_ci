TARGET ?= hello

# Compiler and flags
CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++20
LDFLAGS := -lgtest -lgtest_main -pthread

BUILD_DIR = obj
SRC_DIR = src
TEST_DIR = tests
INC_DIR = inc

SRCFILE = $(SRC_DIR)/$(TARGET).cpp
HDRFILE = ${INC_DIR}/$(TARGET).h
TESTFILE = $(TEST_DIR)/test_$(TARGET).cpp
OUTFILE = $(BUILD_DIR)/$(TARGET).o

Color_Off=\033[0m
Green=\033[0;32m
Yellow=\033[0;33m
Green_Goblin=\033[38;5;40m
Color=\033[38;5;196m

.PHONY: all run clean

# Default target
all: $(OUTFILE) Makefile

# Build target
$(OUTFILE): $(SRCFILE) $(HDRFILE) Makefile
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -o $(OUTFILE) $(SRCFILE)
	@printf "$(Yellow)Yo$(Color_Off)\n"

# Run that shit
run: $(OUTFILE) Makefile
	$(OUTFILE)

# Clean up
clean:
	rm -rf $(BUILD_DIR)

test: $(OUTFILE) $(TEST_DIR)/test_$(TARGET).cpp

