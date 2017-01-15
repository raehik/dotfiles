# include general shell profile
source "$HOME/.config/shell/shell-profile"

# include .bashrc if it exists (not auto-loaded on login shell, unlike zsh)
if [[ -f "$HOME/.bashrc" ]]; then
    source "$HOME/.bashrc"
fi
