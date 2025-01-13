# Sdkman Zsh plugin

This sdkman plugin aims at making [sdkman](https://sdkman.io) usage easier with completion scripts.

> 👷 Usage gif is out of date

![zsh-sdkman usage gif](./zsh-sdkman-usage.gif?raw=true "zsh-sdkman usage gif with several command examples")
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fmatthieusb%2Fzsh-sdkman.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fmatthieusb%2Fzsh-sdkman?ref=badge_shield)

## Installation

zsh-sdkman is not bundled with ZSH, so you need to install it.

### [Antigen](https://github.com/zsh-users/antigen)

- Add the following to your `.zshrc` file:
```zsh
antigen bundle matthieusb/zsh-sdkman
```
- Then, reload your terminal or run `zsh` to load the plugin.

You can also add the plugin to a running ZSH session with `antigen bundle matthieusb/zsh-sdkman` for testing before adding it to your `.zshrc`.

### [Zgen](https://github.com/tarjoilija/zgen)

- Add the following to your `.zshrc` file:
```zsh
zgen load matthieusb/zsh-sdkman
```
- Then, reload your terminal or run `zsh` to load the plugin.

### [Simple Oh-My-Zsh/Manual install](http://ohmyz.sh/)

- Move to your `oh-my-zsh` home folder, then in `custom/plugins` folder
- Clone this repository:
```
git clone https://github.com/matthieusb/zsh-sdkman.git
```

- And then, add the plugin to your`.zshrc` this:
```
plugins=(... zsh-sdkman)
```

> 🚨 Cloning of zsh-sdkman requires the [Git Large File Storage](https://git-lfs.github.com/) Git extension.

## Dependencies

* [sdkman](https://sdkman.io/) of course 
* `date`
* `grep`
* `egrep`
* `sed`
* `awk`

## Usage

> 👷 TODO

### Usage help

Sdkman can be used as usual:
```
SYNOPSIS
    sdk <subcommand> [candidate] [version]
   candidate  :  the SDK to install: groovy, scala, grails, gradle, kotlin, etc.
                 use list command for comprehensive list of candidates
                 eg: $ sdk list

   version    :  where optional, defaults to latest stable if not provided
                 eg: $ sdk install groovy

SUBCOMMANDS & QUALIFIERS
    help         [subcommand]
    install      <candidate> [version] [path]
    uninstall    <candidate> <version>
    list         [candidate]
    use          <candidate> <version>
    config       no qualifier
    default      <candidate> [version]
    home         <candidate> <version>
    env          [init|install|clear]
    current      [candidate]
    upgrade      [candidate]
    version      no qualifier
    offline      [enable|disable]
    selfupdate   [force]
    update       no qualifier
    flush        [tmp|metadata|version]

EXAMPLES
    sdk install java 17.0.0-tem
    sdk help install
```

Some aliases are available through this plugin:
```
alias sdki='sdk install'
alias sdkun='sdk uninstall'
alias list='sdk list'
alias sdku='sdk use'
alias sdkd='sdk default'
alias sdkc='sdk current'
alias sdkup='sdk upgrade'
alias sdkv='sdk version'
alias sdkb='sdk broadcast'
alias sdko='sdk offline'
alias sdksu='sdk selfupdate'
alias sdkf='sdk flush'
```

## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fmatthieusb%2Fzsh-sdkman.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fmatthieusb%2Fzsh-sdkman?ref=badge_large)
