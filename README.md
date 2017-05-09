# gitstuff
Various stuff for use with Git. Code is not intended as standalone files, but
rather as snippets for use in other files.

All code licensed MIT unless stated otherwise.

## gitprompt.sh
Code to insert the current branch and status into your bash prompt. Add to
~/.bashrc to use.

### Suggested tweaks
* Colors produced by the `git_color` function can be tweaked as
  desired; see [this article](http://bitmote.com/index.php?post/2012/11/19/Using-ANSI-Color-Codes-to-Colorize-Your-Bash-Prompt-on-Linux)
  for the codes needed. In particular, the colors specified in this snippet
  assume a black or otherwise dark background in your terminal; if you use a
  terminal with a white or light-colored background, you'll want to change the
  color for a clean directory (which is set to `1;37m`/white here) and possibly 
  the color for having both staged and unstaged changes (set to `1;33m`/yellow 
  here).
* As presented here, the code will display the `P` flag if there are any local commits at all that do not exist on a remote, including new local branches. If you would prefer to only show the flag for unpushed commits in the currently checked-out branch, replace line 37 with:
  ```bash
  [[ -n $(git status -sb|grep -E "\[ahead .+\]") ]] && output="${output}P"
  ```

Based on:
* [Original gist](https://gist.github.com/henrik/31631)
  by [henrik](https://github.com/henrik)
* [Fork of henrik's gist](https://gist.github.com/srguiwiz/de87bf6355717f0eede5)
  by [srguiwiz](https://github.com/srguiwiz)

Modified by me, using ideas from those gists and their comments
