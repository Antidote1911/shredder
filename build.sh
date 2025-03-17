#!/usr/bin/env bash

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echo "${green}Choose to build in relese or debug mode${reset}"
read -p "0 - Release, 1 - Debug" compil_flag

if [[ $compil_flag == 0 ]]; then
  cmake -S . -B build -G "Ninja Multi-Config"
  cmake --build build --config Release
elif [[ $compil_flag == 1 ]]; then
  cmake -S . -B build -G "Ninja Multi-Config"
  cmake --build build --config Debug
fi
