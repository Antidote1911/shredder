#!/usr/bin/env bash

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echo "${green}Choose to build in relese or debug mode${reset}"
read -p "0 - Release, 1 - Debug" compil_flag

if [[ $compil_flag == 0 ]]; then
  cmake -S . -B build/release -D CMAKE_BUILD_TYPE=Release
  cmake --build build/release
elif [[ $compil_flag == 1 ]]; then
  cmake -S . -B build/debug -D CMAKE_BUILD_TYPE=Debug
  cmake --build build/debug
fi
