# Fix home directory folder names
mv ~/Documents/ ~/documents/
mv ~/Pictures/ ~/pictures/
mv ~/Downloads/ ~/downloads/
mv ~/Music/ ~/music/

rm -rf ~/Desktop/
rm -rf ~/Videos/

sudo apt update && sudo apt upgrade -y
