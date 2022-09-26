# Plugin for ZSH that displays the return value of the last command run

This plugin will create a global variable that can be displayed in prompts. 

### Example

```sh
PROMPT='$pr_return ...REST OF PROMPT'
```

This plugin is made to be fast. It runs in the background and updates information only when needed.

## Prerequisites

#### This plugin depends on [zsh-colors](https://github.com/zpm-zsh/colors) and [zsh-figures](https://github.com/zpm-zsh/figures).

If you don't use [zpm](https://github.com/zpm-zsh/zpm), install it manually and activate it before this plugin. 
If you use zpm you don’t need to do anything

## Installation

### If you use [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

* Clone this repository into `~/.oh-my-zsh/custom/plugins`
```sh
cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zpm-zsh/pr-return
```
* After that, add `pr-return` to your oh-my-zsh plugins array.

### If you use [Zgenom]([https://github.com/tarjoilija/zgen](https://github.com/jandamm/zgenom))

1. Add `zgenom load zpm-zsh/pr-return` to your `.zshrc` with your other plugins
2. run `zgenom save`

### If you use my [ZPM](https://github.com/zpm-zsh/zpm)

* Add `zpm load zpm-zsh/pr-return` into your `.zshrc`
