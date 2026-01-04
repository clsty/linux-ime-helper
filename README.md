Linux X11/Wayland 输入法助手

来自 [linux下软件无法输入中文的完美解决方案：对话框+wl-clipboard+xdotool （输入法） - Nolca - 博客园](https://www.cnblogs.com/nolca/p/18654305) 的脚本，我略微做了点改动。

说明：
- 在 wayland 下，此脚本依赖 [ydotool](https://github.com/ReimuNotMoe/ydotool)，它需要守护进程 ydotoold 才能工作。
- 官方推荐使用 root 权限运行 ydotoold，可供参考的命令：
  ```bash
  sudo ydotoold -o $(id -u):$(id -g) -p /tmp/.ydotool_socket
  ```
- TODO: 做成 systemd 服务

技巧：
- 脚本开头有一行 `set -e`，作用是如果某个命令出错（且未被捕获）就停止运行。
- 由于此脚本主要通过快捷键调用，你可以安装 `notify-send`，用它写命令（例如 `notify-send "WAYLAND_DISPLAY=$WAYLAND_DISPLAY"`）放在脚本里，还可结合 `set -e` 的性质以及二分法等技巧来排查问题。
