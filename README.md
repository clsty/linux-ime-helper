# Linux X11/Wayland 输入法助手

## 快速上手

### 环境准备
- 在 wayland 下，此脚本依赖 [ydotool](https://github.com/ReimuNotMoe/ydotool)，它需要守护进程 ydotoold 才能工作。
- 官方推荐使用 root 权限运行 ydotoold，可供参考的命令：
  ```bash
  sudo ydotoold -o $(id -u):$(id -g) -p /tmp/.ydotool_socket
  ```

> TODO: 将 ydotoold 做成 systemd 服务，方便快速调用。

### 使用方法
- 将 `ime-helper.sh` 脚本全局绑定到任一快捷键（绑定方法因桌面环境而异）。
- 需要输入的时候按快捷键弹出窗口，在其中输入文本，按回车就会关闭窗口并将文本放到剪贴板，之后自动粘贴。

## 附加说明
- 如果你是为了在 Steam 客户端使用输入法：
  - 实际上，只要浏览器的输入法正常，那么在 Steam 网页版也可以完成很多客户端的功能，包括[聊天](https://steamcommunity.com/chat/)。网页版的 Steam 聊天还支持粘贴图片（实测 Debian 13 下的 Steam 客户端不支持）。
  - 最新的 Steam 客户端已经支持输入中文（需要配合软件包比较新的发行版，例如 Arch Linux 是支持的，见[Steam里没法输入中文，中文输入法是fcitx5的pinyin - 技术交流与探讨 / 新手园地 - Arch Linux 中文论坛](https://forum.archlinuxcn.org/t/topic/13162)，而实测 Debian 13 不支持）。

## 历史说明
此脚本直接来自 2025-01-06 的 [linux下软件无法输入中文的完美解决方案：对话框+wl-clipboard+xdotool （输入法） - Nolca - 博客园](https://www.cnblogs.com/nolca/p/18654305) ，并略微做了点改动。

不过，这类方案（即调用支持输入法的外部窗口）并不是上文首创的。
- 已知最早的来源是 2014 年的 [m13253/minecraft-chat-helper](https://github.com/m13253/minecraft-chat-helper)。
- 2019-06-10，在此基础上修改得到的方案是[Linux下,Steam中文输入的治标方案. - 鲸鱼的池塘](https://anye7up.cn/post/26/)，仓库见 [anye7up/steam-chat-helper](https://github.com/anye7up/steam-chat-helper)。
  - 2019-07-21 还有另一篇博文提到了类似方案，见[使用zenity+xclip实现文字复制粘贴 | weearc 的个人博客](https://blog.weearc.top/posts/5960/)。

## 调试技巧
- 脚本开头有一行 `set -e`，作用是如果某个命令出错（且未被捕获）就停止运行。
- 由于此脚本主要通过快捷键调用，你可以安装 `notify-send`，用它写命令（例如 `notify-send "WAYLAND_DISPLAY=$WAYLAND_DISPLAY"`）放在脚本里，还可结合 `set -e` 的性质以及二分法等技巧来排查问题。
