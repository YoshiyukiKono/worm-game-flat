# Architecture

## 全体構成

完成版は、一つの `Node2D` と一つの GDScript で成立します。

```text
Main (Node2D)
└── main.gd
```

最初の教材では、責務分割を先に教えるより、ゲームの状態と画面の対応を一つの場所で確認できることを優先します。

## 主な状態

```gdscript
var worm: Array[Vector2i]
var direction: Vector2i
var pending_direction: Vector2i
var food: Vector2i
var elapsed: float
var game_over: bool
```

ゲーム世界はグリッド座標で管理し、描画時に画面座標へ変換します。

```text
grid coordinate
      ↓
cell_center()
      ↓
screen coordinate
```

## 更新

`_process(delta)` で経過時間を蓄積し、一定時間ごとに一セル移動します。

フレームごとの描画速度と、ゲーム上の移動速度を分離するためです。

## 描画

`_draw()` から次を呼び出します。

```text
draw_ground()
draw_food()
draw_worm()
draw_game_over()
```

状態が変わるたびに `queue_redraw()` を呼び、Godot に再描画を依頼します。

## 将来の分割候補

最小形を理解した後は、次のように分割できます。

```text
Main
├── Board
├── Worm
├── Food
└── UI
```

ただし、この分割は初期版の必須事項ではありません。
