#!/bin/bash

Reset="\033[0m"
Green="\033[0;38;5;40m"

if [ ! -f "./compile_commands.json" ]; then
    printf "No compile_commands.json file found.\nRun 'bear -- make' first!"
    exit 1
fi

find src tests -name "*.cpp" | while read -r file; do
    printf "Linting $file...\n"

    clang-tidy --header-filter=^$ "$file" -p "." -- \
        -I/usr/include/c++/11 \
        -I/usr/include/x86_64-linux-gnu/c++/11 \
        -I/usr/lib/gcc/x86_64-linux-gnu/11/include \
        -I/usr/local/include \
        -I/usr/include \
        -Iinc \
        -std=c++17
    printf "${Green}Done!${Reset}\n\n"
done

