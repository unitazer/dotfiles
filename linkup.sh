rm -rf ~/.config/nvim
ln -s ~/dotfiles/nvim/ ~/.config/nvim
cd ~/.config/ 
rm -rf hypr kitty mako swaylock wofi wlogout waybar 
ln -s ~/dotfiles/general/hypr/ hypr
mkdir mako
ln -s ~/dotfiles/general/mako/conf/config mako/config
ln -s ~/dotfiles/general/wofi/ wofi
mkdir kitty
ln -s ~/dotfiles/general/kitty/kitty.conf kitty/kitty.conf
mkdir waybar
ln -s ~/dotfiles/general/waybar/conf/main.jsonc waybar/config.jsonc
ln -s ~/dotfiles/general/waybar/style/style.css waybar/style.css
ln -s ~/dotfiles/general/wlogout/ wlogout
ln -s ~/dotfiles/general/swaylock/ swaylock
#unforgivable mess.
cp ~/dotfiles/grub /etc/default/grub
cp ~/dotfiles/.bashrc ~/.bashrc
