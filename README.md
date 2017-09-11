# benchmarks

Repo for automated benchmarks I want to share

## std::sort vs qsort

I found this Quora post

https://www.quora.com/What-is-the-most-efficient-way-to-sort-a-million-32-bit-integers/answer/Anders-Kaseorg

where somebody claimed that std::sort is significantly faster than 
qsort. I tested this myself.

I initially tried only GCC on 64-bit targets. You can see this in the
commit history.

```
./qsort: 1 loops, best of 100: 62.8 msec per loop
./stdsort: 1 loops, best of 100: 98.4 msec per loop
```

Across multiple runs the general result was that std::sort took about
30-40 milliseconds longer than qsort for the test case of sorting one
million integers from descending to ascending order.

However, after finding another compiler, called Open Watcom, I decided
to try more comprehensive tests. The new test is found in "sorts.sh" in
this version of the repo. I had to adjust my C test program to un-inline 
the declaration of i because Open Watcom fails horrendously when it sees
that syntax in a C program. It does not care in C++, however.

NOTE: "64-bit" and "32-bit" below refer to bitnesses of x86 and the test
assumes a host machine of x86_64 that is capable of compiling and
running x86_32 code. You will need GCC, Clang, and Open Watcom working
correctly for the tests to all work. "WCL" refers to Open Watcom - it
stands for Watcom Compiler & Linker.

```
64-bit C++ (Assumes 64-bit host)
./stdsort-gcc-64: 1 loops, best of 100: 98.8 msec per loop
./stdsort-clang-64: 1 loops, best of 100: 100 msec per loop
32-bit C++
./stdsort-gcc-32: 1 loops, best of 100: 93.9 msec per loop
./stdsort-clang-32: 1 loops, best of 100: 131 msec per loop
./stdsort-wcl-32: 1 loops, best of 100: 38.2 msec per loop
64-bit C
./qsort-gcc-64: 1 loops, best of 100: 68.4 msec per loop
./qsort-clang-64: 1 loops, best of 100: 63.2 msec per loop
32-bit C
./qsort-gcc-32: 1 loops, best of 100: 98.2 msec per loop
./qsort-clang-32: 1 loops, best of 100: 109 msec per loop
./qsort-wcl-32: 1 loops, best of 100: 87.8 msec per loop
Tests Complete
```

Clang was slower than GCC for C++ on both 32- and 64-bit targets.
On 64-bit the difference was negligible but on 32-bit it was quite wide.

On 64-bit targets with C, Clang was a bit faster than GCC but on 32-bit
it was slower.

WCL was faster than the other compilers for 32-bit on both C and C++, 
although it does not support 64-bit at all to my knowledge. Most 
impressively, WCL's std::sort is SIGNIFICANTLY faster than even Clang's 
64-bit qsort.

I'm using glibc for both Clang and GCC. WCL uses its own implementation
of the standard libraries.

## factorial

I was reading about basic x86_64 assembly using NASM

http://cs.lmu.edu/~ray/notes/nasmtutorial/

and I wanted to know if using assembly actually improved speed from
C for one of the examples, calculating factorials. I put together two
C implementations - one using the same recursive approach as the example
and one using a while loop. The tests can be run with "factorial.sh".

```
64-bit Recursive C Implementation
./factorial-recursive-gcc-64: 1 loops, best of 100: 3.72 msec per loop
./factorial-recursive-clang-64: 1 loops, best of 100: 4.03 msec per loop
64-bit While Loop C Implementation
./factorial-while-gcc-64: 1 loops, best of 100: 3.48 msec per loop
./factorial-while-clang-64: 1 loops, best of 100: 3.09 msec per loop
64-bit Assembly Implementation
./factorial-asm-gcc-64: 1 loops, best of 100: 8.63 msec per loop
./factorial-asm-clang-64: 1 loops, best of 100: 3.51 msec per loop
Tests Complete
```

The 8.63 ms outlier for `factorial-asm-gcc-64` can be chalked up to
blind chance, as there was usually one test that ran at around this
speed, but which test was different each time I ran the benchmarks.
Apart from that, every version tended to take about 3 to 4 milliseconds
per iteration.

## strings

I read a StackOverflow post

https://stackoverflow.com/questions/11028948/advantage-of-qstring-over-stdstring#comment-14421099

which states that QString is faster than std::string. Obviously one is
code and the other is a specification so it doesn't really make sense,
but I decided to try some implementations of std::string and
std::wstring to see how they stacked up.

This time, I looked more logically at the standard library rather than
the compiler. The three I tried were libstdc++ (using gcc), libc++
(using clang), and owcpplib (obviously using Open Watcom). You can run
these tests for yourself with "strings.sh".

```
./stdstring-libstdc++-64: 1 loops, best of 100: 24.3 msec per loop
./stdstring-libstdc++-32: 1 loops, best of 100: 25.8 msec per loop
./stdstring-libc++-64: 1 loops, best of 100: 14.5 msec per loop
./stdstring-owcpplib-32: 1 loops, best of 100: 8.08 msec per loop
./stdwstring-libstdc++-64: 1 loops, best of 100: 28.7 msec per loop
./stdwstring-libstdc++-32: 1 loops, best of 100: 31.9 msec per loop
./stdwstring-libc++-64: 1 loops, best of 100: 18.2 msec per loop
./stdwstring-owcpplib-32: 1 loops, best of 100: 9.24 msec per loop
./qstring-libstdc++-64: 1 loops, best of 100: 15.9 msec per loop
Tests Complete
```

Again, the fastest implementation by a wide margin was owcpplib.
Wide strings were slower than the counterpart char strings in each
standard library tested.
QString outperformed libstdc++'s std::string but was slower than the
std::string implementations in libc++ and owcpplib.
