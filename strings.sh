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

g++ -m64 -std=c++11 stdstring.cpp -o stdstring-libstdc++-64
g++ -m32 -std=c++11 stdstring.cpp -o stdstring-libstdc++-32
clang++ -m64 -std=c++11 -stdlib=libc++ stdstring.cpp -o stdstring-libc++-64
WPP386=-xst owcc stdstring.cpp -o stdstring-owcpplib-32
g++ -m64 -std=c++11 stdstring.cpp -o stdwstring-libstdc++-64 -DTEST_WSTRING
g++ -m32 -std=c++11 stdstring.cpp -o stdwstring-libstdc++-32 -DTEST_WSTRING
clang++ -m64 -std=c++11 -stdlib=libc++ stdstring.cpp -o stdwstring-libc++-64 -DTEST_WSTRING
WPP386=-xst owcc stdstring.cpp -o stdwstring-owcpplib-32 -DTEST_WSTRING
g++ -fPIC -m64 -std=c++11 qstring.cpp -o qstring-libstdc++-64 $(pkg-config --cflags --libs Qt5Core)

tryout "./stdstring-libstdc++-64"
tryout "./stdstring-libstdc++-32"
tryout "./stdstring-libc++-64"
tryout "./stdstring-owcpplib-32"
tryout "./stdwstring-libstdc++-64"
tryout "./stdwstring-libstdc++-32"
tryout "./stdwstring-libc++-64"
tryout "./stdwstring-owcpplib-32"
tryout "./qstring-libstdc++-64"

echo "Tests Complete"
