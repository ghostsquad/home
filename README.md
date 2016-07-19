Bash Evnironment
====

Home Bash Environment Happiness

*.bashrc* - The workhorse, make your shell happy.

*.profile* - Sources .bashrc for login shells.

*.inputrc* - Remaps the up and down arrows to history search,

*.vimrc* - Configuration file for vim.

*setup_home.sh* - Install packages that I like. Ubuntu/Debian only.

Installation
====
Copy each of the adove files to your home directory.
Relog or 'source .bashrc' and grin.

for F in .bashrc .profile .inputrc .vimrc;do wget --no-check-certificate https://raw.github.com/ghostsquad/home/master/$F -O ~/$F;done

    Tested on Ubunu, CentOS, and FreeBSD

    For full install:
    wget --no-check-certificate https://raw.github.com/ghostsquad/home/master/setup.sh -O ~/setup.sh;sudo sh ~/setup.sh
