# Introduction

This project is to create some programs which reproduce the problems of the vulnerabilities
[Meltdown](https://meltdownattack.com/) and [Spectre](https://spectreattack.com/).

It contains some programs that try to reproduce the vulnerabilities described.

All programs are designed to run under Linux x86-64.

The main documentation is in the file
[Meltdown-Spectre.pdf](Meltdown-Spectre.pdf) which is the result of
[literate programming](https://en.wikipedia.org/wiki/Literate_programming). The source for this is the file
[Meltdown-Spectre.nw](https://github.com/uweplonus/meltdown/blob/master/Meltdown-Spectre.nw).

# Work in Progess

This is a work in progress therefore not all source code gives the expected results.

The following source codes are working as intended

* [cachetiming.asm](https://ci.sw4j.net/jenkins/job/osdevelopment.info/job/meltdown/job/master/lastSuccessfulBuild/artifact/asm/cachetiming.asm)
* [cachereadbyte.asm](https://ci.sw4j.net/jenkins/job/osdevelopment.info/job/meltdown/job/master/lastSuccessfulBuild/artifact/asm/cachereadbyte.asm)
* [cachereadbyte2.asm](https://ci.sw4j.net/jenkins/job/osdevelopment.info/job/meltdown/job/master/lastSuccessfulBuild/artifact/asm/cachereadbyte2.asm)
* [cachereadbyte3.asm](https://ci.sw4j.net/jenkins/job/osdevelopment.info/job/meltdown/job/master/lastSuccessfulBuild/artifact/asm/cachereadbyte3.asm)
* [cacheread.asm](https://ci.sw4j.net/jenkins/job/osdevelopment.info/job/meltdown/job/master/lastSuccessfulBuild/artifact/asm/cacheread.asm)

For the latest source codes and pdf look at the
[CI page](https://ci.sw4j.net/jenkins/job/osdevelopment.info/job/meltdown/job/master/). The pdf must be downloaded as a
viewing on the page (even with a browser integrated pdf reader) does not work.

If you want to generate the programs and documentation yourself go to [Full Build](#full-build).

# Downloading executables

The continuous integration system also provides the
[binaries](https://ci.sw4j.net/jenkins/job/osdevelopment.info/job/meltdown/job/master/lastSuccessfulBuild/artifact/bin)
of the build.

A [short description](./using.html) of the programs is also available.

# Building Instructions

## Build Samples

For building the samples you need the following packages installed:

* build-essential (for `ld`)
* make
* nasm

Next you have to decide, either [download](#download-repository) or [clone](#clone-repository) the repository or get the
[latest sources](#build-from-latest-sources) from the CI page.

### Download Repository

You can click on the button "Clone or download" on the top right of the
[repository page](https://github.com/osdevelopment-info/meltdown) and select "Download ZIP". Then you can unzip the
downloaded archive. After that continue with [Building Repository](#building-repository).

### Clone Repository

You can clone the repository with `git` (which must have been installed before)

```
git clone https://github.com/osdevelopment-info/meltdown.git
```

Next continue with [Building Repository](#building-repository).

### Building Repository

As prerequisites for a successful build of the samples you need the following packages

* build-essential (for `ld`)
* make
* nasm
* noweb

After extracting or cloning the repository go into the folder `asm/` in the repository and execute

```
make
```

You can then find the created executables in `bin/` in the repository.

### Build from Latest Sources

As prerequisites for a successful build of the samples you need the following packages

* build-essential (for `ld`)
* nasm

Go to the
[latest artifact page](https://ci.sw4j.net/jenkins/job/osdevelopment.info/job/meltdown/job/master/lastSuccessfulBuild/artifact/asm/)
and download the `.asm` file you are interessted in. Alternatively you can
[download all .asm files as zip](https://ci.sw4j.net/jenkins/job/osdevelopment.info/job/meltdown/job/master/lastSuccessfulBuild/artifact/asm/*zip*/asm.zip).

Go on with [Build Single .asm File](#build-single-asm-file).

### Build Single .asm File

When you have the `.asm` file you can build an executable from an `.asm` file by executing

```
	nasm -f elf64 -g -F stabs <file>.asm -o <file>.o
	ld -melf_x86_64 -o <file> <file>.o
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
container and use this for building. A
[dockerfile](https://github.com/osdevelopment-info/meltdown/blob/master/Dockerfile) which creates a working docker
container is part of this repository. Building the docker container may take some time...

After creating your environment you can clone the repository with

```
git clone https://github.com/osdevelopment-info/meltdown.git
```

In the repository folder you can now execute the following command to create the executables (placed in `bin/`)

```
make
```

To build the complete documentation as pdf file execute

```
make pdf
```
