gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface enable-hot-corners false

gsettings set org.gnome.desktop.input-sources xkb-options "['compose:ralt']"

gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false

gsettings set org.gnome.desktop.wm.keybindings close "['<super><shift>q','<alt>F4']"
gsettings set org.gnome.desktop.wm.keybindings minimize "[]"

gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<super><shift>1']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 "['<super><shift>2']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 "['<super><shift>3']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<super><shift>4']"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<super>1', '<super>Home']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<super>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<super>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<super>4']"

gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<alt>tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<shift><alt>tab']"

gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<super>tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<super>tab']"

gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen  "['<super><shift>f']"
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized  "['<super>f']"

for i in {1..9}; do gsettings set org.gnome.shell.keybindings switch-to-application-$i "['']"; done

gsettings set org.gnome.desktop.wm.preferences num-workspaces 4

gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.mutter edge-tiling true
gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<super>h']"
gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<super>l']"
gsettings set org.gnome.mutter.wayland.keybindings restore-shortcuts "[]"

gsettings set org.gnome.settings-daemon.plugins.media-keys www "['<super>b']"
gsettings set org.gnome.settings-daemon.plugins.media-keys help "[]"
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "['<super>escape']"

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "<super>return"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "alacritty"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "Open alacritty"
