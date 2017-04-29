# benchmarks

Repo for automated benchmarks I want to share

## std::sort vs qsort

I found this quora post

https://www.quora.com/What-is-the-most-efficient-way-to-sort-a-million-32-bit-integers/answer/Anders-Kaseorg

where somebody claimed that std::sort is significantly faster than 
qsort. I tested this myself and did not get the same outcome.

The script for these benchmarks is called "sorts.sh", and on my machine
the output is:

```
./qsort: 1 loops, best of 100: 78.8 msec per loop
./stdsort: 1 loops, best of 100: 111 msec per loop
```

Across multiple runs the general result was that std::sort took about 30
milliseconds longer than qsort.
