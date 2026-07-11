# 05. 一定間隔で移動させる

## 到達点

入力がなくても、頭が一定間隔で一方向へ進みます。

## 考え方

`_process(delta)` の `delta` を蓄積し、一定値を超えたときだけ一セル進めます。

```gdscript
elapsed += delta

if elapsed >= MOVE_INTERVAL:
    elapsed -= MOVE_INTERVAL
    move_worm()
```

## 確認

ゲームのフレームレートに依存せず、一定速度で頭が移動します。
