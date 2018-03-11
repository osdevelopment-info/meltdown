[![Build Status](https://ci.sw4j.net/jenkins/buildStatus/icon?job=Assembly/Multi%20Meltdown/master)](https://ci.sw4j.net/jenkins/job/Assembly/job/Multi%20Meltdown/job/master/)

# Introduction

This project is to create some programs which reproduce the problems of the vulnerabilities
[Meltdown](https://meltdownattack.com/) and [Spectre](https://spectreattack.com/).

It contains some programs that try to reproduce the vulnerabilities described.

All programs are designed to run under Linux x86-64.

The main documentation is in the file
[Meltdown-Spectre.pdf](https://github.com/uweplonus/meltdown/blob/master/Meltdown-Spectre.pdf) which is the result of
[literate programming](https://en.wikipedia.org/wiki/Literate_programming). The source for this is the file
[Meltdown-Spectre.nw](https://github.com/uweplonus/meltdown/blob/master/Meltdown-Spectre.nw).

The generated programs can be found in `asm/`.

For the latest source codes and pdf look at the
[CI page](https://ci.sw4j.net/jenkins/job/Assembly/job/Multi%20Meltdown/job/master/).

If you want to generate the programs and socumentation youself go to [Full Build]().

# Building Instructions

## Build Samples

For building the samples you need the following packages installed:

* build-essential (for `ld`)
* make
* nasm

Next you have to decide, either [download]() or [clone]() the repository or get the [latest sources]() from the CI page.

### Download Repository

You can click on the button on the top right and select "Download ZIP". Then you can unzip the downloaded archive. After
that continue with [Building Repository]().

### Clone Repository

You can clone the repository with `git` (which must have been installed before)

```
git clone https://github.com/uweplonus/meltdown.git
```

Next continue with [Building Repository]().

### Building Repository

After extracting or cloning the repository go into the folder `asm/` in the repository and execute

```
make
```

You can then find the created executables in `bin/` in the repository.

### Build from Latest Sources

Go to the
[latest artifact page](https://ci.sw4j.net/jenkins/job/Assembly/job/Multi%20Meltdown/job/master/lastSuccessfulBuild/artifact/asm/)
and download the `.asm` file you are interessted in. Alternatively you can
[download all .asm files as zip](https://ci.sw4j.net/jenkins/job/Assembly/job/Multi%20Meltdown/job/master/lastSuccessfulBuild/artifact/asm/*zip*/asm.zip).

Go on with [Build Single .asm File]().

### Build Single .asm File

When you have the `.asm` file you can build an executable from an `.asm` file by executing

```
	nasm -f elf64 -g -F stabs <file>.asm -o <file>.o
	ls -melf_x86_64 -o <file> <file>.o
```

Now you have an executable `<file>` which you can execute.

## Full Build

As prerequisites for a successful complete usage you need the following packages

* git
* build-essential (for `ld`)
* make
* nasm
* texlive-full (for the complete documentation)
* noweb

If you cannot install all packages (e.g. in CentOS) then you can alternatively create a [docker](https://docker.io)
container and use this for building. A [dockerfile](Dockerfile) which creates a working docker container is part of this
repository. Building the docker container may take some time...

After creating your environment you can clone the repository with

```
git clone https://github.com/uweplonus/meltdown.git
```

In the repository folder you can now execute the following command to create the executables (placed in `bin/`)

```
make
```

To build the complete documentation as pdf file execute

```
make pdf
```
