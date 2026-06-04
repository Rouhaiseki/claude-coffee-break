<div align="center">

# ☕ Coffee Break（摸鱼一下）

### 趁 Claude Code 写代码的工夫，玩个小游戏。

**任务跑得久了，游戏窗口自己弹出来；AI 一写完，它自己关掉。**

[English](README.md) · [简体中文](README.zh-CN.md) · [日本語](README.ja.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-d9a441.svg)](LICENSE)
![Made for Claude Code](https://img.shields.io/badge/for-Claude%20Code-4a78b0.svg)
![No dependencies](https://img.shields.io/badge/dependencies-0-5bb377.svg)

<img src="screenshots/home.png" width="320" alt="Coffee Break 首页" />

</div>

---

## 为什么做这个？

看 AI 写代码，大部分时间都在**等**。Coffee Break 把这段发呆的时间变成一局小游戏。
它以 **Claude Code 的 skill + 钩子**方式运行，全程不用你操心：

| 什么时候 | 发生什么 |
| --- | --- |
| 你发指令，任务跑**超过 ~10 秒** | 自动弹出一个干净的游戏窗口 |
| 任务很短（< 10 秒） | 什么都不弹，不打扰你 |
| Claude **写完了** | 窗口显示"AI 写完啦"，然后**自己关掉** |

整个东西就是一个独立的 HTML 文件。**免构建、零依赖、不联网、不收集任何数据。**

## 里面有 9 个游戏

<table>
<tr>
<td width="50%" valign="top">

**📦 推箱子 · 通关战役**
完整 **14 关**的推箱子，带选关、进度存档、步数统计、撤销。每一关在发布前都
**用 BFS 求解器验证过可解**——绝不会出现死关。

</td>
<td width="50%" valign="top">

<img src="screenshots/sokoban.png" width="280" alt="推箱子玩法" />

</td>
</tr>
</table>

……另外还有 8 个，纯放空时玩：

| | 游戏 | |  | 游戏 | |
|---|---|---|---|---|---|
| 🧠 | **脑筋急转弯** | 转个弯就通了 | 🃏 | **记忆翻牌** | 翻出所有配对 |
| 🪓 | **伐木工** | 砍树躲树枝 | 🧩 | **滑块拼图** | 数字排排好 |
| 🐤 | **小鸟飞** | 穿过管子 | 🎯 | **猜数字** | 几次能猜中 |
| 🔢 | **2048** | 合成大数字 | ⚡ | **反应测试** | 手速有多快 |

## 🏆 成就系统 & 🌐 三种语言

<table>
<tr>
<td width="48%" valign="top"><img src="screenshots/levels.png" width="100%" alt="推箱子选关"/></td>
<td width="52%" valign="top"><img src="screenshots/achievements.png" width="100%" alt="成就系统"/></td>
</tr>
</table>

- **16 个成就**边玩边解锁，带弹窗提示和进度面板。
- 界面支持 **English / 简体中文 / 日本語**，右上角随时切换。脑筋急转弯是每种语言
  各自手写的题库，**不是机翻**。
- 进度和解锁记录都存在你浏览器本地。

## 安装

```bash
git clone https://github.com/Langzishueth/claude-coffee-break.git
cd claude-coffee-break
./install.sh
```

然后**重启 Claude Code**（或在 `/hooks` 里确认新钩子）。搞定——以后任务一长，游戏就自动弹。

> **环境要求：** `python3`（macOS 自带）用来跑本地服务器；窗口要能自己关掉需要
> Google Chrome / Chromium。没有 Chrome 会退而用默认浏览器（那就你自己关标签页）。

## 手动使用

不想全自动？跳过 `install.sh`，想玩的时候手动开：

```bash
./launch.sh now      # 立刻打开游戏厅
./done.sh            # 发"完工"信号，让窗口自己关
```

或者直接用任意浏览器打开 `index.html`。

## 配置

| 想…… | 这么做 |
| --- | --- |
| 改"长任务"的阈值 | 改 `launch.sh` 里的 `COFFEE_DELAY`（秒） |
| 改本地端口 | 设 `COFFEE_PORT`（默认 `8765`） |
| 关掉全自动 | 跑 `./uninstall.sh`，然后重启 Claude Code |

## 原理

两个小脚本挂在 Claude Code 的钩子上：

- **`launch.sh`** → `UserPromptSubmit` 钩子。标记任务开始、在 `localhost` 起一个服务器、
  等 `COFFEE_DELAY` 秒，**只有任务还在跑时**才开窗口（所以短任务从不打扰你）。
- **`done.sh`** → `Stop` 钩子。标记任务完成；页面轮询到后，倒数几秒自己关窗。

```
你发指令 ─▶ UserPromptSubmit ─▶ launch.sh ─▶ （等 10 秒，还在忙？）─▶ 🎮 弹出窗口
AI 写完  ─▶ Stop ─▶ done.sh ─▶ 页面看到"done" ─▶ 窗口自己关
```

## 许可证

[MIT](LICENSE) —— 随便用。欢迎提 PR 加新游戏、新关卡、新语言。

<div align="center">
<sub>为漫长的编译时光而生。☕</sub>
</div>
