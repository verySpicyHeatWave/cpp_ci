#######################################################################
#           VARIABLE DECLARATIONS                                     #
#######################################################################

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



#######################################################################
#           PHONY TARGETS                                             #
#######################################################################

# Phony Declarations
.PHONY: all run lint clean test

# Default target (just builds the project)
all: $(TARGET)

# Run the executable, and build if necessary
run: $(TARGET)
	@printf "\n#### Running $(Yellow)main$(Reset) binary...\n\n"
	@./$<
	@printf "\n#### $(Green)Complete$(Reset)\n\n"

# Clean up the working directory
clean:
	@printf "Cleaning up repo... "
	@rm -rf $(BUILD_DIR)
	@rm -rf $(OBJ_DIR)
	@rm -f compile_commands.json
	@printf "Complete.\n"

# Run the linter on all of the files
lint: compile_commands.json
	@./run-linter.sh

# Run all of the tests in the test suite
test: $(TESTFILE)
	@printf "\n#### Running $(Yellow)test$(Reset) binary...\n\n"
	@./$<
	@printf "\n#### $(Green)Complete$(Reset)\n\n"



#######################################################################
#           REAL TARGETS                                              #
#######################################################################

# Build the main executable
$(TARGET): $(MAIN_OBJ)
	@mkdir -p $(BUILD_DIR)
	@printf "Compiling $(Yellow)main$(Reset) binary... "
	@$(CXX) $(CXXFLAGS) $(MAIN_OBJ) -o $@
	@printf "$(Green)success!$(Reset)\n"

# Compile the source files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(OBJ_DIR)
	@printf "Compiling $(Yellow)$@$(Reset)... "
	@$(CXX) $(CXXFLAGS) -Iinc -c -o $@ $<
	@printf "$(Green)done$(Reset)\n" 

# Build the test executable
$(TESTFILE): $(TEST_OBJ)
	@mkdir -p $(BUILD_DIR)
	@printf "Compiling $(Yellow)test$(Reset) binary...\n"
	@$(CXX) $(CXXFLAGS) -o $@ $^ $(TESTFLAGS)
	@printf "$(Green)Complete$(Reset)\n"

# Compile the test files
$(OBJ_DIR)/tests/%.o: tests/%.cpp
	@mkdir -p $(OBJ_DIR)/tests
	@printf "Compiling $(Yellow)$@$(Reset)... "
	@$(CXX) $(CXXFLAGS) -Iinc -c -o $@ $<
	@printf "$(Green)done$(Reset)\n" 

# Generate this config file for clang-tidy
compile_commands.json:
	@bear -- make
