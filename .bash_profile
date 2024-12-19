# Color and style definitions
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
RESET=$(tput sgr0)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
BOLD=$(tput bold)
ORANGE=$(tput setaf 178)  # Define orange color
PINK=$(tput setaf 205)    # Define pink color
GRAY=$(tput setaf 244)    # Define gray color
ITALIC=$(tput sitm)       # Define italic style
SEMIBOLD=$(tput bold)     # Semibold is the same as bold in many terminals

# Function to parse and display Git branch and status
parse_git_branch() {
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        local branch=$(git rev-parse --abbrev-ref HEAD)
        if git diff --quiet && git diff --cached --quiet; then
            echo " ${ITALIC} ▸ ${GREEN}${BOLD}{${branch}}${RESET}"
        else
            echo " ${ITALIC} ▸ ${PINK}${BOLD}{${branch}}${RESET}"
        fi
    fi
}

# Function to indicate if the user is root
is_root() {
    if [ "$EUID" -eq 0 ]; then
        echo "${GRAY}# ${RESET}"
    else
        echo "${GRAY}$ ${RESET}"
    fi
}

# Function to set the prompt
set_prompt() {
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        PS1="\$(parse_git_branch) ${BOLD}${BLUE}\u@\h ${RESET}${ITALIC}${CYAN}\w${RESET} \$(is_root) "
    else
        PS1="${BOLD}${BLUE}\u@\h ${RESET}${ITALIC}${CYAN}\w${RESET} \$(is_root) "
    fi
}

# Set PROMPT_COMMAND to call set_prompt
PROMPT_COMMAND='set_prompt'