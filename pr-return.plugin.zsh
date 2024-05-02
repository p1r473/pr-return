#!/usr/bin/env zsh

# User defined variables
zstyle ':pr-return:*' enable-print true

# Initialize color support
autoload -U colors && colors

# Define icons with proper color encapsulation using colors library
_pr_return_success_return=" ${fg[green]}\u2713${reset_color}"
_pr_return_error_return=" ${fg[red]}\u2717${reset_color}"

typeset -g pr_return="${_pr_return_success_return}"
zstyle ':pr-return:*' init_complete false
LAST_COMMAND=""

function set_pr_return_init_complete() {
    PR_RETURN_INIT_COMPLETE=true
}

function _track_command() {
    LAST_COMMAND="$1"  # Store the command to check next time
}

function _reset_last_command() {
    LAST_COMMAND="$BUFFER"
}

function _pr_return() {
    local RETVAL=$?
    if [[ $RETVAL == 0 ]]; then
        pr_return="${_pr_return_success_return}"
    else
        pr_return="${_pr_return_error_return}"
    fi
    if ! zstyle -T ':pr-return:*' init_complete; then
        return
    fi
    if ! zstyle -T ':pr-return:*' enable_print; then
        return
    fi
    if [[ -z "$LAST_COMMAND" ]]; then
        return
    fi
    local cols=$((COLUMNS - 2)) # Account for the space in front of the checkmark/X
    echo -e "\033[1A\033[${cols}C\e[2m${pr_return}${reset_color}"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _pr_return
add-zsh-hook precmd set_pr_return_init_complete
add-zsh-hook precmd _reset_last_command
add-zsh-hook preexec _track_command
