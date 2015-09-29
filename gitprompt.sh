# Adds the current branch to the bash prompt when the working directory is
# part of a Git repository. Includes color-coding and an asterisk to quickly
# indicate if working directory is clean (green, no asterisk) or dirty (red
# with asterisk).
#
# To use: Copy into ~/.bashrc and tweak if desired.
#
# Based upon the following gists:
# <https://gist.github.com/henrik/31631>
# <https://gist.github.com/srguiwiz/de87bf6355717f0eede5>
# Modified by me, using ideas from comments on those gists.
#
# License: MIT, unless the authors of those two gists object :)

git_branch() {
    # -- Finds and outputs the current branch name by parsing the list of
    #    all branches
    # -- Current branch is identified by an asterisk at the beginning
    # -- If not in a Git repository, error message goes to /dev/null and
    #    no output is produced
    git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

git_dirty() {
    # The --porcelain option produces no output at all if there are
    # no uncommitted changes. -z tests if the output of the command
    # is empty; if not empty, dummy text is output. Again, we are not
    # interested in errors.
    if [[ ! -z $(git status --porcelain 2>/dev/null) ]]; then
        echo yes
    fi
}

git_color() {
    # Receives output of git_dirty as argument; produces green color code
    # if argument is empty and red color code otherwise.
    if [[ -z $1 ]]; then
        echo -e '\033[1;32m'  # bold green
    else
        echo -e '\033[1;31m'  # bold red
    fi
}

git_prompt() {
    # First, get the branch name...
    local branch=$(git_branch)
    # Empty output? Then we're not in a Git repository, so bypass the rest
    # of the function, producing no output
    if [[ ! -z $branch ]]; then
        local dirty=$(git_dirty)
        local color=$(git_color $dirty)
        local marker=${dirty:+*}  # asterisk if not empty, nothing otherwise
        # Now output the actual code to insert the branch and status
        echo -e "$color[$branch$marker]\033[00m"  # last bit resets color
    fi
}

# Sample prompt declaration based off of the default Ubuntu 14.04.1 color
# prompt. Tweak as you see fit, or just stick "$(git_prompt)" into your
# favorite prompt.
PS1='$debian_chroot\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w$(git_prompt)\[\033[00m\]\$ '

