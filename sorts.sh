#!/bin/sh -e
# Copyright 2017 Declan Hoare
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http:#www.gnu.org/licenses/>.

. ./tryout.sh

echo "Compiling Tests"

gcc qsort.c -o qsort-gcc-64
g++ stdsort.cpp -o stdsort-gcc-64

gcc qsort.c -m32 -o qsort-gcc-32
g++ stdsort.cpp -m32 -o stdsort-gcc-32

clang qsort.c -o qsort-clang-64
clang++ stdsort.cpp -o stdsort-clang-64 -std=c++11

clang qsort.c -m32 -o qsort-clang-32
clang++ stdsort.cpp -m32 -o stdsort-clang-32 -std=c++11

wcl386 qsort.c
mv qsort qsort-wcl-32

wcl386 stdsort.cpp
mv stdsort stdsort-wcl-32

echo "64-bit C++ (Assumes 64-bit host)"
tryout "./stdsort-gcc-64"
tryout "./stdsort-clang-64"

echo "32-bit C++"
tryout "./stdsort-gcc-32"
tryout "./stdsort-clang-32"
tryout "./stdsort-wcl-32"

echo "64-bit C"
tryout "./qsort-gcc-64"
tryout "./qsort-clang-64"

echo "32-bit C"
tryout "./qsort-gcc-32"
tryout "./qsort-clang-32"
tryout "./qsort-wcl-32"

echo "Tests Complete"
