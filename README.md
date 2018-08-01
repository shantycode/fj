# FJ Shellscript subs
This project is based on [sub][1] from 37 signals.
Added the sub-sub command extension from [jeffreyroberts][2]

## Overview
* [Installation](#installation)
* [Basic Usage](#basic_usage)
* [Adding your own scripts](#own_scripts)

## Installation
How to get startet? It's easy: clone and install. :-)

For example, install `fj` in your `$HOME` directory:

```
cd
git clone git@git.company.com:foobar/fj.git .fj
```

For bash users:

```
echo 'eval "$($HOME/.fj/bin/fj init -)"' >> ~/.profile
echo 'alias jf=fj' >> ~/.profile
exec bash -l
```

For zsh users:

```
echo 'eval "$($HOME/.fj/bin/fj init -)"' >> ~/.zshenv
echo 'alias jf=fj' >> ~/.zshenv
source ~/.zshenv
```

Then install needed Gems:
```
cd ~
fj gemfile
bundle install
```

To use pgp encryption, do this steps

For zsh users:
```
echo "alias 'fj crypt pgp'='$HOME/.fj/libexc/fj-crypt/fj-pgp'" >> ~/.zshrc
```
For bash users:
```
echo "alias 'fj crypt pgp'='$HOME/.fj/libexc/fj-crypt/fj-pgp'" >> ~/.profile
```


Now you're ready to go... Oh, and shell completition is included and for free..
Why the alias you ask? Well, think about how often you type 'sl' instead of 'ls'... ;-)

## Basic Usage
After installing `fj` to your system call `fj commands` for a list of available commands.

```
client-218:~ $ fj commands
commands
completions
help
init
shell
cve
```

Get help for a command

```
client-218:~ $ fj help cve 
Usage: fj dns cve <ip-address|host>

Shows a list of CVE affected packages for the given host or IP address.
```

## Adding your own scripts
Just drop your scripts to `$HOME/.fj/libexec` (or wherever you installed this sub) and name them `fj-yourname`. Add executable flag to your `fj-yourname` (chmod +x `fj-yourname`). For examples have a look at the 37signals [sub github page][1]

[1]: https://github.com/37signals/sub
[2]: https://github.com/jeffreyroberts/sub

#### Make it easy to use for others

* add help to your commands
* Start each file with a description of its contents.
* Use TODO comments for code that is temporary, a short-term solution, or good-enough but not perfect.
* Comment tricky, non-obvious, interesting or important parts of your code.
* Post merge requests to colleagues using another OS

[mac os shell developer guide][3]

[styleguide shell][4]

##### If you use another programming language, the coding guidlines of the choosen programming language should be taken into account

[3]: https://developer.apple.com/library/content/documentation/OpenSource/Conceptual/ShellScripting/Introduction/Introduction.html
[4]: https://google.github.io/styleguide/shell.xml
