# vim:ft=zsh ts=2 sw=2 sts=2

ruby_version() {
  echo `rbenv version | sed -e 's/ .*//'`
}

rbenv_version() {
  rbenv version 2>/dev/null | awk '{print $1}'
}

ruby_prompt_info() {
  if which rbenv &> /dev/null; then
    echo "%{$fg_bold[red]%}$(rbenv_version)%{$reset_color%}"
  fi
}

PROMPT='
%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} in %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info) ⌚ %{$fg_bold[red]%}%*%{$reset_color%} $(ruby_prompt_info)
$ '

# Must use Powerline font, for \uE0A0 to render.
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}\uE0A0 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
