# vim: set ft=sh :
#
# Bash login configuration.
#

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# include general shell profile
source "$HOME/.config/shells/shell_profile"

# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
fi
