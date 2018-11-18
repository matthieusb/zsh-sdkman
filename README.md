# Sdkman Zsh plugin

This sdkman plugin aims at making sdkman usage easier with completion scripts.

TODO ADD A USAGE GIF HERE

## Installation

zsh-sdkman is not bundled with ZSH, so you need to install it.

### [Antigen](https://github.com/zsh-users/antigen)

This plugin can be installed by adding `antigen bundle matthieusb/zsh-zsdkman` to your `.zshrc` file. [Antigen](https://github.com/zsh-users/antigen) will handle cloning the plugin for you automatically the next time you start `zsh`. You can also add the plugin to a running ZSH session with `antigen bundle matthieusb/zsh-zsdkman` for testing before adding it to your `.zshrc`.

### [Zgen](https://github.com/tarjoilija/zgen)

This plugin can be installed by adding `zgen load matthieusb/zsh-zsdkman` to your `.zshrc` file in the same function you're doing your other `zgen load` calls in. [Zgen](https://github.com/tarjoilija/zgen) will automatically clone the repositories for you when you do a `zgen save`.


### [Simple Oh-My-Zsh](http://ohmyz.sh/)

Go to your *oh-my-zsh* folder and then in *custom/plugins* and clone this repository:

```
git clone https://github.com/matthieusb/zsh-sdkman.git
```

And then, add to to your *.zshrc* plugin list like this:

```
plugins=(... zsh-sdkman)
```

## Usage

Sdkman can be used as usual:

```
Usage: sdk <command> [candidate] [version]
       sdk offline <enable|disable>

   commands:
       install   or i    <candidate> [version]
       uninstall or rm   <candidate> <version>
       list      or ls   [candidate]
       use       or u    <candidate> [version]
       default   or d    <candidate> [version]
       current   or c    [candidate]
       upgrade   or ug   [candidate]
       version   or v
       broadcast or b
       help      or h
       offline           [enable|disable]
       selfupdate        [force]
       update
       flush             <broadcast|archives|temp>

   candidate  :  the SDK to install: groovy, scala, grails, gradle, kotlin, etc.
                 use list command for comprehensive list of candidates
                 eg: $ sdk list

   version    :  where optional, defaults to latest stable if not provided
                 eg: $ sdk install groovy
```

Some aliases are available:

```
TODO
```
