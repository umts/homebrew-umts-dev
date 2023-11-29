# UMTS Developer Workstation Setup

This repository is a [Homebrew][hb] [tap][tap] for performing the "last mile"
setup of a UMass Transportation developer workstation.

We use [Strap][strap] to handle most of our configuration, but its authors hold
the (reasonable) stance that _specific_ development tools should live in the
project repositories that require them.

However, from a pragmatic standpoint, we have very green developers, and we
almost exclusively develop Rails applications. So, we break with Strap's
convention in order to get folks a happy path to a working `rails new`
tutorial.

## The `umts-dev` Cask

Essentially, a no-op [cask][cask] that:

1. Depends on [`nodenv`][nodenv] and [`rbenv`][rbenv]
2. Runs the `umts-dev-setup` command below

```sh
brew install --cask umts-dev
```

## The `umts-dev-setup` external command

A brew "[external command][extcom]" that performs some post-install steps:

1. Adds the shell-initialization for both `nodenv` and `rbenv`
2. Installs the most recent Ruby
3. Sets that Ruby as `rbenv`'s global default

```sh
brew umts-dev-setup
```

## Integration with Strap

* Set the `CUSTOM_HOMEBREW_TAP` environment variable to "`umts/umts-dev`"
* Set the `CUSTOM_BREW_COMMAND` environment variable to "`install --cask umts-dev`"

[hb]: https://brew.sh/
[tap]: https://docs.brew.sh/Taps
[strap]: https://github.com/MikeMcQuaid/strap
[cask]: https://docs.brew.sh/Cask-Cookbook
[nodenv]: https://github.com/nodenv/nodenv
[rbenv]: https://github.com/rbenv/rbenv
[extcom]: https://docs.brew.sh/External-Commands
