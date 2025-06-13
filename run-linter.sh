#!/bin/bash

Reset="\033[0m"
Green="\033[0;38;5;40m"
Yellow="\033[0;33m"

if [ ! -f "./compile_commands.json" ]; then
    printf "No compile_commands.json file found.\nRun 'bear -- make' first!\n"
    exit 1
fi

find src tests -name "*.cpp" | while read -r file; do
    printf "Linting ${Yellow}$file${Reset}...\n"

    clang-tidy --header-filter=^$ "$file" -p "." -- \
        -I/usr/include/c++/11 \
        -Iinc \
        -std=c++17
    printf "${Green}Done!${Reset}\n\n"
done
