// Copyright 2017 Declan Hoare
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
// stdsort.cpp - a C++ example program to fill an array from 1,000,000
// to 1 and then sort it in ascending order with std::sort

#include <algorithm>

int main()
{
	unsigned long nums[1000000];
	for (unsigned long i = 0; i < 1000000; i++)
	{
		nums[i] = 1000000 - i;
	}
	std::sort(nums, nums + 1000000);
	return 0;
}

