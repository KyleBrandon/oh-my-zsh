
function zle-line-init zle-keymap-select {
    VIMODE="${${KEYMAP/vicmd/NORMAL}/(main|viins)/INSERT}"
    if [[ "${VIMODE}" == "INSERT" ]]; then
        VICOLOR=$PR_GREEN
    else
        VICOLOR=$PR_RED
    fi
    set-vim-prompt
    zle reset-prompt
}

zle -N zle-keymap-select
zle -N zle-line-init

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '○'
}

function set-vim-prompt () {
    PROMPT="${VICOLOR}${VIMODE}%{${reset_color}%} $PR_BLUE$vcs%{${reset_color}%} "
}

function precmd () {
    # if [[ -n RUN_VCS_PROMPT_ONCE ]]; then
    #     vcs=$(prompt_char)
    #     RUN_VCS_PROMPT_ONCE=
    # fi

    vcs=$(prompt_char)
    print -rP "$PR_CYAN%n%{${reset_color}%}@$PR_YELLOW%m%{${reset_color}%} in $PR_BLUE${PWD/#$HOME/~}%{${reset_color}%}
"
}


setprompt () {
    setopt prompt_subst
    setopt PROMPT_SUBST
    autoload colors

    if [[ "$terminfo[colors]" -gt 8 ]]; then
        colors
    fi

    for COLOR in RED ORANGE GREEN YELLOW BLUE WHITE MAGENTA BLACK CYAN; do
        eval PR_$COLOR='%{$fg_no_bold[${(L)COLOR}]%}'
        eval PR_BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
    done

    set-vim-prompt
}

autoload -U compinit
compinit
zstyle ':completion:*' menu select
setopt completealiases
bindkey -v

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\ee' edit-command-line

setprompt
