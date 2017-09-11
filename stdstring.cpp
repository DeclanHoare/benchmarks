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
// stdstring.cpp - stress-test program for std::string and std::wstring

#include <string>
#include <algorithm>
#include <cstdlib>
#include <cstdint>

#ifdef TEST_WSTRING
#include <cwctype>
#define ALGO_TOUPPER_FUN towupper
typedef std::wstring teststring;
#define MSG L"qwertyuiopasdfghjklzxcvbnm"
#else
#include <cctype>
#define ALGO_TOUPPER_FUN toupper
typedef std::string teststring;
#define MSG "qwertyuiopasdfghjklzxcvbnm"
#endif

// Work around compile errors in Open Watcom.
#ifdef __WATCOMC__
#include <climits>
#define ALGO_TOUPPER std::ALGO_TOUPPER_FUN
#define INT16_MAX SHRT_MAX
#else
#define ALGO_TOUPPER ::ALGO_TOUPPER_FUN
#endif

int main(int argc, char** argv)
{
	teststring result;
	for (int16_t i = 0; i < INT16_MAX; i++)
		result += MSG;
	std::transform(result.begin(), result.end(), result.begin(), ALGO_TOUPPER);
	return EXIT_SUCCESS;
}

