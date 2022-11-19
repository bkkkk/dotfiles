# Jacobo Blanco's Dotfiles

These dotfiles are (like most other dotfiles) cobbled together from different dotfiles with a bunch of customization.

One interesting component of this setup is the use of [bare git repositories](https://www.atlassian.com/git/tutorials/dotfiles) to avoid the need to link various system configuration files.

## What is included?

* Git configuration
* Alfred workflows
* Brew application setup
* Oh My ZSH setup
* Spaceship prompt

## Setup

Prior to the installation make sure you have committed the alias to your .zsh:

```shell
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

And that your source repository ignores the folder where you'll clone it, so that you don't create weird recursion problems:

```
echo ".cfg" >> .gitignore
```

Now clone your dotfiles into a bare repository in a "dot" folder of your $HOME:

```
git clone --bare <git-repo-url> $HOME/.cfg
```

Define the alias in the current shell scope:

```
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

Checkout the actual content from the bare repository to your $HOME:

```
config checkout
```

