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

1. Define a special alias to `git` that you'll use exclusively to work with this dotfiles repository. Note that you don't need to add this to your .zshrc, since we'll be overwriting it anyways with the version in this repository. 

```shell
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

Then add the local folder to the gitignore to avoid creating weird recursion problems:

```
echo ".cfg" >> .gitignore
```

Now clone your dotfiles into a bare repository in a "dot" folder of your $HOME:

```
git clone --bare <git-repo-url> $HOME/.cfg
```

Checkout the actual content from the bare repository to your $HOME:

```
rm ~/.zshrc
config checkout
```

