<h1>
  <img src="https://github.com/Portal-2-Multiplayer-Mod/P2MM-ART/blob/e56d8c209eb3f143bb0607dc1e59730e517ecca6/Banners/P2MMBannerREADME.png?raw=true" alt="P2MMBannerREADME" width="500" height="290" align="left">
  <a href="https://discord.gg/nXRygGNxyK" target="_blank">
      <img src="https://img.shields.io/discord/839651379034193920?color=blue&label=Discord%20Users&style=for-the-badge&logo=discord&logoWidth=20"
              alt="Discord Shield Badge" style="margin-bottom: 10px;" align="right">
  </a>
  <br>
  <a href="https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/releases/latest">
      <img src="https://img.shields.io/github/release-date/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod?color=red&label=Latest%20Release&style=for-the-badge"
              alt="Release Shield Badge" style="margin-bottom: 10px;" align="right">
  </a>
  <br>
  <img src="https://img.shields.io/github/downloads/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/total?style=for-the-badge&label=TOTAL%20DOWNLOAD%20COUNT"
          alt="Download Count Shield Badge" style="margin-bottom: 10px;" align="right">
  </a>
  <br>
  <a href="https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/commits/main">
      <img src="https://img.shields.io/github/last-commit/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod?label=LAST%20COMMIT%20(MAIN)&style=for-the-badge"
              alt="Commit Shield Badge" style="margin-bottom: 10px;" align="right">
  </a>
  <br>
  <a href="https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/commits/finalcleanup">
      <img src="https://img.shields.io/github/last-commit/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/finalcleanup?style=for-the-badge&label=LAST%20COMMIT%20(FINALCLEANUP)&color=%2334a5eb"
              alt="GitHub last commit (branch)" align="right">
  </a>
  <br>
  <p align="right">PORTAL 2:</p>
  <p align="right">MULTIPLAYER MOD</p>
</h1>

### 该模组仅服务端使用。只有服务器管理员需要安装该模组至 Portal 2 来运行。其他玩家仅需使用原版即可进入该服务器。

## 语言

[English](README.md) | [Español](README.es.md) | [Polish](README.pl.md) | **_简体中文_** | [繁體中文](README.zh-TW.md) | [Italiano](README.it.md) | [Français](README.fr.md)

## 模组功能

```
  - 最大玩家上限增至 33 人
  - 名称标签
  - 自定义玩家颜色
  - 聊天框命令 (!help)
  - 游戏内管理系统
  - 支持合作模式
  - 支持单人模式（但仍需多加打磨） 
  - 支持 Super 8 地图
  - 内部地图支持选择创意工坊地图
  - 通过活动 GameRules 类调用客户端命令加密
  - 支持 Linux, Windows 7 及以上系统
  - 通过 VScript 和自定义插件提供可切换的游戏选项以及配置系统
  - 为速通提供 SAR（起源自动录制）支持
```

# 安装及使用

**Steam 教程页 - 如何建立服务器以及加入游戏（英文）：**

- <https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280>

**下载最新版：**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/releases/latest>

**加入 Discord 服务器获取更多技术上的帮助（确保你已经看完教程了！！！），报告 Bug 或聊天：**

- <https://discord.gg/kW3nG6GKpF>

# 构建启动器

## 使用依赖

- Python 3.10
- pygame
- pyperclip
- requests
- steamid-converter

我们已将其放入文件中以便安装：`pip install -r requirements.txt`

## 编译

我们使用 `pyinstaller` 和 `AppImage` 来制作可执行文件！

### Windows:

对于 Windows，我们仅使用 [pyinstaller](https://pypi.org/project/pyinstaller/) 来构建可执行文件（如果你知道更好的选择，请告诉我们）。

```shell
pyinstaller "src/MainWindow.py" -F -i "src/GUI/images/p2mm64.ico" --noconsole --add-data "src/GUI;GUI" --add-data "src/ModFiles;ModFiles" --add-data "src/Languages;Languages"
```

### Linux:

对于 Linux，我们转而使用 [AppImage](https://appimage.org/)，我们制作了一个工具来帮助实现这一点，只需安装 `docker` 并在根目录下运行 `./tools/build-docker.sh`。

***警告！出于某种原因，在某些 Linux 发行版上，默认情况下未安装 FUSE，这是编译和运行 AppImages 所必需的。可以在此处找到在发行版上安装 FUSE 的信息：[AppImageKit 的维基](https://github.com/AppImage/AppImageKit/wiki/FUSE)***

如果你不想使用 AppImage/Docker，你仍然可以使用 pyinstaller：

```shell
pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/ModFiles:ModFiles" --add-data "src/Languages:Languages"
```

### 注意:

- 若你想要 Fork 并作为你的项目来发布，你需要更改 `src/Scripts/Updater.py` 顶部中的变量到你的信息。

# 做出贡献

从 2.2.0 版本开始，所有可接受的贡献将是错误修复、影响启动器使用和/或在 Portal 2 中运行模组时出现的问题，以及启动器的翻译。任何重大更改都将被拒绝，因为我们正在努力重写 3.0，而不是继续开发 2.0 系列。但是欢迎你在 [3.0 重写存储库](https://github.com/Portal-2-Multiplayer-Mod/P2MM-Entanglement) 上帮助我们！在那里，我们需要 Python 和 C++ 程序员。

# 贡献者

**开发者：**

- kyleraykbs
- Bumpy
- Nanoman2525
- vista
- Wolƒe Strider Shoσter
- cabiste
- Orsell

**贡献者：**

- wanderer (free bird)
- \n
- Luukex
- MeblIkea
- PieCreeper
- Areng
