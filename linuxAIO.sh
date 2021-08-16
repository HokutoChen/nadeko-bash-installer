#!/bin/sh
echo ""
echo "Welcome to NadekoBot. Downloading the latest installer..."
root=$(pwd)
wget -N https://gitlab.com/Kwoth/nadeko-bash-installer/-/raw/master/n-menu.sh

bash n-menu.sh
cd "$root"
rm "$root/n-menu.sh"
exit 0
