#!/usr/bin/env zsh

# Initialize color support
autoload -U colors && colors

# User defined variables
typeset -g PR_RETURN_ENABLE_PRINT=true

# Define icons with proper color encapsulation using colors library
typeset -g _pr_return_success_return=" ${fg[green]}\u2713${reset_color}"
typeset -g _pr_return_error_return=" ${fg[red]}\u2717${reset_color}"

typeset -g pr_return="${_pr_return_success_return}"
typeset -g PR_RETURN_INIT_COMPLETE=false
typeset -g LAST_COMMAND=""

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
    if [[ "$PR_RETURN_INIT_COMPLETE" == "false" ]] || [[ "$PR_RETURN_ENABLE_PRINT" == "false" ]] || [[ -z "$LAST_COMMAND" ]]; then
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
