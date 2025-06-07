# Compiler and flags
CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++20
TESTFLAGS := -lgtest -lgtest_main -pthread

# Directory Names
OBJ_DIR = obj
SRC_DIR = src
BUILD_DIR = bin
TEST_DIR = tests
TOBJ_DIR = $(OBJ_DIR)/$(TEST_DIR)

# File paths
TARGET = $(BUILD_DIR)/main
TESTFILE = $(BUILD_DIR)/test

SRCS := $(wildcard $(SRC_DIR)/*.cpp)
MAIN_OBJ := $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SRCS))

MAIN_O = $(OBJ_DIR)/main.o $(INC_OBJ)
INC_OBJ := $(filter-out $(MAIN_O), $(MAIN_OBJ))

TEST_SRCS := $(wildcard $(TEST_DIR)/*.cpp)
TEST_OBJ := $(patsubst $(TEST_DIR)/%.cpp, $(TOBJ_DIR)/%.o, $(TEST_SRCS)) $(INC_OBJ)


# Bash Formatting: https://misc.flogisoft.com/bash/tip_colors_and_formatting
Reset=\033[0m
Red=\033[0;31m
Green=\033[0;38;5;40m
Yellow=\033[0;33m

# Phony Target Declaration
.PHONY: all run clean

# Default target
all: main

# Build target
$(TARGET): $(MAIN_OBJ)
	@mkdir -p $(BUILD_DIR)
	@printf "Compiling $(Yellow)main$(Reset) binary... "
	@$(CXX) $(CXXFLAGS) $(MAIN_OBJ) -o $@
	@printf "$(Green)success!$(Reset)\n"

# Compile source files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(OBJ_DIR)
	@printf "Compiling $(Yellow)$@$(Reset)... "
	@$(CXX) $(CXXFLAGS) -Iinc -c -o $@ $<
	@printf "$(Green)done$(Reset)\n" 

# Compile test files
$(OBJ_DIR)/tests/%.o: tests/%.cpp
	@mkdir -p $(OBJ_DIR)/tests
	@printf "Compiling $(Yellow)$@$(Reset)... "
	@$(CXX) $(CXXFLAGS) -Iinc -c -o $@ $<
	@printf "$(Green)done$(Reset)\n" 

# Run the executable, and build if necessary
run: $(TARGET)
	@printf "\n#### Running $(Yellow)main$(Reset) binary...\n\n"
	@./$<
	@printf "\n#### $(Green)Complete$(Reset)\n\n"

# Clean up
clean:
	@rm -rf $(BUILD_DIR)
	@rm -rf $(OBJ_DIR)
	@printf "Done!\n"

test: $(TESTFILE)
	@printf "\n#### Running $(Yellow)test$(Reset) binary...\n\n"
	@./$<
	@printf "\n#### $(Green)Complete$(Reset)\n\n"

$(TESTFILE): $(TEST_OBJ)
	@mkdir -p $(BUILD_DIR)
	@printf "Compiling $(Yellow)test$(Reset) binary...\n"
	@$(CXX) $(CXXFLAGS) -o $@ $^ $(TESTFLAGS)
	@printf "$(Green)Complete$(Reset)\n"


