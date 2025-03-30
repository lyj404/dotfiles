# ⚡️ 前置要求
* bat
* exa
* zed
* fish
* stow
* nano
* emacs
* starship
* lazygit
* rime-ice-git
* nerd-fonts-jetbrains-mono
> 在使用相关配置文件之前，需要先安装上述所有软件
## 安装方式
**方式一**：

通过包管理器安装
```
sudo pacman -S fish stow nano emacs starship exa bat zed
yay -S lazygit rime-ice-git nerd-fonts-jetbrains-mono
```
**方式二**：
执行安装脚本
```
./install-software.sh
```
> 通过脚本安装软件的方式，只是将所有安装命令放到脚本中执行，并且增加刷新字体缓存和切换shell的功能。
# 🚀 使用配置
```
./setup.fish
```