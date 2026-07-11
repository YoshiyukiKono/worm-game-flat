# worm-game-flat

円と色だけで構成する、ミニマルな Worm ゲームです。

このリポジトリは、ゲームを段階的に作りながら Godot に親しむための小さな実践教材です。Godot の機能を網羅するのではなく、Worm ゲームを完成させるために必要な要素だけを扱います。

## コンセプト

- 画面は `N × N` の円で構成する
- 地面、頭、体、餌は色で区別する
- 頭の向きは、頭の円周に内接する小さな円で示す
- 画像アセットを使用しない
- 操作には Vim と同じ `h` `j` `k` `l` を使用する
- 余計な画面や演出を設けず、開始と終了を明確にする

> Everything is a circle.

## 操作

| キー | 操作 |
|---|---|
| `h` | 左へ向く |
| `j` | 下へ向く |
| `k` | 上へ向く |
| `l` | 右へ向く |
| `r` | ゲーム終了後に再開 |
| `Esc` | 終了 |

ワームは起動後、自動的に右へ進みます。同じ軸上で真後ろへ折り返すことはできません。

## 実行環境

このリポジトリでは、次の環境を基準とします。

* Windows 11
* WSL2
* Ubuntu 24.04
* WSLg
* Godot 4.7 stable
* GDScript
* 外部アセットなし

Godotは、Windows版ではなく、WSL2 Ubuntu上のLinux版を使用します。

WSL2 UbuntuとGodotの導入方法については、[WSL2 Ubuntuでの環境構築](docs/setup-wsl2-ubuntu.md)を参照してください。

## 実行方法

WSL2 Ubuntuでリポジトリを取得します。

```bash
cd ~
git clone https://github.com/YoshiyukiKono/worm-game-flat.git
cd worm-game-flat
```

Godot Editorを開く場合は、次を実行します。

```bash
godot --editor --path .
```

ゲームを直接起動する場合は、次を実行します。

```bash
godot --path .
```

Godot Editorから実行する場合は、プロジェクトを開いた後、画面右上の **Run Project** または `F6` を使用します。


## リポジトリ構成

```text
worm-game-flat/
├── README.md
├── LICENSE
├── project.godot
├── scenes/
│   └── main.tscn
├── scripts/
│   └── main.gd
└── docs/
    ├── design.md
    ├── architecture.md
    └── steps/
        ├── 00-project.md
        ├── 01-draw-one-circle.md
        ├── 02-draw-grid.md
        ├── 03-draw-worm.md
        ├── 04-show-direction.md
        ├── 05-move-at-intervals.md
        ├── 06-end-at-collision.md
        ├── 07-change-direction.md
        ├── 08-follow-the-head.md
        ├── 09-place-food.md
        └── 10-grow.md
```

## 学習の順序

1. Godot プロジェクトを作る
2. 円を一つ描く
3. `N × N` の円を描く
4. 頭と体を描く
5. 頭の向きを小円で表す
6. 一定間隔で自動移動させる
7. 壁または自身との衝突で終了する
8. `h` `j` `k` `l` で方向を変更する
9. 体を頭に追従させる
10. 餌を配置する
11. 餌を食べると体を伸ばす

各文書は、ゲーム側の変化を軸に説明します。Godot の概念は、それが必要になった場所で紹介します。

## 設計上の範囲

このリポジトリでは、次の要素を意図的に扱いません。

- タイトル画面
- 設定画面
- 画像やフォントなどの外部アセット
- BGM・効果音
- パーティクル
- Steamworks 連携
- 複数の操作方式

これらは、完成した最小ゲームを公開作品へ発展させる段階で検討します。

## 次の位置づけ

`worm-game-flat` は Godot とゲーム実装に親しむためのリポジトリです。

Steam への登録、ストアページ、ビルド配布、審査、更新は、別リポジトリ `indie-game-zero-to-publish` で扱う想定です。
