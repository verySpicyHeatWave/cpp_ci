TARGET = hello

# Compiler and flags
CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++20

.PHONY: all
.PHONY: run
.PHONY: clean

# Default target
all: $(TARGET)

# Build target
$(TARGET): hello.cpp
	$(CXX) $(CXXFLAGS) -o $(TARGET) hello.cpp

# Run that shit
run:
	./$(TARGET)

# Clean up
clean:
	rm -f $(TARGET)