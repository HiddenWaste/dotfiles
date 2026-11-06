hl.on("hyprland.start", function ()
  -- hl.exec_cmd(terminal)
  hl.exec_cmd("hyprpaper") -- wallpaper engine
  hl.exec_cmd("~/.config/hypr/scripts/battery_monitor.sh") -- (?) monitor batter %

  -- dark mode enabling
  hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'")

end)
