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
// stdstring.cpp - stress-test program for QString

#include <cstdlib>
#include <QString>

#define MSG "qwertyuiopasdfghjklzxcvbnm"

int main(int argc, char** argv)
{
	QString result;
	for (int16_t i = 0; i < INT16_MAX; i++)
		result += MSG;
	result = result.toUpper();
	return EXIT_SUCCESS;
}

