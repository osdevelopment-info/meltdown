# Introduction

This page gives a short overview of the programs. The times are mostly the result of using `rdtsc` of the processor.

# Programs

## cachetiming

`cachetiming` is a program that measures the access time of the memory when accessing cached values against uncached
values. The time for the cached access should be lower than the uncached access time.

Example output:
```
Cached Access Time: 116
Uncached Access Time: 528
```

## cachereadbyte

This program tries to read a byte via the cache access times. For this 256 bytes are read from memory and the lowest
cache access time is used. The output of the program shows the byte determined by the cache access times, the number of
bytes that have the lowest cache access time and the byte that was originally used to fill the cache. The expected
success rate is below 50%.

Example output:
```
Byte read via cache access:     04
Count of bytes with min timing: 1
Expected byte from data:        53
```

## cachebyteread2

This program is an intermediate program on the way to `cachereadbyte3`. This program defines a threshold that is above
the minimum cache access times which leads to a higher count with values below the threshold.

Example output:
```
Byte read via cache access:     ff
Count of bytes with min timing: 2
Expected byte from data:        b0
```

## cachereadbyte3

While the program `cachereadbyte2` simply returns the last byte found with the cache access time below a threshold this
program will retry the cache read when more than 1 result is found. This lowers the throughput but enhances the
reliability.

Example output:
```
Byte read via cache access:     9d
Expected byte from data:        9d
```

## cacheread

This program extends the program `cachereadbyte3` and reads a complete memory area. This program is there to determine
the algorithm of the byte read.

Example output (shortened):
```
ea 04 5b 5e a9 2a 0d e6 a5 4b 5d 28 11 cd 1c a4 - eb 04 5b 5e a9 2a 0d eb eb 4b 5d 28 11 eb 1c a4 
[snip]
f2 f5 96 f8 26 7a 3c e3 5a 0f 69 e3 7b ed c7 92 - eb eb 96 eb 26 7a 3c eb 00 00 00 00 00 00 00 00 
Failed read relation: 909/4096
```
