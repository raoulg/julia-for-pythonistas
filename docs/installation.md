# Assumptions
This tutorial assumes you already have an IDE like [[VScode | https://code.visualstudio.com/]] installed. If you don't have an IDE, you can use the Julia REPL, which is a command-line interface to Julia. However, this makes it more difficult to run scripts line-by-line, which is a nice addition from VScode to just the REPL. More about the REPL can be found [[REPL.md | here]] in the `REPL.md` file.

It also assumes you know what a command line is. VScode will give you one. Please avoid the "windows powershell" and use either bash or zsh. If you dont have a terminal, VScode will provide you one. It is also possible to install https://gitforwindows.org/ if you are somehow lured into using a windows OS.

# Installation
## Option 1: manual download
Juliaup makes it easier to install specific Julia versions, and to update new releases. Installing and managing Julia versions (eg beta versions etc) becomes more streamlined, but is not necessary; simply downloading an installer from the [Julia website](https://julialang.org/downloads/) is also fine.

## Option 2: using juliaup
If you want to use juliaup, you can find the specific ways to install this for your OS on the [juliaup](https://github.com/JuliaLang/juliaup) github page. You could also install it manually with `curl -fsSL https://install.julialang.org | sh` from your terminal or download the binaries from the [Julia website](https://julialang.org/downloads/).

I like to use the `release` channel which always gives me the latest version. People coming from Python might be afraid to use the latest version, however, in Julia, this is not a problem. The language is stable and the package manager is good at managing dependencies.
