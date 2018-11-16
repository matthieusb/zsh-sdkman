# Sdkman Zsh plugin

This sdkman plugin aims at making sdkman usage easier with completion scripts.

TODO ADD A GIF HERE

## Installation

skman plugin is not bundled with zsh, so you need to clone it. Go to your *oh-my-zsh* folder and then in *custom/plugins* and clone this repository:

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
