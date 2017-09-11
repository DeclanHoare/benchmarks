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

nasm -felf64 factorialimpl.asm -ofactorialimpl-64.o

gcc -DFACTORIAL_RECURSIVE factorial.c -o factorial-recursive-gcc-64
clang -DFACTORIAL_RECURSIVE factorial.c -o factorial-recursive-clang-64

gcc -DFACTORIAL_WHILE factorial.c -o factorial-while-gcc-64
clang -DFACTORIAL_WHILE factorial.c -o factorial-while-clang-64

gcc -DFACTORIAL_ASM factorial.c factorialimpl-64.o -o factorial-asm-gcc-64
clang -DFACTORIAL_ASM factorial.c factorialimpl-64.o -o factorial-asm-clang-64

echo "64-bit Recursive C Implementation"
tryout "./factorial-recursive-gcc-64"
tryout "./factorial-recursive-clang-64"

echo "64-bit While Loop C Implementation"
tryout "./factorial-while-gcc-64"
tryout "./factorial-while-clang-64"

echo "64-bit Assembly Implementation"
tryout "./factorial-asm-gcc-64"
tryout "./factorial-asm-clang-64"

echo "Tests Complete"
