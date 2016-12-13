# This is the simple setup script that updates everything.

cd $HOME/dotfiles/
hg clone https://bitbucket.org/durin42/hg-remotebranches
hg clone https://bitbucket.org/marmoute/mutable-history
hg clone https://bitbucket.org/MatthewTurk/hgbb

cd $HOME

for rc in screenrc hgrc vimrc zshrc xonshrc
do
  echo ln -s $HOME/dotfiles/${rc} .${rc}
done
ln -s $HOME/dotfiles/vim .vim
mkdir -p $HOME/.config/xonsh
ln -s $HOME/dotfiles/xonsh-config.json $HOME/.config/xonsh/config.json
