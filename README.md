[![Build Status](https://ci.sw4j.net/jenkins/buildStatus/icon?job=Assembly/Multi Meltdown/master)](https://ci.sw4j.net/jenkins/job/Assembly/Multi Meltdown/master)

# Introduction

This project is to create some programs which reproduce the problems of the vulnerabilities
[Meltdown](https://meltdownattack.com/) and [Spectre](https://spectreattack.com/).

It contains some programs that try to reproduce the vulnerabilities described.

The main documentation is in the file
[Meltdown-Spectre.pdf](https://github.com/uweplonus/meltdown/blob/master/Meltdown-Spectre.pdf) which is the result of
[literate programming](https://en.wikipedia.org/wiki/Literate_programming). The source for this is the file
[Meltdown-Spectre.nw](https://github.com/uweplonus/meltdown/blob/master/Meltdown-Spectre.nw).

The generated programs can be found in `asm/`.

For the latest source codes and pdf look at the
[CI page](https://ci.sw4j.net/jenkins/job/Assembly/Multi Meltdown/master).

If you want to generate the programs yourself do a `make` at the top level folder. To generate the pdf file do a
`make pdf`.
