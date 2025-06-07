TARGET ?= hello

# Compiler and flags
CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++20
LDFLAGS := -lgtest -lgtest_main -pthread

# Directory Names
BUILD_DIR = obj
SRC_DIR = src
TEST_DIR = tests
INC_DIR = inc

# File paths
SRCFILE = $(SRC_DIR)/$(TARGET).cpp
HDRFILE = ${INC_DIR}/$(TARGET).h
TESTFILE = $(TEST_DIR)/test_$(TARGET).cpp
OUTFILE = $(BUILD_DIR)/$(TARGET).o

# Bash Formatting: https://misc.flogisoft.com/bash/tip_colors_and_formatting
Reset=\033[0m
Red=\033[0;31m
Green=\033[0;38;5;40m
Yellow=\033[0;33m
Green_Goblin=\033[38;5;40m
Color=\033[38;5;196m


# Build target
$(OUTFILE): $(SRCFILE) $(HDRFILE) Makefile
	@printf "Creating $(Yellow)$(BUILD_DIR)$(Reset) directory if necessary\n"
	@mkdir -p $(BUILD_DIR)
	@printf "Compiling $(Yellow)$(OUTFILE)$(Reset)...\n"
	@$(CXX) $(CXXFLAGS) -o $(OUTFILE) $(SRCFILE)
	@printf "$(Green)Complete$(Reset)\n"

# Phony Targets
.PHONY: all run clean

# Default target
all: $(OUTFILE) Makefile

# Run that shit
run: $(OUTFILE) Makefile
	@printf "Running $(Yellow)$(OUTFILE)$(Reset)...\n"
	@$(OUTFILE)
	@printf "$(Green)Complete$(Reset)\n"

# Clean up
clean:
	@rm -rf $(BUILD_DIR)
	@printf "Deleted $(Red)$(BUILD_DIR)$(Reset) directory\n"
	@printf "$(Green)Complete$(Reset)\n"

test: $(OUTFILE) $(TEST_DIR)/test_$(TARGET).cpp
	$(TEST_DIR)/test_$(TARGET).cpp

