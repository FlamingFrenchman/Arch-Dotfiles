#
# ~/.bash_profile
#

if [[ -r "$HOME/.profile" ]]; then source "$HOME/.profile"; fi

# put histfile in state
export HISTFILE="$XDG_STATE_HOME/bash/history"
# function to call to generate command
export PROMPT_COMMAND=prompt

if [[ -r "$HOME/.bashrc" ]]; then source "$HOME/.bashrc"; fi
