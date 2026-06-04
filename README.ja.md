<div align="center">

# ☕ Coffee Break

### Claude Code が考えている間に、ミニゲームでひとやすみ。

**タスクが長引くとアーケードが自動で開き、AI が終わると自動で閉じます。**

[English](README.md) · [简体中文](README.zh-CN.md) · [日本語](README.ja.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-d9a441.svg)](LICENSE)
![Made for Claude Code](https://img.shields.io/badge/for-Claude%20Code-4a78b0.svg)
![No dependencies](https://img.shields.io/badge/dependencies-0-5bb377.svg)

<img src="screenshots/home.png" width="320" alt="Coffee Break ホーム画面" />

</div>

---

## なぜ？

AI のコーディングを眺める時間は、ほとんど「待ち」です。Coffee Break はその待ち
時間をサッと遊べるゲームに変えます。**Claude Code の skill + フック**として動くので、
何も意識する必要はありません：

| タイミング | 起きること |
| --- | --- |
| プロンプト送信後、タスクが **約10秒以上** かかる | きれいなゲーム窓が開く |
| タスクが短い（10秒未満） | 何も出ない — 邪魔しません |
| Claude がタスクを **完了** | 「AI 完了！」と表示し、窓が **自動で閉じる** |

中身は自己完結した HTML 1ファイル。**ビルド不要・依存ゼロ・通信なし・追跡なし。**

## 収録ゲーム — 全9種

<table>
<tr>
<td width="50%" valign="top">

**📦 倉庫番 · 全14ステージ**
ステージ選択・進捗セーブ・手数カウント・もどす機能つきの本格キャンペーン。
全ステージ、公開前に **BFS ソルバーで解けることを検証済み** — 詰みステージなし。

</td>
<td width="50%" valign="top">

<img src="screenshots/sokoban.png" width="280" alt="倉庫番のプレイ画面" />

</td>
</tr>
</table>

……さらに、ただボーッとしたいとき用に8種：

| | ゲーム | |  | ゲーム | |
|---|---|---|---|---|---|
| 🧠 | **なぞなぞ** | ひらめき勝負 | 🃏 | **神経衰弱** | ペアをそろえて |
| 🪓 | **木こり** | 枝をよけて切る | 🧩 | **スライドパズル** | 数字を並べて |
| 🐤 | **パタパタ鳥** | すき間を抜けろ | 🎯 | **数当て** | 何回で当たる？ |
| 🔢 | **2048** | 数字を合体 | ⚡ | **反応速度** | 反射神経テスト |

## 🏆 実績システム & 🌐 3言語対応

<table>
<tr>
<td width="48%" valign="top"><img src="screenshots/levels.png" width="100%" alt="倉庫番ステージ選択"/></td>
<td width="52%" valign="top"><img src="screenshots/achievements.png" width="100%" alt="実績システム"/></td>
</tr>
</table>

- 遊ぶうちに **16 個の実績** が解除され、ポップアップと一覧ボードで表示。
- UI は **English / 简体中文 / 日本語**、右上でいつでも切替。なぞなぞは各言語ごとの
  手書き問題集で、**機械翻訳ではありません**。
- 進捗と実績はブラウザのローカルに保存されます。

## インストール

```bash
git clone https://github.com/Rouhaiseki/claude-coffee-break.git
cd claude-coffee-break
./install.sh
```

そのあと **Claude Code を再起動**（または `/hooks` で新しいフックを承認）。これだけで、
長いタスクのときにアーケードが自動で開きます。

> **必要なもの：** ローカルサーバー用の `python3`（macOS は標準搭載）と、自動で閉じる
> 窓のための Google Chrome / Chromium。Chrome が無い場合は既定のブラウザで開きます
> （その場合タブは自分で閉じてください）。

## 手動で使う

全自動が不要なら、`install.sh` は飛ばして好きなときに開くだけ：

```bash
./launch.sh now      # アーケードをすぐ開く
./done.sh            # 「完了」を通知して窓を閉じる
```

または `index.html` をブラウザで直接開いてもOK。

## 設定

| やりたいこと | 方法 |
| --- | --- |
| 「長いタスク」のしきい値を変える | `launch.sh` の `COFFEE_DELAY`（秒）を編集 |
| ローカルポートを変える | `COFFEE_PORT` を設定（既定 `8765`） |
| 全自動をやめる | `./uninstall.sh` 後、Claude Code を再起動 |

## しくみ

2つの小さなシェルスクリプトを Claude Code のフックに接続します：

- **`launch.sh`** → `UserPromptSubmit` フック。タスク開始を記録し、`localhost` で
  ゲームを配信、`COFFEE_DELAY` 秒待ち、**まだ実行中のときだけ**窓を開きます。
- **`done.sh`** → `Stop` フック。完了を記録。ページがそれを検知し、カウントダウン後に
  自分で窓を閉じます。

```
プロンプト ─▶ UserPromptSubmit ─▶ launch.sh ─▶（10秒待つ、まだ忙しい？）─▶ 🎮 窓が開く
AI 完了    ─▶ Stop ─▶ done.sh ─▶ ページが「done」を検知 ─▶ 窓が自動で閉じる
```

## ライセンス

[MIT](LICENSE) — ご自由にどうぞ。新しいゲーム・ステージ・言語の PR 大歓迎です。

<div align="center">
<sub>長いコンパイル時間のために。☕</sub>
</div>
