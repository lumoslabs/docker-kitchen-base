export RBENV_ROOT=/opt/rbenv
export PATH=$RBENV_ROOT/bin:/opt/rbenv/bin:$PATH

case $SHELL in
*/zsh)
  source $RBENV_ROOT/completions/rbenv.zsh
  ;;
*/bash)
  source $RBENV_ROOT/completions/rbenv.bash
  ;;
*)
  source $RBENV_ROOT/completions/rbenv.bash
  ;;
esac

eval "$(rbenv init -)"
